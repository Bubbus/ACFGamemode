
local this = inherit.NewSubOf()
this.Name = "FloorCylinder"
this.Radius = 128
this.InnerBound = 32
this.HeightOffset = 128



if CLIENT then
	function this:Draw()
		for yaw = 0, 360, 120 do
			debugoverlay.Axis( self.Pos, Angle(0, yaw, 0), self.Radius, 0.017, false )
			debugoverlay.Axis( self.Pos + self.HeightOffset, Angle(0, yaw, 180), self.Radius, 0.017, false )
		end
	end
end



function this:Init()
	
end



function this:GetSpawn(ply, spawn)

	local randDir = Angle(0, math.random() * 360, 0):Forward()
	local randDist = (self.Radius - self.InnerBound) * (math.random() ^ 0.5) + self.InnerBound
	local projectPos = self.Pos + self.HeightOffset + randDir * randDist

	local trace = util.TraceLine({
		start = projectPos
		endpos = projectPos + Vector(0, 0, -self.HeightOffset)
		mask = MASK_PLAYERSOLID
	})
	
	return trace.HitPos, -randDir:Angle()
	
end



function this:PostSpawn(ply, spawn)

end



local gm = gminfo.GetGamemodeTable()
gm.SpawnVolume.Register(this)