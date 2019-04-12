function createWeapon(name, damage, cd, speed, range, magazine, currentAmmo, reload, pickup, mode, stance, rng)
	local weapon = {}

	-- sprites
	weapon.name = name

	weapon.image = createAnimation(name, 4, 20 + (5 / (cd * 4)), 2, 2, 1, 256, 256)

	weapon.pickedUp = pickup

	-- orientation
	weapon.r = 0 -- edit this to have an angle if it exists later
	weapon.x = 0
	weapon.y = 0
	weapon.width = 256
	weapon.height = 256

	weapon.rng = rng


	weapon.hitbox = createHitbox(weapon.x, weapon.y, weapon.width * 4, weapon.height * 2)

	-- stats
	-- states:
	-- 0: ranged
	-- 1: melee
	-- modes:
	-- 1: semi-auto
	-- 2: full auto
	-- 3: TO BE ADDED IN THE FUTURE
	weapon.state = 0
	weapon.damage = damage
	weapon.magazine = magazine
	weapon.currentAmmo = currentAmmo
	weapon.reload = reload
	weapon.gunCd = cd
	weapon.speed = speed
	weapon.range = range
	weapon.mode = mode
	weapon.stance = stance -- 1 = small, 2 = large

	weapon.counter = 0

	-- function weapon.reload()
	-- 	-- play animation
	-- 	-- delay for whatever amount
	-- 	weapon.clip = weapon.magazine
	-- end
	--
	-- function weapon.fire()
	--
	-- end
	function weapon.fire()
		if weapon.currentAmmo == 0 then
			weapon.counter = weapon.reload
			for i = 1, 2 do
				playSound(reloadingStart)
			end

			return false
		end

		if weapon.currentAmmo > 0 then
			weapon.currentAmmo = weapon.currentAmmo - 1
			print(weapon.name ..": Current Ammo " .. weapon.currentAmmo)
			return true
		end



	end


	function weapon.update(x, y, r, dt)
		weapon.x = x
		weapon.y = y
		weapon.r = r

		weapon.hitbox.update(x, y)

		if weapon.counter > 0 then
			--print("reloading")
			weapon.counter = weapon.counter - dt

			if weapon.counter <= 0 then
				playSound(reloadingEnd)
				p.shoot = 0.4

				weapon.currentAmmo = weapon.magazine
				print("current ammo " .. weapon.currentAmmo)
			end
		end

		-- if clip > 0 and LMB clicked
		-- shoot, clip -= 1
		-- elseif clip = 0 and LMB clicked
		-- reload? (optional)
		-- maybe even make this a toggleable option
		-- check if hitbox in player and it isnt player's weapon
		--[[
		if hitReg(
		player.x - player.width / hitboxScale,
		player.x + player.width / hitboxScale,
		player.y - player.height / hitboxScale,
		player.y + player.height / hitboxScale,
		weapon.x - weapon.width / hitboxScale,
		weapon.x + weapon.width / hitboxScale,
		weapon.y - weapon.height / hitboxScale,
		weapon.y + weapon.height / hitboxScale)
		then
			stuff
		end
		]]
	end

	function weapon.draw()
		weapon.image.draw(weapon.x, weapon.y, weapon.r)

		if weapon.counter > 0 then
			local font = love.graphics.getFont()
			local width = font:getWidth("Reloading...")
			love.graphics.print("Reloading...", camera.width + camera.x - width / 2, camera.height + camera.y)
		end

		if weapon.pickedUp == false then
			weapon.hitbox.draw()
		end

	end

	return weapon
end
