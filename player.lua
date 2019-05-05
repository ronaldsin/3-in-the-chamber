-- createPlayer() generates a new player with properties and methods that allow
--   the main player to walk, use abilities, and rotate
function createPlayer()

	-- initalizes player object
	local player = {}

	-- player initial location
	player.x = 973
	player.y = 1091

	-- player initial rotation
	player.r = 0

	-- how fast the player moves
	player.speed = 300

	-- if the player is moving
	player.moving = false

	-- player animation objects
	player.legs = createAnimation("PonytailLegs", 14, 10, 4, 4, 1, 256, 256, true)

	-- player stance avaliable
	player.stances = {}

	-- insert pistol(idle) and assualt rifle player stance
	table.insert(player.stances, createAnimation("PonytailIdle", 4, 3, 2, 2, 1, 256, 256, true))
	table.insert(player.stances, createAnimation("Ponytail_AssaultRifle", 4, 3, 2, 2, 1, 256, 256, true))

	-- top stance of player model
	player.body = player.stances[1]

	-- Method: update(dt) updates player state in delta time
	function player.update(dt)

		-- updates player rotation
		player.rotate()

		-- update body and leg frames
		player.body.update(dt)

		-- update legs if player is moving
		if player.moving then
			player.legs.update(dt)
		end

		player.keyboardDown(dt)

	end

	-- Method: draw() draws the updated player
	function player.draw()

		-- draws the player components
		player.legs.draw(player.x, player.y, player.rotation)
		player.body.draw(player.x, player.y, player.rotation)

	end


	-- Method: rotate() rotates player model to mouse
	function player.rotate()

		-- calculates new rotation
		local newRotation = math.atan2(camera.getMouseY() - player.y, camera.getMouseX() - player.x)
		player.rotation = newRotation + (math.pi / 2)

	end


	---------------------------------------------------------------------------------------------------
	--[[
		Below are the functions used to read player input, related to the player.
		This is seperated from global inputs
	]]
	function player.keyboardDown(dt)
		player.moving = false

		if love.keyboard.isDown(input_player_down) then
			player.y = player.y + player.speed * dt
			player.moving = true
		end

		if love.keyboard.isDown(input_player_right) then
			player.x = player.x + player.speed * dt
			player.moving = true
		end

		if love.keyboard.isDown(input_player_up) then
			player.y = player.y - player.speed * dt
			player.moving = true

		end

		if love.keyboard.isDown(input_player_left) then
			player.x = player.x - player.speed * dt
			player.moving = true

		end
	end


	-- return statement
	return player

end
