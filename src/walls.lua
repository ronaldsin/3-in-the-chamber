function createWall(x1, y1, x2, y2)

	local wall = {} -- make wall

	wall.newWidth = 5000
	wall.oldWidth = 1200

	wall.scale = wall.newWidth / wall.oldWidth

	if x1 < x2 then
		wall.left = x1 * wall.scale
		wall.right = x2 * wall.scale

	else
		wall.left = x2 * wall.scale
		wall.right = x1 * wall.scale
	end

	if y1 < y2 then
		wall.top = y1 * wall.scale
		wall.bottom = y2 * wall.scale

	else
		wall.top = y2 * wall.scale
		wall.bottom = y1 * wall.scale
	end


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
			love.graphics.setColor(0, 50, 0)
			love.graphics.setLineWidth(10)
			love.graphics.rectangle( "line", wall.left, wall.top, wall.right - wall.left, wall.bottom - wall.top )
			love.graphics.setLineWidth(1)
			love.graphics.setColor(1, 1, 1)
		end

	end


	return wall

end


-- for bullet use
function checkWallCollision(hitbox)

	for i = 1, #walls do
		if walls[i].check(hitbox) then
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
