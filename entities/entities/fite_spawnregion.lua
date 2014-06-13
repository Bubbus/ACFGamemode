//include("lib_gminfo.lua")
AddCSLuaFile()

	///
	///  SHARED SECTION
	///

local gm = gminfo.GetGamemodeTable()
local volumes = gm.SpawnVolume or error("couldn't find spawn-volumes!")

ENT.Type = "point"



function ENT:CanSpawnPlayer(ply)
	
	local spawn = self.SpawnBinding
	//print("entspawn", tostring(spawn))
	if not (IsValid(spawn) and spawn.IsAvailableTo) then return false end
	
	return spawn:IsAvailableTo(ply)
	
end




	///
	///	 CLIENT SECTION
	///

if CLIENT then 


	function ENT:Initialize()

		self.SpawnVolume = volumes.Base()
		self.SpawnBinding = NULL

	end
	
	
	
	
	--function ENT:Think()
	
		-- if self.SpawnVolume and self.SpawnVolume.Draw then
			-- self.SpawnVolume:Draw(0.25)
		-- end
		
		-- self:NextThink(CurTime() + 0.25)
		
	-- end
	
	

elseif SERVER then

	///
	///  SERVER SECTION
	///
	

	function ENT:Initialize()

		self.SpawnVolume = volumes.Base()
		self.SpawnBinding = NULL

		local setpos = self.SetPos
		
		self.SetPos = function(self, pos)
			setpos(self, pos)
			self:KeyValue("Pos", self:GetPos())
		end
		
		self:KeyValue("Pos", self:GetPos())
		
	end




	function ENT:SetSpawnVolume(vol)

		if vol and vol.Name and volumes[vol.Name] then
			self.SpawnVolume = vol
			self:KeyValue("Pos", self:GetPos())
			self.CacheClientUpdate = true
		else
			error(tostring(volName) .. " is not a valid spawn volume.")
		end
		
	end




	function ENT:KeyValue( key, value )
		
		local vol = self.SpawnVolume
		
		if vol and vol.SetKeyValue then
			local res = vol:SetKeyValue(key, value)
			if res then self.CacheClientUpdate = true end
		end
		
	end




	function ENT:Think()
		
		if self.CacheClientUpdate then
			self:UpdateClient()
			self.CacheClientUpdate = false
		end
		
		
		if self.SpawnVolume and self.SpawnVolume.Draw then
			self.SpawnVolume:Draw(0.25)
		end
		
		self:NextThink(CurTime() + 0.25)
		
	end
	
	
	
	
	function ENT:UpdateClient()
		// TODO: this
	end




	function ENT:BindToSpawn(ent)
		
		if not (IsValid(ent) and ent.IsAvailableTo) then
			error(tostring(ent) .. " is not compatible with the spawnregion entity.")
		end
		
		self.SpawnBinding = ent
		self.CacheClientUpdate = true
		
	end




	function ENT:UpdateTransmitState()	
		return TRANSMIT_ALWAYS 
	end
	
	
	
	
	function ENT:DoSpawn(ply)
		//print("spone")
		if not self.SpawnBinding:IsAvailableTo(ply) then error("Tried spawning " .. tostring(ply) .. " at a spawnpoint unavailable to them.") end
		
		local pos, ang = self.SpawnVolume:GetSpawn(ply, self.SpawnBinding)
		
		ply:SetPos(pos)
		
		if ang then
			ply:SetEyeAngles(ang)
		end
		
		self.SpawnVolume:PostSpawn(ply, self.SpawnBinding)
	end

	
	
	
	function gm.Spawnpoint_OnPlayerSpawn( ply )
		
		//print("sponen")
		
		local spawn = ply:GetNWEntity("FiteSpawn")
		
		if not IsValid(spawn) then
			for k, ent in pairs(ents.FindByClass("fite_spawnregion")) do
				//print("sponent", tostring(ent))
				if ent:CanSpawnPlayer(ply) then
					spawn = ent
					break
				end
			end
			//print("spawn", tostring(spawn))
			if not IsValid(spawn) then return end
		end
		
		spawn:DoSpawn(ply)
		
	end
	hook.Add("PlayerSpawn", "Spawnpoint_OnPlayerSpawn", gm.Spawnpoint_OnPlayerSpawn)
	
end
