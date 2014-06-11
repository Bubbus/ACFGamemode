

include("cl_init.lua")
include("sh_init.lua")

DeriveGamemode("fretta_fitenite")



if file.Exists("../gamemodes/" .. GM.GamemodeName .. "/gamemode/maps/"..game.GetMap()..".lua", "LUA") then
	AddCSLuaFile("maps/"..game.GetMap()..".lua")
end



//function GM:CheckPlayerDeathRoundEnd()

//end



// Called when player tries to pickup a weapon
//function GM:PlayerCanPickupWeapon(pl, ent)
	
//	return true
//end



// Called when player needs a model
//function GM:PlayerSetModel(pl)
	//local player_model = "models/Gibs/Antlion_gib_small_3.mdl"
	
	//if pl:Team() == TEAM_HUNTERS then
		//player_model = "models/player/combine_super_soldier.mdl"
	//end
	
	//util.PrecacheModel(player_model)
	//pl:SetModel(player_model)
//end


// Called when a player tries to use an object
function GM:PlayerUse(pl, ent)
	if not pl:Alive() or pl:Team() == TEAM_SPECTATOR then return false end
	
	return true
end


// Called when player presses [F3]. Plays a taunt for their team
//function GM:ShowSpare1(pl)
	//if GAMEMODE:InRound() && pl:Alive() && 
	//end	
//end




// Called when the gamemode is initialized
function Initialize()
end
hook.Add("Initialize", "PH_Initialize", Initialize)


// Called when a player leaves
function PlayerDisconnected(pl)
end
hook.Add("PlayerDisconnected", "PH_PlayerDisconnected", PlayerDisconnected)


// Called when the players spawns
/*
function PlayerSpawn(pl)

	//pl:ResetHull()
	umsg.Start("ResetHull", pl)
	umsg.End()
	
end
hook.Add("PlayerSpawn", "PH_PlayerSpawn", PlayerSpawn)


// Called when round ends
function RoundEnd()

end
hook.Add("RoundEnd", "PH_RoundEnd", RoundEnd)
//*/


// This is called when the round time ends (props win)
/*
function GM:RoundTimerEnd()
	if !GAMEMODE:InRound() then
		return
	end
   
	GAMEMODE:RoundEndWithResult(TEAM_PROPS, "Props win!")
end
//*/


// Called before start of round
function GM:OnPreRoundStart(num)
	game.CleanUpMap()
	
	UTIL_StripAllPlayers()
	UTIL_SpawnAllPlayers()
	UTIL_FreezeAllPlayers()
end


/*
function GM:CheckPlayerDeathRoundEnd()
end
//*/