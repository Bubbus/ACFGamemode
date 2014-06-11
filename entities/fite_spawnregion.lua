include("lib_gminfo.lua")

	///
	///  SHARED SECTION
	///

local gm = gminfo.GetGamemodeTable()
local volumes = gm.SpawnVolumes or error("couldn't find spawn-volumes!")

ENT.Type = "point"



function ENT:CanSpawnPlayer(ply)
	
	local spawn = self.SpawnBinding
	
	if not (IsValid(spawn) and spawn.IsAvailableTo) then return false end
	
	return spawn:IsAvailableTo(ply)
	
end




	///
	///	 CLIENT SECTION
	///

if CLIENT then 


	function ENT:Initialize()

		self.SpawnVolume = volumes.Default:New()
		self.SpawnBinding = NULL

	end
	

elseif SERVER then

	///
	///  SERVER SECTION
	///
	

	function ENT:Initialize()

		self.SpawnVolume = volumes.Default:New()
		self.SpawnBinding = NULL

	end




	function ENT:SetSpawnVolume(volName)
		local vol = volumes[volName]
		if vol and vol.New then
			self.SpawnVolume = vol:New()
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
		
		self:SetNextThink(CurTime() + 0.25)
		
	end




	function ENT:BindToSpawn(ent)
		
		if not (IsValid(ent) and ent.IsAvailableTo) then
			error(tostring(ent) .. " is not compatible with the spawnregion entity.")
		end
		
		self.SpawnBinding = entity
		self.CacheClientUpdate = true
		
	end




	function ENT:UpdateTransmitState()	
		return TRANSMIT_ALWAYS 
	end

end
