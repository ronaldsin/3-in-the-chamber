function createAnimation(name, frames, fps, r, c, iframe, fheight, fwidth)

	local animation = {}

	animation.currentFrame = 1
	animation.maxFrames = frames
	animation.fps = fps
	animation.image = love.graphics.newImage("resources/" .. name .. ".png")

	animation.isrepeat = true

	animation.idleFrame = iframe

	animation.frame_width = fwidth
	animation.frame_height = fheight

	animation.frames = {}

	local numRows = r - 1
	local numCols = c - 1

	local width = animation.image:getWidth()
	local height = animation.image:getHeight()



	for i = 0, numCols do
		for j = 0, numRows do
			table.insert(animation.frames, love.graphics.newQuad(j * animation.frame_width, i * animation.frame_height, animation.frame_width, animation.frame_height, width, height))
			if #animation.frames == animation.maxFrames then
				break
			end
		end
	end

	function animation.update(dt)
		animation.currentFrame = animation.currentFrame + animation.fps * dt
		if math.floor(animation.currentFrame) > animation.maxFrames then

			animation.currentFrame = 1
		end
	end

	function animation.idle()
		animation.currentFrame = animation.idleFrame
	end

	function animation.draw(x, y, r)
		love.graphics.draw(animation.image, animation.frames[math.floor(animation.currentFrame)], x, y, r, 1.2 * sizeScale, 1.2 * sizeScale, animation.frame_width / 2, animation.frame_height / 2)
	end
	return animation
end
