function burstUpdate()

	if p.weapon.name == "Pathfinder" then
		if burstCounter > 0 and currentBurstCD <= 0 then
			b = proj(p.x, p.y, p.rotation, p.name, p.weapon.speed, p.weapon.range, "PistolBullet", math.abs(p.weapon.rng - (p.weapon.spoolUpCounter * 45)), p.weapon.length, p.weapon.damage, p.weapon.name)

			print("3")
			print("CD started")
			table.insert(bullets, b)
			playSound(gunshot)

			burstCounter = burstCounter - 1

			currentBurstCD = ogBurstCD

			if burstCounter == 0 then
				burstCounter = 3
			end

		end
	end

end
