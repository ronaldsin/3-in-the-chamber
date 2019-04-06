function hitReg(a_left, a_right, a_top, a_bottom, b_left, b_right, b_top, b_bottom)
	--[[
  TBC
	-- local a_left = a.x
  ]]--

	-- print("a left:" .. a_left)
	-- print("a right:" .. a_right)
	-- print("a top:" .. a_top)
	-- print("a bot:" .. a_bottom)
	--
	-- print("b left: " .. b_left)
	-- print("b right: " .. b_right)
	-- print("b top: " .. b_top)
	-- print("b bottom: " .. b_bottom)

	--If Red's right side is further to the right than Blue's left side.
	--and Red's left side is further to the left than Blue's right side.
	--and Red's bottom side is further to the bottom than Blue's top side.
	--and Red's top side is further to the top than Blue's bottom side then..
	--There is collision!
	if a_right > b_left and a_left < b_right and a_bottom > b_top and a_top < b_bottom then
		return true
	else
		--If one of these statements is false, return false.
		return false
	end
end
