--[[
	3 In The Chamber:

	3 In The Chamber is a 2D, topdown shooting game where you shoot
	enemy marines

	Features:
]]

-- Imported files
require("keyBindings") -- Keybinding shortcuts
require("inputs") -- Reads player input
require("menu") -- Menu screen
require("camera") -- Player camera
require("game") -- Actual Game
require("player")

-- love.load() is the initial loading function of the game
function love.load()

	gameState = "menu" -- Gamestate of the game

end

-- love.update(dt) continuously updates the game in order
-- 		for the game to change
function love.update(dt)

	-- update game based on gameState
	if gameState == "menu" then
		menuUpdate(dt)
	end

end

-- love.draw() draws game visuals based on the updated game changes
function love.draw()

	-- draw game based on gameState
	if gameState == "menu" then
		menuDraw()
	end

end
