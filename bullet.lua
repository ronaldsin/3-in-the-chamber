function proj(x, y, r, name)
	--[[
	proj - Object that holds projectile information like coordinates and speed
	]]
	local proj = {}

	proj.name = name

	-- location of bullet
	proj.x = x
	proj.y = y

	-- range and keeps track of how far the bullet has traveled
	proj.range = 1000
	proj.traveled = 0
	proj.width = 5
	proj.height = 10

	-- rotation
	proj.r = r

	-- stats
	proj.speed = 2000
	proj.damage = 10

	-- trig to calculate xspeed y speed
	proj.yVel = proj.speed * math.sin(r - (math.pi / 2))
	proj.xVel = proj.speed * math.cos(r - (math.pi / 2))

	-- image
	proj.Image = love.graphics.newImage("Bullet.png")


	-- updates the projectile on screen, based on ticks with dt length
	function proj.update(dt)
		-- traveled distance
		proj.traveled = proj.traveled + (proj.speed * dt)

		-- update position of bullet
		proj.y = proj.y + proj.yVel * dt
		proj.x = proj.x + proj.xVel * dt
	end

	-- draws projectile on screen
	function proj.draw()
		-- there some fuccy math there I no longer rember what that equation does
		-- params: image, coordx, coordy, xsize scale, ysize scale originx, originy)
		love.graphics.draw(proj.Image, proj.x, proj.y, proj.r, 1.5 * sizeScale, 1.5 * sizeScale, proj.Image:getWidth() / 2, proj.Image:getHeight() * 1.4)
		if displayHitbox then
			love.graphics.rectangle( "line", proj.x - proj.width / hitboxScale, proj.y - proj.height / hitboxScale, proj.Image:getWidth() / hitboxScale, proj.Image:getHeight() / hitboxScale )
		end
	end


	return proj
end
