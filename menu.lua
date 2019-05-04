-- menuLoad() loads the initial menu state
function menuLoad()

	-- create new animation object -> main character portrait
	menuImage = createAnimation("Ponytail_CSS", 4, 6, 2, 2, 1, 256, 256, true)

end

-- menuUpdate() updates menu state for changes
function menuUpdate(dt)

	-- update image animation frame
	menuImage.update(dt)

end

-- menuDraw() draws menu visuals based on updated menu changes
function menuDraw()

	-- Menu information message
	love.graphics.print("You are in menu left click to start", camera.width - 20, camera.height)

	-- draws the menu image
	menuImage.draw(camera.width - menuImage.frameWidth / 4, camera.height - menuImage.frameHeight / 10, 0)

	-- image = love.graphics.newImage("imagelocation.png")
	love.graphics.print("")

end
