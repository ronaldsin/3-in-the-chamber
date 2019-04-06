function Player(name)
	--[[
	Player - Object that holds player information like movement commands and stats
	]]--

	-- local to keep it not global
	local player = {}

	player.name = name

	-- sprites
	player.Image = love.graphics.newImage("resources/Player.png")
	player.weapon = love.graphics.newImage("resources/Revolver.png")
	player.gunfire = love.graphics.newImage("resources/gunfire.png")

	player.gunCd = 0.33
	player.damage = 10

	-- x and y coord's
	player.x = 100
	player.y = 100
	player.width = player.Image:getWidth()
	player.height = player.Image:getHeight()

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
		love.graphics.draw(player.Image, player.x, player.y, player.rotation, 1 * sizeScale, 1 * sizeScale, player.Image:getWidth() / 2, player.Image:getHeight() / 2)
		love.graphics.draw(player.weapon, player.x, player.y, player.rotation, 1 * sizeScale, 1 * sizeScale, player.weapon:getWidth() / 2, player.weapon:getHeight() / 2)

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
