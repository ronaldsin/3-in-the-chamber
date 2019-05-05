-- createAnimation(name, frames, speed, rows, columns, idleFrame, frameHeight, frameWidth)
--   initalizes the animation properties and images
function createAnimation(name, frames, speed, rows, columns, idleFrame, frameHeight, frameWidth, isrepeat)

	local animation = {} -- animation object

	-- image for quads
	animation.image = love.graphics.newImage("resources/" .. name .. ".png")

	-- frame properties
	animation.currentFrame = 1 -- counter that keeps track of the current frame
	animation.maxFrames = frames -- how many frames the animation has
	animation.speed = speed -- how quickly the animation plays

	-- default frame for idle animation
	animation.idleFrame = idleFrame

	-- frame resolution and container to hold animation images
	animation.frameWidth = frameWidth
	animation.frameHeight = frameHeight
	animation.frames = {}

	-- animation booleans
	animation.isrepeat = isrepeat
	animation.finished = false

	-- the amount of rows and columns in the image file (converts to array index)
	local numRows = rows - 1
	local numCols = columns - 1

	-- animation resolution
	local width = animation.image:getWidth()
	local height = animation.image:getHeight()

	-- scrolls through all rows and columns of the image to retrieve quads
	for i = 0, numCols do
		for j = 0, numRows do

			-- insert image quad into frames table to hold image
			table.insert(animation.frames, love.graphics.newQuad(j * animation.frameWidth, i * animation.frameHeight, animation.frameWidth, animation.frameHeight, width, height))

			-- exit once all quads have been inserted into frames table
			if #animation.frames == animation.maxFrames then
				break
			end

		end
	end

	-- Method: update(dt) updates animation frame in order to change animation
	--   to the next desired image
	function animation.update(dt)

		-- increase frame based on animation speed (uses delta time to maintain consistent speed)
		animation.currentFrame = animation.currentFrame + animation.speed * dt

		--
		if math.floor(animation.currentFrame) > animation.maxFrames and not animation.finished then
			if animation.isrepeat then
				animation.currentFrame = 1
			else
				animation.finished = true
				animation.idle()
			end
		end
	end

	-- Method: idle() sets the animation in a idle state
	function animation.idle()
		animation.currentFrame = animation.idleFrame
	end

	-- Method: draw(x, y, r) draws the animation at the specified x, y coordinate with r rotation
	function animation.draw(x, y, r)
		love.graphics.draw(animation.image, animation.frames[math.floor(animation.currentFrame)], x, y, r, 1.2 * sizeScale, 1.2 * sizeScale, animation.frameWidth / 2, animation.frameHeight / 2)
	end

	-- return animation object
	return animation

end
