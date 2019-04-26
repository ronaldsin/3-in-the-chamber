function createWall(x1, y1, x2, y2)
	local wall = {} -- make wall

	wall.left = x1
	wall.right = x2
	wall.top = y1
	wall.bottom = y2

	-- wall initialized
	function wall.check(hitbox)
		if wall.right > hitbox.left and wall.left < hitbox.right and wall.bottom > hitbox.top and wall.top < hitbox.bottom then
			return true
		end
		return false
	end

	-- wall drawn
	function wall.draw()
		if displayHitbox then
			love.graphics.rectangle( "line", wall.left, wall.top, wall.right - wall.left, wall.bottom - wall.top )
		end
	end

	return wall
end

-- for bullet use
function checkWallCollision(hitbox)
	for i = 1, #walls do
		if walls[i].check(hitbox) then
			love.audio.play(oof)
			return true
		end
	end
	return false
end

-- for player/monster use
function checkWallCollisionRight(hitbox, x)
	for i = 1, #walls do
		-- first checks if the wall intersects the hitbox
		if walls[i].right > hitbox.left + x and walls[i].left < hitbox.right + x and walls[i].bottom > hitbox.top and walls[i].top < hitbox.bottom then
			-- returns true if moving hitbox to the right still intersects with wall
			if (walls[i].left < (hitbox.right + x)) and (walls[i].right > (hitbox.right + x)) then
				print("test")
				return true
			end
		end
	end
	return false
end

function checkWallCollisionLeft(hitbox, x)
	-- refer to checkWallCollisionRight for comments
	for i = 1, #walls do
		if walls[i].right > hitbox.left - x and walls[i].left < hitbox.right - x and walls[i].bottom > hitbox.top and walls[i].top < hitbox.bottom then
			if walls[i].right > hitbox.left - x and walls[i].left < hitbox.left - x then
				return true
			end
		end
	end
	return false
end

function checkWallCollisionTop(hitbox, y)
	-- refer to checkWallCollisionRight for comments
	for i = 1, #walls do
		if walls[i].right > hitbox.left and walls[i].left < hitbox.right and walls[i].bottom > hitbox.top - y and walls[i].top < hitbox.bottom - y then
			if walls[i].bottom > hitbox.top - y and walls[i].top < hitbox.top - y then
				return true
			end
		end
	end
	return false
end

function checkWallCollisionBottom(hitbox, y)
	-- refer to checkWallCollisionRight for comments
	for i = 1, #walls do
		if walls[i].right > hitbox.left and walls[i].left < hitbox.right and walls[i].bottom > hitbox.top + y and walls[i].top < hitbox.bottom + y then
			if walls[i].top < hitbox.bottom + y and walls[i].bottom > hitbox.bottom + y then

				return true
			end
		end
	end
	return false
end
