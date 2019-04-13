function createWall(x1, y1, x2, y2)
	local wall = {}

	wall.left = x1
	wall.right = x2
	wall.top = y1
	wall.bottom = y2

	function wall.check(hitbox)
		if wall.right > hitbox.left and wall.left < hitbox.right and wall.bottom > hitbox.top and wall.top < hitbox.bottom then
			return true
		end
		return false
	end

	function wall.draw()
		if displayHitbox then
			love.graphics.rectangle( "line", wall.left, wall.top, wall.right - wall.left, wall.bottom - wall.top )
		end
	end


	return wall
end

function checkWallCollision()
	for i = 1, #walls do
		if walls[i].check(p.hitbox) then
			love.audio.play(oof)
			return true
		end
	end
	return false
end
