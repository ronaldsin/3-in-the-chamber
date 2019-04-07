function createWeapon(name, damage, cd, speed, range, magazine)
	local weapon = {}

	-- orientation
	-- weapon.r = 0 -- edit this to have an angle if it exists later

	-- stats
	weapon.state = "ranged"
	weapon.damage = damage
	weapon.magazine = magazine
	weapon.clip = magazine
	weapon.gunCd = cd
	weapon.speed = speed
	weapon.range = range

	-- sprites
	weapon.gunfire = love.graphics.newImage("resources/gunfire.png")
	weapon.image = love.graphics.newImage("resources/" .. name .. ".png")

	-- function weapon.reload()
	-- 	-- play animation
	-- 	-- delay for whatever amount
	-- 	weapon.clip = weapon.magazine
	-- end
	--
	-- function weapon.fire()
	--
	-- end

	function weapon.update()
		-- if clip > 0 and LMB clicked
		-- shoot, clip -= 1
		-- elseif clip = 0 and LMB clicked
		-- reload? (optional)
		-- maybe even make this a toggleable option
	end

	function weapon.draw(x, y, r)
		love.graphics.draw(weapon.image, x, y, r, 1 * sizeScale, 1 * sizeScale, weapon.image:getWidth() / 2, weapon.image:getHeight() / 2)
	end

	return weapon
end
