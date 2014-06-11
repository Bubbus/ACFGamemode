
AddCSLuaFile()

include("classbase.lua")

DeriveGamemode("fretta_fitenite")
IncludePlayerClasses()

GM.StartTime = SysTime()
GM.Name = "Fite Nite"
GM.GamemodeName = "fitenite"
GM.Author = "Bubbus"
GM.Website	= "https://github.com/Bubbus"




GM.TeamBased = true					// Team based game or a Free For All game?
GM.AllowAutoTeam = true				// Allow auto-assign?
GM.AllowSpectating = true			// Allow people to spectate during the game?
GM.SecondsBetweenTeamSwitches = 10	// The minimum time between each team change?
GM.GameLength = 15					// The overall length of the game
GM.RoundLimit = -1					// Maximum amount of rounds to be played in round based games
GM.VotingDelay = 5					// Delay between end of game, and vote. if you want to display any extra screens before the vote pops up
GM.ShowTeamName = true				// Show the team name on the HUD

GM.NoPlayerSuicide = false			// Set to true if players should not be allowed to commit suicide.
GM.NoPlayerDamage = false			// Set to true if players should not be able to damage each other.
GM.NoPlayerSelfDamage = false		// Allow players to hurt themselves?
GM.NoPlayerTeamDamage = true		// Allow team-members to hurt each other?
GM.NoPlayerPlayerDamage = true	 	// Allow players to hurt each other?
GM.NoNonPlayerPlayerDamage = false 	// Allow damage from non players (physics, fire etc)
GM.NoPlayerFootsteps = false		// When true, all players have silent footsteps
GM.PlayerCanNoClip = false			// When true, players can use noclip without sv_cheats
GM.TakeFragOnSuicide = true			// -1 frag on suicide

GM.MaximumDeathLength = 0			// Player will repspawn if death length > this (can be 0 to disable)
GM.MinimumDeathLength = 5			// Player has to be dead for at least this long
GM.AutomaticTeamBalance = false     // Teams will be periodically balanced 
GM.ForceJoinBalancedTeams = true	// Players won't be allowed to join a team if it has more players than another team
GM.RealisticFallDamage = true		// Set to true if you want realistic fall damage instead of the fix 10 damage.
GM.AddFragsToTeamScore = true		// Adds player's individual kills to team score (must be team based)

GM.NoAutomaticSpawning = false		// Players don't spawn automatically when they die, some other system spawns them
GM.RoundBased = true				// Round based, like CS
GM.RoundLength = 10 * 60			// Round length, in seconds
GM.RoundPreStartTime = 15			// Preperation time before a round starts
GM.RoundPostLength = 8				// Seconds to show the 'x team won!' screen at the end of a round
GM.RoundEndsWhenOneTeamAlive = false// CS Style rules

GM.EnableFreezeCam = true			// TF2 Style Freezecam
GM.DeathLingerTime = 3				// The time between you dying and it going into spectator mode, 0 disables

GM.SelectModel = true               // Can players use the playermodel picker in the F1 menu?
GM.SelectColor = false				// Can players modify the colour of their name? (ie.. no teams)
GM.SelectClass = true

GM.PlayerRingSize = 48              // How big are the colored rings under the player's feet (if they are enabled) ?
GM.HudSkin = "SimpleSkin"			// The Derma skin to use for the HUD components
GM.SuicideString = "comitted sudoku"			// The string to append to the player's name when they commit suicide.
GM.DeathNoticeDefaultColor = Color( 255, 128, 0 ); // Default colour for entity kills
GM.DeathNoticeTextColor = color_white; // colour for text ie. "died", "killed"

GM.ValidSpectatorModes = { OBS_MODE_CHASE, OBS_MODE_IN_EYE, OBS_MODE_ROAMING } // The spectator modes that are allowed
GM.ValidSpectatorEntities = { "player" }	// Entities we can spectate, players being the obvious default choice.
GM.CanOnlySpectateOwnTeam = true; // you can only spectate players on your own team





// Help info
GM.Help = [[It's Fite Nite!  Fight against the enemy team with ACF weapons and vehicles!

Your base has a factory which makes tanks for you.  Capture the fuel flags to let it build!

Capture all of the fuel flags and destroy the enemy factory to win, but watch out for their defence guns!]]



// Called on gamemdoe initialization to create teams
function GM:CreateTeams()
	if !GAMEMODE.TeamBased then
		return
	end
	
	TEAM_ALLIES = 1
	team.SetUp(TEAM_ALLIES, "Allies", Color(150, 205, 255, 255))
	team.SetSpawnPoint(TEAM_ALLIES, {"info_player_counterterrorist", "info_player_combine", "info_player_deathmatch", "info_player_axis"})
	team.SetClass(TEAM_ALLIES, {"Assault", "Engineer", "Tankbuster", "Sniper", "Support"})

	TEAM_COMRADES = 2
	team.SetUp(TEAM_COMRADES, "Comrades", Color(255, 60, 60, 255))
	team.SetSpawnPoint(TEAM_COMRADES, {"info_player_terrorist", "info_player_rebel", "info_player_deathmatch", "info_player_allies"})
	team.SetClass(TEAM_COMRADES, {"Assault", "Engineer", "Tankbuster", "Sniper", "Support"})
end

print("Loaded sh_init")