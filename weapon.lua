function createWeapon(name, damage, cd, speed, range, magazine, pickUp)
	local weapon = {}

	-- sprites
	weapon.name = name

	weapon.image = createAnimation(name, 4, 20, 2, 2, 1, 256, 256)

	weapon.pickUp = pickUp

	-- orientation
	weapon.r = 0 -- edit this to have an angle if it exists later
	weapon.x = 50
	weapon.y = 50
	weapon.width = 256
	weapon.height = 256

	weapon.left = weapon.x - weapon.width / hitboxScale
	weapon.right = weapon.x + weapon.width / hitboxScale
	weapon.top = weapon.y - weapon.height / hitboxScale
	weapon.bottom = weapon.y + weapon.height / hitboxScale

	-- stats
	weapon.state = "ranged"
	weapon.damage = damage
	weapon.magazine = magazine
	weapon.clip = magazine
	weapon.gunCd = cd
	weapon.speed = speed
	weapon.range = range

	-- function weapon.reload()
	-- 	-- play animation
	-- 	-- delay for whatever amount
	-- 	weapon.clip = weapon.magazine
	-- end
	--
	-- function weapon.fire()
	--
	-- end

	function weapon.update(dt)
		weapon.image.update(dt)

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

	function weapon.draw(x, y, r)
		weapon.image.draw(x, y, r)

		if displayHitbox then
			if not(pickUp) then
				love.graphics.rectangle("line", weapon.x - weapon.width / (hitboxScale / 1.5), weapon.y - weapon.height / (hitboxScale / 1.5), weapon.width / (hitboxScale / 3), weapon.height / (hitboxScale / 3))
			end
		end
	end

	return weapon
end
