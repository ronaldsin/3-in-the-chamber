function Player(name)
	--[[
	Player - Object that holds player information like movement commands and stats
	]]--

	-- local to keep it not global
	local player = {}

	player.name = name

	player.moving = false



	-- createAnimation(name, frames, fps, r, c, iframe, fheight, fwidth)
	player.idle = createAnimation("PonytailIdle", 4, 2, 2, 2, 1, 256, 256)
	player.legs = createAnimation("PonytailLegs", 3, 10, 2, 2, 1, 256, 256)

	player.weapon = createWeapon("Revolver", 10, 0.33, 2000, 500, 6)

	player.damage = 10

	-- x and y coord's
	player.x = 100
	player.y = 100
	player.width = player.idle.frame_width
	player.height = player.idle.frame_height

	-- stats
	player.speed = 300
	player.health = 100
	player.power = 100
	player.armor = 0

	-- boolean movement
	player.xmoving = false
	player.ymoving = false

	-- the rotation of the sprite in radians
	player.rotation = 0

	-- movement and shooting
	function player.update(dt)

		if p.moving then
			player.legs.update(dt)
		else
			player.legs.idle()
		end

		player.idle.update(dt)

		player.hitReg(dt)

		-- update rotation
		player.rotate()
	end

	function player.hitReg(dt)
		-- bullet hit reg (does not work rn)
		for i, v in ipairs(bullets) do
			if hitReg(player.x - player.width / hitboxScale, player.x + player.width / hitboxScale, player.y - player.height / hitboxScale, player.y + player.height / hitboxScale, v.x - v.width / hitboxScale, v.x + v.width / hitboxScale, v.y - v.height / hitboxScale, v.y + v.height / hitboxScale) then
				if not(player.name == v.name) then
					print(player.name)
					player.health = player.health - player.damage
					hit = true
					setCursor("resources/Hitmarker.png")
					playSound(oof)
					table.remove(bullets, i)

				end
			end
		end
	end


	-- drawing to screen
	function player.draw()

		if player.health <= 0 then
			love.graphics.setColor(1, 0, 0)
		end

		player.legs.draw(player.x, player.y, player.rotation)
		player.idle.draw(player.x, player.y, player.rotation)
		player.weapon.draw(player.x, player.y, player.rotation)

		if displayHitbox then
			love.graphics.rectangle("line", player.x - player.width / (hitboxScale * 2), player.y - player.height / (hitboxScale * 2), player.width / hitboxScale, player.height / hitboxScale)
		end

		love.graphics.setColor(1, 1, 1 )
	end

	-- rotate player model to mouse
	function player.rotate()
		player.rotation = (math.atan2(love.mouse.getY() - player.y, love.mouse.getX() - player.x) + (math.pi / 2))
	end

	return player
end
