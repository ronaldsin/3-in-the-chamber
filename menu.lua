-- menuLoad() loads the initial menu state
function menuLoad()

end

-- menuUpdate() updates menu state for changes
function menuUpdate(dt)

end

-- menuDraw() draws menu visuals based on updated menu changes
function menuDraw()

	-- Menu information message
	love.graphics.print("You are in menu left click to start", camera.width - 20, camera.height)

	-- image = love.graphics.newImage("imagelocation.png")
	love.graphics.print("")

end
