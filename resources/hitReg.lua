function hitReg(a_left, a_right, a_top, a_bottom, b_left, b_right, b_top, b_bottom)

	--QED Hitreg
	if a_right > b_left and a_left < b_right and a_bottom > b_top and a_top < b_bottom then
		return true
	else
		return false
	end
end
