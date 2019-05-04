-- love.mousepressed(x, y, button, isTouch, dt) is an inbuilt love function
-- 		to read mouse input
function love.mousepressed(x, y, button, isTouch, dt)

	-- if mouse is pressed while in menu, start the game
	if gameState == "menu" then

		gameState = "game" -- change game state into actual game (starts game)

		gameLoad() -- initalizes game -> game.lua

		love.graphics.setNewFont(40) -- font size 40

	end

end
