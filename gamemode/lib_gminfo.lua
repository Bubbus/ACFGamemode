// Support library for generic gamemode info


gminfo = gminfo or {}
local this = gminfo

/// SHARED

function this.GetGamemodeTable()
	return FITENITE or error("gememode table has not been initialized.")
end



if CLIENT then

elseif SERVER then

end