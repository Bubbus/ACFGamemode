// Create new class

//include("classbase.lua")
local CLASS = {}
table.Merge(CLASS, CLASSBASE)


// Some settings for the class
CLASS.DisplayName			= "Support"
CLASS.WalkSpeed 			= 160
CLASS.CrouchedWalkSpeed 	= 0.3
CLASS.RunSpeed				= 280
CLASS.DuckSpeed				= 0.3
CLASS.DrawTeamRing			= false


// Called by spawn and sets loadout
function CLASS:Loadout(pl)
	pl:GiveAmmo(500, "Crossbow")
	pl:GiveAmmo(3, "Grenade")
	
	pl:Give("weapon_acf_lmg")
	pl:Give("weapon_acf_pistol")
	pl:Give("weapon_acf_grenade")
	
	local cl_defaultweapon = pl:GetInfo("cl_defaultweapon") 
 	 
 	if pl:HasWeapon(cl_defaultweapon) then 
 		pl:SelectWeapon(cl_defaultweapon)
 	end 
end


// Register
player_class.Register(CLASS.DisplayName, CLASS)