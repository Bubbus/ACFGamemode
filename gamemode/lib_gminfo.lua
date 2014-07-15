// Support library for generic gamemode info


gminfo = gminfo or {}
local this = gminfo

/// SHARED

function this.GetGamemodeTable()
	return FITENITE or error("gamemode table has not been initialized.")
end



if team then
	team.GetPlayingTeams = function()
		ret = team.GetAllTeams()
		ret[TEAM_CONNECTING] = nil
		ret[TEAM_SPECTATOR] = nil
		ret[TEAM_UNASSIGNED] = nil
		
		return ret
	end
end



if CLIENT then

elseif SERVER then

end