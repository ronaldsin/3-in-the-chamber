buttonId = 0

--[[
	demoButton = createButton(x1, y1, x2, y2)
	demoButton.text = "text"
	demoButton.hoverText = "hoverText"

	demoButton.image = love.graphics.newImage("image")
	demoButton.hoverImage = love.graphics.newImage("hoverImage")

	demoButton.hover = true
	demoButton.update()
]]--

--[[
	function love.handlers.button(id)
		if id == demoButton.id then
			-- body here
		end
	end
]]--

function createButton(x1, y1, x2, y2)

	local button = {} -- create button table

	-- check which Coordinate is left and which is top
	if x1 < x2 then
		button.left = x1
		button.right = x2

	else
		button.left = x2
		button.right = x1
	end

	if y1 < y2 then
		button.top = y1
		button.bottom = y2

	else
		button.top = y2
		button.bottom = y1
	end

	-- the width of the button
	button.width = button.right - button.left
	button.height = button.bottom - button.top

	-- button properties

	button.hover = false -- if the button changes on hover
	--button.pressed = false -- if the button changes when pressed
	button.outline = false -- if the button draws its outline

	button.visable = true -- if button is visable

	button.image = Nil -- what the button displays normally
	button.hoverImage = Nil -- what the button displays when hovered
	--button.pressedImage = Nil -- what image the button displays when pressed

	button.text = Nil -- what text the button normally displays
	button.hoverText = Nil -- what text the button displays when hovered
	--button.pressedText = Nil -- what text the button displays when pressed

	button.currentImage = Nil -- current image of button
	button.currentText = Nil -- current text of button

	button.inBounds = Nil -- if the mouse is in the button bounds

	button.id = buttonId -- the button id for event calls

	buttonId = buttonId + 1 -- ensures every button has a diffrent id

	-- draws the button based on the current image and text
	function button.draw()
		-- only draw when button is visable
		if button.visable then

			-- draws the image if its not nil
			if not (button.currentImage == Nil) then
				love.graphics.draw(button.currentImage, button.left, button.top)
			end

			-- draws the text if not nil
			if not (button.currentText == Nil) then
				--centers text
				love.graphics.print(button.currentText, button.left + button.width / 2, button.top + button.height / 2 )
			end

			-- draws the button outline if button outline is true
			if button.outline then
				love.graphics.rectangle("line", button.left, button.top, button.width, button.height)
			end
		end
	end

	-- updates the button images and text once (only call once after initilization)
	function button.update()
		button.currentImage = button.image
		button.currentText = button.text
	end

	-- checks if the mouse is in the button when the mouse moves
	function love.mousemoved( x, y, dx, dy, istouch )
		-- check if mouse is in button
		if x >= button.left and x <= button.right and y >= button.top and y <= button.bottom then -- if mouse is in bounds
			button.inBounds = true

			-- if in bounds and the button hover is true than change current button to hover
			if button.hover then
				button.currentImage = button.hoverImage
				button.currentText = button.hoverText
			end
		else
			button.inBounds = false
			button.currentImage = button.image
			button.currentText = button.text
		end
	end

	-- when mouse 1 is released push button id event
	function love.mousereleased(x, y, buttons, isTouch)
		if buttons == 1 then

			if x >= button.left and x <= button.right and y >= button.top and y <= button.bottom then
				love.event.push("button", button.id)
				button.currentImage = button.hoverImage
				button.currentText = button.hoverText
			end
		end
	end

	return button

end
