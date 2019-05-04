-- love.mousepressed(x, y, button, isTouch, dt) is an inbuilt love function
-- 		to read mouse input
function love.mousepressed(x, y, button, isTouch, dt)

	-- if mouse is pressed while in menu, start the game
	if gameState == "menu" then
		gameState = "game"
		gameLoad()
		love.graphics.setNewFont(40)
	end

end
