function hitReg(hitbox_a, hitbox_b)

	--QED Hitreg
	if hitbox_a.right > hitbox_b.left and hitbox_a.left < hitbox_b.right and hitbox_a.bottom > hitbox_b.top and hitbox_a.top < hitbox_b.bottom then
		return true

	else
		return false
	end

end
