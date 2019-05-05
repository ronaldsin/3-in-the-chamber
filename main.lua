--[[
	3 In The Chamber:

	3 In The Chamber is a 2D, topdown shooting game where you shoot
	enemies

	Features: Suicidal code monkies
	          Underpaid artists
			  Police officer manager
			  Scrapegoat worker Jayden
			  Slacky UOFT boys
			  Paid playtesters
]]

-- Imported files
require("keyBindings") -- Keybinding shortcuts
require("inputs") -- Reads player input
require("menu") -- Menu screen
require("camera") -- Player camera
require("game") -- Actual Game
require("player") -- Player object
require("animation") -- Animation object
require("button") -- Button object

sizeScale = 1 -- default 1

-- love.load() is the initial loading function of the game
function love.load()

	gameState = "menu" -- gamestate of the game; initalizes as menu
	menuLoad() --> menu.lua

end

-- love.update(dt) continuously updates the game in order
-- 		for the game to change
function love.update(dt)

	-- update game based on gameState
	if gameState == "menu" then
		menuUpdate(dt) -- update menu state -> menu.lua

	elseif gameState == "game" then
		gameUpdate(dt) -- update game state -> game.lua

	end

end

-- love.draw() draws game visuals based on the updated game changes
function love.draw()

	-- draw game based on gameState
	if gameState == "menu" then
		menuDraw() -- redirect to draw menu -> menu.lua

	elseif gameState == "game" then
		gameDraw() -- redirect to draw game canvas -> game.lua

	end

end
