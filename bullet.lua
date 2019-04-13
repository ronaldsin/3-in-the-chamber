function proj(x, y, r, name, speed, range, type, spread, length)
	--[[
	proj - Object that holds projectile information like coordinates and speed
	]]
	local proj = {}

	-- image
	proj.Image = love.graphics.newImage("resources/".. type ..".png")

	proj.name = name

	-- location of bullet
	proj.x = x + (length * sizeScale) * math.sin(r)
	proj.y = y - (length * sizeScale) * math.cos(r)


	-- range and keeps track of how far the bullet has traveled
	proj.range = range * sizeScale
	proj.traveled = 0
	proj.width = proj.Image:getWidth()
	proj.height = proj.Image:getHeight()

	proj.hitbox = createHitbox(proj.x, proj.y, proj.width, proj.height)

	-- rotation
	proj.r = r

	-- stats
	proj.speed = speed

	-- trig to calculate xspeed y speed
	proj.yVel = (((proj.speed * math.sin(r - (math.pi / 2))) * (1 + ( (rng:random(0, spread)) / 100 ))) + (rng:random(0, spread)) / 100 )
	proj.xVel = (((proj.speed * math.cos(r - (math.pi / 2))) * (1 + ((rng:random(0, spread)) / 100 ))) + (rng:random(0, spread)) / 100 )

	proj.yVel = proj.yVel + (math.pow(proj.yVel, - 1)) + ((rng:random(-spread, spread) / 2) )
	proj.xVel = proj.xVel + (math.pow(proj.xVel, - 1)) + ((rng:random(-spread, spread) / 2) )

	--bulletTime
	proj.OGspeed = proj.speed
	proj.OGxVel = proj.xVel
	proj.OGyVel = proj.yVel

	-- updates the projectile on screen, based on ticks with dt length
	function proj.update(dt)
		-- traveled distance
		proj.traveled = proj.traveled + (proj.speed * dt)

		proj.hitbox.update(proj.x, proj.y)

		local spread = ((rng:random((p.weapon.rng) * ( 1), (p.weapon.rng))) / 1000)
		-- update position of bullet
		proj.y = proj.y + (proj.yVel) * dt
		proj.x = proj.x + (proj.xVel) * dt
	end

	-- draws projectile on screen
	function proj.draw()
		-- there some fuccy math there I no longer rember what that equation does
		-- params: image, coordx, coordy, xsize scale, ysize scale originx, originy)
		--love.graphics.line(proj.x, proj.y, p.x, p.y)
		love.graphics.draw(proj.Image, proj.x, proj.y, proj.r, 1.5 * sizeScale, 1.5 * sizeScale, proj.Image:getWidth() / 2, proj.Image:getHeight() / 20)

		proj.hitbox.draw()

	end


	return proj
end
