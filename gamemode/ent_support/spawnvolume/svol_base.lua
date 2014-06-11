
local this = inherit.NewSubOf()
this.Name = "Base"


function this:Init()
	
	ErrorNoHalt("Reached the base spawn volume implementation of Init")
	
end



function this:GetSpawnPos()

	ErrorNoHalt("Reached the base spawn volume implementation of GetSpawnPos")

	return Vector(0,0,0)

end



function this:PostSpawn(ply, pos)

	ErrorNoHalt("Reached the base spawn volume implementation of PostSpawn")

end



function this.SetKeyValue(key, val)
	
	ErrorNoHalt("Reached the base spawn volume implementation of SetKeyValue")
	
	if this[key] == nil then return false end
	
	this[key] = val
	return true
	
end


local gm = gminfo.GetGamemodeTable()
gm.SpawnVolume.Register(this)