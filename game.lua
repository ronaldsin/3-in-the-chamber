-- gameLoad() initalizes the game state and variables
function gameLoad()

	-- load the background image
	background = love.graphics.newImage("resources/Map_1_with_text_5000.png")

	-- generates user controlled player
	player = createPlayer() --> player.lua

end

-- gameUpdate(dt) updates game state real time
function gameUpdate(dt)

	-- updates camera -> camera.lua
	camera.update(dt)

	-- updates player model -> player.lua
	player.update(dt)

end

-- gameDraw() draws game state and changes onto screen
function gameDraw()

	-- draws the camera perspective -> camera.lua
	camera.draw()

	-- draw the background
	love.graphics.draw(background)

	-- draw player model -> player.lua
	player.draw()

end
