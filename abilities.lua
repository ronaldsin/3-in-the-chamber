function ability(player)
	if (player.ability == "roll") then
		player.invincible = 1 -- status' in seconds
		player.shoot = 0
		player.abilityCD = 3
	end
end
