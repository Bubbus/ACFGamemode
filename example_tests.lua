
local function testSpawnRegion()
	if IsValid(sregion) then sregion:Remove() end
	if IsValid(sponent) then sponent:Remove() end

	local pos = player.GetAll()[1]:GetEyeTrace().HitPos

	sregion = ents.Create("fite_spawnregion")
	sregion:SetPos(pos)
	sregion:Spawn()

	sponent = ents.Create("prop_physics")
	sponent:SetPos(pos + Vector(0,0,16))
	sponent:SetModel("models/weapons/w_rif_galil.mdl")
	sponent:Spawn()
	sponent.IsAvailableTo = function(ent, ply) return true end

	sregion:BindToSpawn(sponent)
	sregion:SetSpawnVolume(FITENITE.SpawnVolume.FloorCylinder())
end



local function testFlag()
	if IsValid(sregion) then sregion:Remove() end
	if IsValid(fiteflag) then fiteflag:Remove() end

	local trace = player.GetAll()[1]:GetEyeTrace()
	local pos = trace.HitPos
	//local norm = trace.HitNormal

	sregion = ents.Create("fite_spawnregion")
	sregion:SetPos(pos)
	sregion:Spawn()
	
	fiteflag = ents.Create("fite_flag")
	fiteflag:SetPos(pos)
	fiteflag:SetAngles(Angle(0,0,0))
	fiteflag:Spawn()
	fiteflag.IsAvailableTo = function(ent, ply) return ply:Team() == ent.Team end
	
	sregion:BindToSpawn(fiteflag)
	sregion:SetSpawnVolume(FITENITE.SpawnVolume.FloorCylinder())
end


testFlag()