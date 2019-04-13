function start()
	-- create player obj
	p = Player("lmao")
	e = Monster("not lmao")

	gunPickUp = {}

	-- createWeapon(name, dmg, bullet speed, range, clip size, reload time, pickup, fire mode, stance, spread)
	table.insert(gunPickUp, createWeapon("FrontlinerIcon", 25, 0.14, 450, 500, 30, 30, 1.75, false, 2, 2, 40)) -- 171dps
	table.insert(gunPickUp, createWeapon("PrideIcon", 60, 0.29, 600, 700, 8, 8, 1.9, false, 1, 1, 15)) -- 206.896551724138dps
	table.insert(gunPickUp, createWeapon("AccelerantIcon", 25, 0.1, 550, 200, 20, 20, 1.2, false, 2, 2, 160)) -- 250dps
	table.insert(gunPickUp, createWeapon("BoomstickVIIcon", 6, 0.75, 400, 250, 28, 28, 1, false, 1, 2, 400)) -- 187dps
	table.insert(gunPickUp, createWeapon("StrikeoutIcon", 40, 0.20, 375, 600, 80, 80, 3.3, false, 2, 2, 90)) -- 200dps
	table.insert(gunPickUp, createWeapon("TheBeartrapIcon", 170, 1, 4000, 1000, 5, 5, 2.2, false, 1, 2, 0)) -- 170dps


	for i = 1, #gunPickUp do
		gunPickUp[i].image.idle()
	end


	rng = love.math.newRandomGenerator()
	rng:setSeed(os.time())

	-- initialize bullet array
	bullets = {}

	--timers
	--hitmarker timer
	hit = false
	counter = 0
	hitTimer = 0.15

	--fire timer
	fireTimer = 0.2
	fire_ani = fireTimer

	--gun cd timer
	cd = p.weapon.gunCd

	--pause
	pause = false

	background = love.graphics.newImage("resources/bg.png")

	css = createAnimation("Ponytail_CSS", 4, 6, 2, 2, 1, 256, 256)

	-- setting crosshair cursor
	setCursor("resources/Crosshair.png")
end

function menuUpdate(dt)
	css.update(dt)
end

function menuDraw()

	css.draw(camera.width - css.frame_width / 4, camera.height - css.frame_height / 10, 0)
	love.graphics.print("You are in menu left click to start", camera.width - 20, camera.height)
end
