camera = {}

camera.x = 0
camera.y = 0

camera.width = love.graphics.getWidth() / 2
camera.height = love.graphics.getHeight() / 2

-- camera.leadSpeed = 3
-- camera.maxXLead = love.graphics.getWidth() * 0.2
-- camera.maxYLead = love.graphics.getHeight() * 0.2

camera.xLead = 0
camera.yLead = 0

camera.xScale = 1.5
camera.yScale = 1.5

function camera.update(dt)
	-- if math.abs(camera.xLead + (love.mouse.getX() - camera.width) * camera.leadSpeed * dt) < camera.maxXLead then
	-- 	camera.xLead = camera.xLead + (love.mouse.getX() - camera.width) * camera.leadSpeed * dt
	-- end
	-- if math.abs(camera.yLead + (love.mouse.getY() - camera.height) * camera.leadSpeed * dt) < camera.maxYLead then
	-- 	camera.yLead = camera.yLead + (love.mouse.getY() - camera.height) * camera.leadSpeed * dt
	-- end

	camera.x = p.x - camera.width * camera.xScale + camera.xLead
	camera.y = p.y - camera.height * camera.yScale + camera.yLead

end

function camera.draw()
	love.graphics.scale(1 / camera.xScale, 1 / camera.yScale)
	love.graphics.translate(-camera.x, - camera.y)
end

function camera.getMouseX()
	return love.mouse.getX() * camera.xScale + camera.x
end

function camera.getMouseY()
	--print(love.mouse.getY())
	return love.mouse.getY() * camera.yScale + camera.y
end
