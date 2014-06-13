// Support library for spawn volumes

local gm = gminfo.GetGamemodeTable()
gm.SpawnVolume = gm.SpawnVolume or {}
local this = gm.SpawnVolume


function this.Register(vol)
	
	if not (vol and vol.Name) then error("volumes need a name to be registered!") end
	
	inherit.SetSuper(vol, this.Base)
	
	this[vol.Name] = vol
	
end


include("svol_base.lua")
aaa_IncludeShared("ent_support/spawnvolume/volumes")
