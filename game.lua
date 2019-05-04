-- gameLoad() initalizes the game state and variables
function gameLoad()

	-- load the background image
	background = love.graphics.newImage("resources/Map_1_with_text_5000.png")

	player = createPlayer()

end

-- gameUpdate(dt) updates game state real time
function gameUpdate(dt)

	camera.update(dt)

end

-- gameDraw() draws game state and changes onto screen
function gameDraw()

	camera.draw()

	-- draw the background
	love.graphics.draw(background)

end
