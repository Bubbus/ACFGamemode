
local this = inherit.NewSubOf()
this.Name = "FloorCylinder"
this.Radius = 512
this.InnerBound = 64
this.HeightOffset = 256



//if CLIENT then
	function this:Draw(duration)
		for yaw = 0, 360, 45 do
			debugoverlay.Axis( self.Pos, Angle(0, yaw, 0), self.Radius, duration or 0.017, false )
			debugoverlay.Axis( self.Pos + Vector(0, 0, self.HeightOffset / 2), Angle(0, yaw, 180), self.InnerBound, duration or 0.017, false )
			debugoverlay.Axis( self.Pos + Vector(0, 0, self.HeightOffset), Angle(0, yaw, 180), self.Radius, duration or 0.017, false )
		end
	end
//end



function this:Init()
	
end



function this:GetSpawn(ply, spawn)

	local randDir = Angle(0, math.random() * 360, 0):Forward()
	local randDist = (self.Radius - self.InnerBound) * math.sqrt(math.random()) + self.InnerBound
	local projectPos = self.Pos + Vector(0,0,self.HeightOffset) + randDir * randDist
	
	local trace = util.TraceLine({
		start = projectPos,
		endpos = projectPos + Vector(0, 0, -self.HeightOffset),
		mask = MASK_PLAYERSOLID
	})
	
	//print("floorcyl:", randDir, ":", randDist, ":", trace.HitPos - self.Pos)
	
	return trace.HitPos, (-randDir):Angle()
	
end



function this:PostSpawn(ply, spawn)

end



local gm = gminfo.GetGamemodeTable()
gm.SpawnVolume.Register(this)