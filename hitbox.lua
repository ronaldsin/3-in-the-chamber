function createHitbox(x, y, width, height)

	local hitbox = {}

	hitbox.width = width
	hitbox.height = height

	hitbox.left = x - hitbox.width / 2 / hitboxScale
	hitbox.right = x + hitbox.width / 2 / hitboxScale
	hitbox.top = y - hitbox.height / 2 / hitboxScale
	hitbox.bottom = y + hitbox.height / 2 / hitboxScale


	function hitbox.update(x, y)

		hitbox.left = x - hitbox.width / 2 / hitboxScale
		hitbox.right = x + hitbox.width / 2 / hitboxScale
		hitbox.top = y - hitbox.height / 2 / hitboxScale
		hitbox.bottom = y + hitbox.height / 2 / hitboxScale

	end


	function hitbox.draw()
		if displayHitbox then
			love.graphics.rectangle( "line", hitbox.left, hitbox.top, hitbox.right - hitbox.left, hitbox.bottom - hitbox.top )
		end
	end


	return hitbox

end
