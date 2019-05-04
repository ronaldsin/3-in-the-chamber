-- camera Object
camera = {}

-- Camera positions
camera.x = 0
camera.y = 0

-- Coordinate for centre of screen (divide 2 for width and height to take middle of screen)
camera.width = love.graphics.getWidth() / 2
camera.height = love.graphics.getHeight() / 2

-- Camera scale
camera.xScale = 2
camera.yScale = 2

-- camera.update(dt) updates camera movement real time
function camera.update(dt)

	camera.x = player.x - camera.width * camera.xScale
	camera.y = player.y - camera.height * camera.yScale

end

-- camera.draw() moves canvas on screen (this matches player centering)
function camera.draw()

	-- Camera zoom
	love.graphics.scale(1 / camera.xScale, 1 / camera.yScale)

	-- Moves canvas on screen
	love.graphics.translate(camera.x * (-1), camera.y * (-1))

end

-- camera.getMouseX() gets absolute x mouse position
function camera.getMouseX()

	return love.mouse.getX() * camera.xScale + camera.x

end

-- camera.getMouseY() gets absolute y mouse position
function camera.getMouseY()

	return love.mouse.getY() * camera.yScale + camera.y

end
