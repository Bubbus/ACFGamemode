
local this = inherit.NewSubOf()
this.Name = "Base"
this.Pos = Vector(0,0,0)



//if CLIENT then
	function this:Draw(duration)
		debugoverlay.Cross( self.Pos, 12, duration or 0.017, Color(255, 128, 0), false)
	end
//end



function this:Init()
	
	ErrorNoHalt("Reached the base spawn volume implementation of Init\n")
	
end



function this:GetSpawn(ply, spawn)

	ErrorNoHalt("Reached the base spawn volume implementation of GetSpawnPos\n")

	return IsValid(spawn) and spawn:GetPos() or Vector(0,0,0)

end



function this:PostSpawn(ply, spawn)

	ErrorNoHalt("Reached the base spawn volume implementation of PostSpawn\n")

end



function this:SetKeyValue(key, val)
	
	ErrorNoHalt("Reached the base spawn volume implementation of SetKeyValue\n")
	
	if self[key] == nil then return false end
	
	self[key] = val
	return true
	
end


local gm = gminfo.GetGamemodeTable()
gm.SpawnVolume.Register(this)