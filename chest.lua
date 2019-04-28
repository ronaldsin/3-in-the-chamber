chestSide = 256
function createChest(x, y, r)
	local chest = {}

	chest.x = x
	chest.y = y
	chest.r = r

	print(chestSide)

	chest.opened = false

	chest.hitbox = createHitbox(chest.x, chest.y, chestSide * 5, chestSide * 3)
	chest.image = love.graphics.newImage("resources/chest0.png")

	function chest.open()
		chest.opened = true
		chest.image = love.graphics.newImage("resources/chest1.png")
		chest.weapon = weapons[rng:random(1, #weapons)]
		table.insert(gunPickUp, chest.weapon)
		gunPickUp[#gunPickUp].image.idle()
		gunPickUp[#gunPickUp].update(chest.x, chest.y)
	end

	function chest.draw()
		love.graphics.draw(chest.image, x, y, r, 1 * sizeScale, 1 * sizeScale, chestSide / 2, chestSide / 2)
		chest.hitbox.draw()
	end

	return chest

end
