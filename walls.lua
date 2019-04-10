function createWall(x, y, width, height)
	local wall = {}

	wall.hitbox = createHitbox(x, y, width, height)

	function wall.check(hitbox)
		return hitReg(wall.hitbox, hitbox)
	end

	return wall
end

function checkWallCollision()
	for i = 1, #walls do
		if walls[i].check(p.hitbox) then
			return true
		end
	end
	return false
end
