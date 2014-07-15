AddCSLuaFile()


ENT.PrintName		= "Fite Flag"
ENT.Author			= "Bubbus"
ENT.Information		= "it wiggles"
ENT.Category		= "Fite Nite"
ENT.WireDebugName 	= "Fite Flag"

ENT.Editable			= true
ENT.Spawnable			= true
ENT.AdminOnly			= true
ENT.RenderGroup 		= RENDERGROUP_TRANSLUCENT
ENT.Type 				= "point"


//*
if CLIENT then


	function ENT:Draw()
		--self:DoNormalDraw()
		self.BaseClass.Draw( self )	
		Wire_Render(self)
	end

	
	
	
	function ENT:Initialize()
		//self.BaseClass.Initialize(self)
		
		self:MakeFlag()
		
		self.timeDiff = 0
		self.lastServRecv = CurTime() - 0.25
		self.lastServCap = 0
		self.curServCap = 0
		self.curVisCap = 0
		self.smoothFactor = 0
		
		self.ThinkDelay = 1/33
		
	end
	
	
	
	
	function ENT:MakeFlag()
		print("making flag")
		
		self.FlagEnts = self.FlagEnts or {}
		for k, v in pairs(self.FlagEnts) do
			v:Remove()
		end
		self.FlagEnts = {}
		
		local flag = ents.CreateClientProp("models/props_debris/metal_panel02a.mdl")
		local base = ents.CreateClientProp("models/props_debris/metal_panel02a.mdl")
		local mast1 = ents.CreateClientProp("models/props_debris/metal_panel02a.mdl")
		local mast2 = ents.CreateClientProp("models/props_debris/metal_panel02a.mdl")
		
		self.FlagEnts[#self.FlagEnts+1] = flag
		self.FlagEnts[#self.FlagEnts+1] = base
		self.FlagEnts[#self.FlagEnts+1] = mast1
		self.FlagEnts[#self.FlagEnts+1] = mast2
		
		for k, v in pairs(self.FlagEnts) do
			if not v:IsValid() then 
				for a, b in pairs(self.FlagEnts) do
					if IsValid(b) then b:Remove() end
				end 
				
				error("Couldn't make a Fite Flag!")
				return
			end
		end
		
		--print(ent)
		
		flag:SetModel("models/props_debris/metal_panel02a.mdl")
		flag:SetAngles(self:LocalToWorldAngles(Angle(0,-90,0)))
		flag:SetPos(self:LocalToWorld(Vector(0, 34, 190)))
		flag:Spawn()
		flag:SetMaterial("sprops/textures/sprops_metal6")
		flag.Owner = self.Owner
		self.Flag = flag
		
		
		base:SetModel("models/props_c17/pulleywheels_large01.mdl")
		base:SetAngles(self:LocalToWorldAngles(Angle(90,0,0)))
		base:SetPos(self:LocalToWorld(Vector(0, 0, 5)))
		base:Spawn()
		base.Owner = self.Owner
		
		
		mast1:SetModel("models/props_c17/signpole001.mdl")
		mast1:SetAngles(self:LocalToWorldAngles(Angle(0,0,0)))
		mast1:SetPos(self:LocalToWorld(Vector(0, 0, 5)))
		mast1:Spawn()
		mast1.Owner = self.Owner
		
		
		mast2:SetModel("models/props_c17/signpole001.mdl")
		mast2:SetAngles(self:LocalToWorldAngles(Angle(0,0,0)))
		mast2:SetPos(self:LocalToWorld(Vector(0, 0, 111)))
		mast2:Spawn()
		mast2.Owner = self.Owner
		
		
		self:CallOnRemove( "FlagRemProps",
			function()
				for k, v in pairs(self.FlagEnts) do
					if IsValid(v) then v:Remove() end
				end
			end )
	end
	
	
	
	
	function ENT:Think()

		self.BaseClass.Think(self)
	
		if IsValid(self.Flag) then
			self:DoFlagFX()			
		else
			self:MakeFlag()
		end
		
		self:DoHighlight()

		self:NextThink(CurTime() + self.ThinkDelay)
		
	end
	
	
	
	
	function ENT:DoFlagFX()
		local wiggle = math.sin(CurTime()*1)*20 + math.sin(CurTime()*10)*5
		local newang = self:LocalToWorldAngles(Angle(0, wiggle, 90))
		self.Flag:SetAngles(newang)
		
		local servcap = self:GetNetworkedFloat("CaptureProg", 0)
		//*
		if servcap ~= self.curServCap then
			self.timeDiff = CurTime() - self.lastServRecv
			self.lastServRecv = CurTime()
			self.lastServCap = self.curServCap
			self.curServCap = servcap
			self.curVisCap = self.lastServCap
			self.smoothFactor = 1*((self.curServCap - self.lastServCap) / self.timeDiff * self.ThinkDelay)
		end

		//if self.lastServCap == 1 and self.curServCap == 0 then self.curVisCap = 1 end
		
		self.curVisCap = math.Clamp(self.curVisCap + self.smoothFactor, math.min(self.lastServCap, self.curServCap), math.max(self.lastServCap, self.curServCap))
		//*/
		
		//local capture = servcap//self.curVisCap
		local capture = self.curVisCap
		local capcol  = self:GetNWVector("FlagCol", Vector( 255, 255, 255 ) )
		
		local cappos = 40 + 150 * math.abs(1 - capture*2)
		
		self.Flag:SetPos(self:LocalToWorld(Vector(0, 0, cappos)) + newang:Up() * 34)
		self.Flag:SetColor(Color(capcol.x, capcol.y, capcol.z, 255))
	end
	
	
	
	
	function ENT:DoHighlight()
	end
	
	
	
	
	return

end
//*/


function ENT:Initialize()

	-- self:SetModel("models/props_c17/pulleywheels_large01.mdl")
	-- self:SetAngles(Angle(90,0,0))
	-- self:SetPos(self:GetPos() + Vector(0, 0, 20))
	
	-- self:PhysicsInit( SOLID_VPHYSICS )      	
	-- self:SetMoveType( MOVETYPE_VPHYSICS )     	
	-- self:SetSolid( SOLID_VPHYSICS )
	-- self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	
	-- self:GetPhysicsObject():EnableMotion(false)
	
	self.SpecialDamage = true
	
	//self:MakeFlagProps()
	
	self.CaptureRadius = 512
	self.CaptureTime = 2
	self.CaptureDecayRatio = 0.25
	self.CaptureProgress = 0
	self.CaptureLock = false
	
	self.Team = "none"
	self.ThinkDelay = 0.2
	
	-- if NADMOD then NADMOD.SetOwnerWorld(self) NADMOD.PropOwnersSmall[self:EntIndex()] = "W" end
	
end




function ENT:UpdateTransmitState()	
	return TRANSMIT_ALWAYS 
end




// A template for the result of an unpermitted damage attempt.
local rejectHitRes =
{
	["Damage"] = 0,
	["Overkill"] = 0,
	["Loss"] = 0,
	["Kill"] = false
}

function ENT:ACF_OnDamage( Entity , Energy , FrAera , Angle , Inflictor )
	self:SetColor(Color(math.random()*255, math.random()*255, math.random()*255, 255))
	return table.Copy(rejectHitRes)
end




-- function ENT:MakeFlagProps()
	-- local pole1, pole2

	-- local ent = ents.Create("prop_physics")
	-- if not ent:IsValid() then self:Remove() error("Couldn't make a Fite Flag!") return end
	
	-- ent:SetModel("models/props_c17/signpole001.mdl")
	-- ent:SetAngles(self:LocalToWorldAngles(Angle(-90,-0,0)))
	-- ent:SetPos(self:LocalToWorld(Vector(-5, 0, 0)))
	-- ent:Spawn()
	-- ent:GetPhysicsObject():EnableMotion(false)
	-- ent:SetParent(self)
	-- ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	
	-- ent.Owner = self.Owner
	-- ent.SpecialDamage = true
	-- ent.ACF_OnDamage = self.ACF_OnDamage
	
	-- if NADMOD then NADMOD.SetOwnerWorld(ent) NADMOD.PropOwnersSmall[ent:EntIndex()] = "W" end
	-- pole1 = ent
	
	
	-- local ent = ents.Create("prop_physics")
	-- if not ent:IsValid() then self:Remove() error("Couldn't make a Fite Flag!") return end
	-- ent:SetModel("models/props_c17/signpole001.mdl")
	-- ent:SetAngles(self:LocalToWorldAngles(Angle(-90,-0,0)))
	-- ent:SetPos(self:LocalToWorld(Vector(-111, 0, 0)))
	-- ent:Spawn()
	-- ent:GetPhysicsObject():EnableMotion(false)
	-- ent:SetParent(self)
	-- ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	
	-- ent.Owner = self.Owner
	-- ent.SpecialDamage = true
	-- ent.ACF_OnDamage = self.ACF_OnDamage
	
	-- if NADMOD then NADMOD.SetOwnerWorld(ent) NADMOD.PropOwnersSmall[ent:EntIndex()] = "W" end
	-- pole2 = ent

	-- self.Props = {pole1, pole2}
	
	-- self:CallOnRemove( "FlagRemProps", self.DeleteFlagProps, self )
	
-- end




-- function ENT:DeleteFlagProps()
	-- for k, v in pairs(self.Props) do
		-- if IsValid(v) then v:Remove() end
	-- end
-- end


local function getTeamCaptureSpeeds(self, teams)

	teams = teams or team.GetPlayingTeams()
		
	local pos = self:GetPos()
		
	for k, v in pairs(player.GetAll()) do
		if pos:Distance(v:GetPos()) < self.CaptureRadius and teams[v:Team()] then
			self.Captors[#self.Captors+1] = v
		end
	end
	

	local cappers = {}
	for k, v in pairs(self.Captors) do
		local capspeed = cappers[v:Team()]
		cappers[v:Team()] = (capspeed or 0) + 1
	end
	
	return cappers
end




local defaultTeam = {col = Color(255, 255, 255)}
function ENT:Think()

	if not self.CaptureLock then		

		self.Captors = {}
		local thinkdelay = self.ThinkDelay
		
		local teams = team.GetPlayingTeams()
		local cappers = getTeamCaptureSpeeds(self, teams)
		
		local captors, capspeed, contested = nil, 0, false
		
		local capCount = table.Count(cappers)
		
		if capCount == 1 and not cappers[self.Team] then
			--print("1capper")
			captors = next(cappers)
			capspeed = cappers[captors]
			
		elseif capCount > 0 then		
			--print(capCount .. "multicapper")
			
			local max = -1
			local min = 999
			for k, v in pairs(cappers) do
				if v > max then
					captors = k
					max = v
				end
				
				if v < min then min = v end
			end
			
			
			for k, v in pairs(cappers) do
				if v == max and k ~= captors then
					captors = nil
					contested = true
					max = v
				end
				
				v = v - min
				cappers[k] = v
			end
			
			
			capspeed = 0
			//print("aaa", captors, captors == self.Team)
			if captors then
				if (captors == self.Team) or (self.CurrentCaptor and captors ~= self.CurrentCaptor) then
					capspeed = -cappers[captors]
				else
					capspeed = cappers[captors]
				end
			else
				capspeed = contested and 0 or -self.CaptureDecayRatio
			end
			
		else
		
			--print("nocapper")
		
			captors = nil
			capspeed = -self.CaptureDecayRatio
		
		end
		
		
		--print(self.Team, captors, captors == self.Team, capspeed, contested)
		
		
		self.CaptureProgress = math.Clamp(self.CaptureProgress + thinkdelay * capspeed * (1 / self.CaptureTime), 0, 1)
		self:SetNWFloat("CaptureProg", self.CaptureProgress)
		
		if captors and not self.CaptureLock then
			self.CurrentCaptor = captors
			
			if self.CaptureProgress == 0.5 then
				self:SetNWVector("FlagCol", Vector(255, 255, 255) )
			elseif self.CaptureProgress > 0.5 then
				local col = teams[captors].Color or Color(255, 0, 255)
				self:SetNWVector("FlagCol", Vector(col.r, col.g, col.b) )
			end
		else			
			if self.CaptureProgress < 0.5 then
				local col = (teams[self.Team] or defaultTeam).Color or Color(255, 255, 255)
				self:SetNWVector("FlagCol", Vector(col.r, col.g, col.b) )
			end
		end
		
		
		if self.CaptureProgress == 1 then
			local oldteam = self.Team
		
			self.Team = captors
			self.CaptureProgress = 0
			
			hook.Call("Fite_FlagCapture", nil, self, self.Team, oldteam )
			
		end
		
		
		if self.CaptureProgress == 0 then
			self.CurrentCaptor = nil
		end
	
	end
	
	self:NextThink(CurTime() + self.ThinkDelay)
	
end


-- function ENT:SetNextFlag(flag)
	-- if not (IsValid(flag) and flag:GetClass() == "fite_flag") then error("Tried to set successor fite flag to " .. tostring(flag)) return end
	
	-- self.NextFlag = flag
	
	-- flag.Team = self.Team
	-- flag.CaptureProgress = 0
	-- flag:SetNWFloat("CaptureProg", 0)
	-- flag.CaptureLock = true
	-- flag:SetNWFloat("CaptureLock", true)
	-- flag:SetPrevFlag(self)
-- end


-- function ENT:SetPrevFlag(flag)
	-- if not (IsValid(flag) and flag:GetClass() == "fite_flag") then error("Tried to set predecessor fite flag to " .. tostring(flag)) return end
	
	-- self.PrevFlag = flag
-- end
