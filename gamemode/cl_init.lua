if SERVER then
	AddCSLuaFile()
	return
end


// Include the needed files
include("sh_init.lua") 


// Draw round timeleft and hunter release timeleft
/*
function HUDPaint()
	if GetGlobalBool("InRound", false) then
		
	end
end
hook.Add("HUDPaint", "PH_HUDPaint", HUDPaint)
//*/


// Called immediately after starting the gamemode 
//function Initialize()
/*
	hullz = 80
	//surface.CreateFont("Arial", 14, 1200, true, false, "ph_arial")
	surface.CreateFont( "MyFont",
	{
		font	= "Arial",
		size	= 14,
		weight	= 1200,
		antialias = true,
		underline = false
	})
	//*/
//end
//hook.Add("Initialize", "PH_Initialize", Initialize)


// Resets the player hull
/*
function ResetHull(um)

end
usermessage.Hook("ResetHull", ResetHull)



// Sets the player hull
function SetHull(um)

end
usermessage.Hook("SetHull", SetHull)
//*/