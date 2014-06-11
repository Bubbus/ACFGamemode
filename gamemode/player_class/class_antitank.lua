// Create new class

//include("classbase.lua")
local CLASS = {}
table.Merge(CLASS, CLASSBASE)


// Some settings for the class
CLASS.DisplayName			= "Tankbuster"
CLASS.WalkSpeed 			= 150
CLASS.CrouchedWalkSpeed 	= 0.3
CLASS.RunSpeed				= 220
CLASS.DuckSpeed				= 0.3
CLASS.DrawTeamRing			= false


// Called by spawn and sets loadout
function CLASS:Loadout(pl)
	//pl:GiveAmmo(100, "Crossbow")
	//pl:GiveAmmo(15, "Grenade")
	
	print("onspon")
	
	pl:Give("weapon_acf_pistol")
	pl:Give("weapon_acf_mine")
	pl:Give("weapon_acf_smokegrenade")
	pl:Give("weapon_acf_atgl")
	
	local cl_defaultweapon = pl:GetInfo("cl_defaultweapon") 
 	 
 	if pl:HasWeapon(cl_defaultweapon) then 
 		pl:SelectWeapon(cl_defaultweapon)
 	end 
end


// Register
player_class.Register(CLASS.DisplayName, CLASS)