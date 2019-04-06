function Monster(name)
	--[[
	Player - Object that holds player information like movement commands and stats
	]]--

	-- local to keep it not global
	local monster = {}

	monster.name = name

	-- sprites
	monster.Image = love.graphics.newImage("resources/Player2.png")
	monster.weapon = love.graphics.newImage("resources/Revolver.png")
	monster.gunfire = love.graphics.newImage("resources/gunfire.png")



	-- x and y coord's
	monster.x = 100
	monster.y = 100
	monster.width = monster.Image:getWidth()
	monster.height = monster.Image:getHeight()

	-- stats
	monster.speed = 300
	monster.health = 100
	monster.power = 100
	monster.armor = 0

	-- boolean movement
	monster.xmoving = false
	monster.ymoving = false

	-- the rotation of the sprite in radians
	monster.rotation = 0


	-- movement and shooting
	function monster.update(dt)

		monster.hitReg(dt)

		-- update rotation
		monster.rotate()
	end

	function monster.hitReg(dt)
		-- bullet hit reg (does not work rn)
		for i, v in ipairs(bullets) do
			if hitReg(monster.x - monster.width / hitboxScale, monster.x + monster.width / hitboxScale, monster.y - monster.height / hitboxScale, monster.y + monster.height / hitboxScale, v.x - v.width / hitboxScale, v.x + v.width / hitboxScale, v.y - v.height / hitboxScale, v.y + v.height / hitboxScale) then
				if not(monster.name == v.name) then
					print(monster.name)
					monster.health = monster.health - p.damage
					hit = true
					setCursor("resources/Hitmarker.png")
					playSound(oof)
					table.remove(bullets, i)

				end
			end
		end
	end



	-- drawing to screen
	function monster.draw()

		if monster.health <= 0 then
			love.graphics.setColor(1, 0, 0)
		end
		love.graphics.draw(monster.Image, monster.x, monster.y, monster.rotation, 1 * sizeScale, 1 * sizeScale, monster.Image:getWidth() / 2, monster.Image:getHeight() / 2)
		love.graphics.draw(monster.weapon, monster.x, monster.y, monster.rotation, 1 * sizeScale, 1 * sizeScale, monster.weapon:getWidth() / 2, monster.weapon:getHeight() / 2)
		if displayHitbox then
			love.graphics.rectangle("line", monster.x - monster.width / (hitboxScale * 2), monster.y - monster.height / (hitboxScale * 2), monster.width / hitboxScale, monster.height / hitboxScale)
		end

		love.graphics.setColor(1, 1, 1 )
	end



	-- rotate monster model to mouse
	function monster.rotate()
		monster.rotation = (math.atan2(love.mouse.getY() - monster.y, love.mouse.getX() - monster.x) + (math.pi / 2))
	end

	return monster
end
