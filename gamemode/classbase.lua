// Create new class
CLASSBASE = CLASSBASE or {}
local CLASS = CLASSBASE


// Some settings for the class
CLASS.DisplayName			= "Base"
CLASS.WalkSpeed 			= 160
CLASS.CrouchedWalkSpeed 	= 0.3
CLASS.RunSpeed				= 280
CLASS.DuckSpeed				= 0.3
CLASS.DrawTeamRing			= false
CLASS.JumpPower				= 200
CLASS.PlayerModel			= "models/player.mdl"
CLASS.DrawViewModel			= true
CLASS.CanUseFlashlight      = true
CLASS.MaxHealth				= 100
CLASS.StartHealth			= 100
CLASS.StartArmor			= 0
CLASS.RespawnTime           = 0 // 0 means use the default spawn time chosen by gamemode
CLASS.DropWeaponOnDie		= false
CLASS.TeammateNoCollide 	= true
CLASS.AvoidPlayers			= true // Automatically avoid players that we're no colliding
CLASS.Selectable			= true // When false, this disables all the team checking
CLASS.FullRotation			= false // Allow the player's model to rotate upwards, etc etc


// Called by spawn and sets loadout
function CLASS:Loadout(pl)
	
end


// Called when player spawns with this class
function CLASS:OnSpawn(pl)

end


// Called when a player dies with this class
function CLASS:OnDeath(pl, attacker, dmginfo)

end


// Register
//player_class.Register(CLASS.DisplayName, CLASS)