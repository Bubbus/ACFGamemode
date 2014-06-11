// Support library for spawn volumes

include("lib_gminfo.lua")
include("lib_inherit.lua")

local gm = gminfo.GetGamemodeTable()
gm.SpawnVolume = gm.SpawnVolume or {}
local this = gm.SpawnVolume


function this.Register(vol)
	
	if not (vol and vol.Name) then error("volumes need a name to be registered!")
	
	inherit.SetSuper(vol, this.Base)
	
	this[vol.Name] = vol
	
end


include("ent_support/spawnvolume/svol_base.lua")
aaa_IncludeShared("ent_support/spawnvolume/volumes")
