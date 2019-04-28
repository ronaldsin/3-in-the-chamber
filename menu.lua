function start()
	-- create player obj
	p = Player("lmao")
	e = Monster("not lmao")

	gunPickUp = {}

	-- createWeapon(name, dmg, bullet speed, range, clip size, reload time, pickup, fire mode, stance, spread, length)
	table.insert(gunPickUp, createWeapon("FrontlinerIcon", 25, 0.14, 450, 500, 30, 30, 1.75, false, 2, 2, 40, 140)) -- 171dps
	table.insert(gunPickUp, createWeapon("PrideIcon", 60, 0.29, 600, 700, 8, 8, 1.9, false, 1, 1, 15, 120)) -- 206.896551724138dps
	table.insert(gunPickUp, createWeapon("AccelerantIcon", 25, 0.1, 550, 200, 20, 20, 1.2, false, 2, 2, 160, 105)) -- 250dps
	table.insert(gunPickUp, createWeapon("BoomstickVIIcon", 6, 0.75, 400, 250, 6, 6, 1, false, 1, 2, 400, 120)) -- 187dps
	table.insert(gunPickUp, createWeapon("StrikeoutIcon", 40, 0.20, 375, 600, 80, 80, 3.3, false, 2, 2, 90, 140)) -- 200dps
	table.insert(gunPickUp, createWeapon("TheBeartrapIcon", 170, 1, 4000, 10000, 5, 5, 2.2, false, 1, 2, 0, 145)) -- 170dps
	--table.insert(gunPickUp, createWeapon("SirenIcon", 17, 0.3, 450, 350, 18, 18, 1.3, false, 3, 1, 35, 90)) -- 56.6666666666667dps
	--table.insert(gunPickUp, createWeapon("LongHaulIcon", 27, 0.5, 390, 650, 100, 100, 4, false, 2, 2, 130, 145)) -- 54dps
	--table.insert(gunPickUp, createWeapon("BacklinerIcon", 45, 0.27, 600, 800, 11, 11, 1.75, false, 1, 2, 25, 145)) -- 166.666666666667dps
	table.insert(gunPickUp, createWeapon("HackslasherIcon", 21, 0.14, 550, 190, 24, 24, 1.5, false, 2, 2, 130, 100)) -- 150.dps
	table.insert(gunPickUp, createWeapon("MuscleSpasmIcon", 16, 0.4, 425, 160, 15, 15, 2.1, false, 2, 2, 550, 100)) -- 40dps
	table.insert(gunPickUp, createWeapon("BountyHunterIcon", 220, 1.35, 1500, 1200, 7, 7, 2.3, false, 1, 2, 0, 145)) -- 162.962962962963dps

	for i = 1, #gunPickUp do
		gunPickUp[i].image.idle()
	end

	chests = createChest(3907.02, 504.47, - math.pi / 2)


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

	background = love.graphics.newImage("resources/Map_1_with_text_5000.png")

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
