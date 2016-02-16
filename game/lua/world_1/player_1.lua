--require "/lua/background"

player_1 = {}

text = "No collision yet."

function player_1.load()
	-- Energy
	energy = 100
	decrement_energy_time = 500
	collected_spheres = 0

	-- One meter is 32px in physics engine
	love.physics.setMeter( 32 )

	-- Create a world with standard gravity
	world = love.physics.newWorld(0, (9.81*32)/3, true)

	-- Create the ground body at (0, 0) static
	ground = love.physics.newBody(world, 0, 0, "static")

	-- Create the ground shape at (400,500) with size (600,10).
	ground_shape = love.physics.newRectangleShape( 740, 660, 1080, 10)
	ground_shape2 = love.physics.newRectangleShape( 740, 60, 1080, 10)
	ground_shape3 = love.physics.newRectangleShape( 300, 365, 10, 500)
	ground_shape4 = love.physics.newRectangleShape( 1180, 365, 10, 500)

	-- Create fixture between body and shape
	ground_fixture1 = love.physics.newFixture( ground, ground_shape)
	ground_fixture2 = love.physics.newFixture( ground, ground_shape2)
	ground_fixture3 = love.physics.newFixture( ground, ground_shape3)
	ground_fixture4 = love.physics.newFixture( ground, ground_shape4)

	ground_fixture1:setUserData("Ground")
	ground_fixture2:setUserData("Ground")
	ground_fixture3:setUserData("Ground")
	ground_fixture4:setUserData("Ground")

	-- Load the image of the robot.
	robot = love.graphics.newImage("images/robot.png")

	-- Create a Body for the robot
	body = love.physics.newBody(world, 725, 610, "dynamic")

	-- Attatch a shape to the body.
	circle_shape = love.physics.newRectangleShape( 0,0,64,88)

	-- Create fixture between body and shape
	fixture = love.physics.newFixture( body, circle_shape)
	fixture:setUserData("Robot")

	-- Calculate the mass of the body based on attatched shapes.
	-- This gives realistic simulations.
	body:setMassData(circle_shape:computeMass( 1 ))

	-- Set the collision callback.
	world:setCallbacks(beginContact,endContact)

	-- Fire
	fire = love.graphics.newImage("images/fire.png");

	system = love.graphics.newParticleSystem(fire, 10000)

	system:setEmissionRate(1000)
	system:setSpeed(0,500)
	-- starting size to ending size
	system:setSizes(1)
	-- location of the emitter (x,y)
	system:setPosition(body:getX(), body:getY())
	-- how long the emitter lasts, -1 is infinite
	system:setEmitterLifetime(-1)
	-- how long the particles last min, max in seconds
	system:setParticleLifetime(0.05,0.1)
	-- sets the direction in radians
	system:setDirection(20.36)
	-- maximum distance from emitter (distributon, x, y)
	system:setAreaSpread("normal",5,5)
	-- colors for the particles, can have many
	system:setColors(231, 76, 60,200
					,241, 196, 15,175)
	system:start()
end

function player_1.draw()
	love.graphics.setColor(236, 240, 241)
	-- Draws the ground.
	--love.graphics.polygon("line", ground:getWorldPoints(ground_shape:getPoints()))
	--love.graphics.polygon("line", ground:getWorldPoints(ground_shape2:getPoints()))
	--love.graphics.polygon("line", ground:getWorldPoints(ground_shape3:getPoints()))
	--love.graphics.polygon("line", ground:getWorldPoints(ground_shape4:getPoints()))

	-- Draw the fire
	love.graphics.setBackgroundColor(255,255,255)
	if energy > 0 then love.graphics.draw(system) end

	-- Draw the robot.
	love.graphics.draw(robot, body:getX(), body:getY(), body:getAngle(),1,1,32,44)

	--love.graphics.print(text, 505, 25)
end

function player_1.math(dt)
	-- Update the world.
	world:update(dt)
	system:setPosition(body:getX()-2, body:getY()+59)
	system:update(dt)

	body:setAngle(0)

	decrement_energy_time = decrement_energy_time - 800*dt

	if decrement_energy_time < 0 then
		decrement_energy_time = 500
		if energy > 0 then
			energy = energy - 1
		end
	end

end

function player_1.move(key)
	if current_level == 'z' and energy > 0 then
		if love.keyboard.isDown(' ') or love.keyboard.isDown('up') then
			-- Apply a random impulse
			body:applyLinearImpulse(0,-80)
		end
		if love.keyboard.isDown('right') then
			-- Apply a random impulse
			body:applyLinearImpulse(60,0)
		end
		if love.keyboard.isDown('left') then
			-- Apply a random impulse
			body:applyLinearImpulse(-60,0)
		end
	end
end

function UPDATE_PLAYER_1(dt, key)
	player_1.math(dt)
	player_1.move(key)
end

function DRAW_PLAYER_1()
	player_1.draw()
end

-- This is called every time a collision begin.
function beginContact(a, b, c)
	local aa=a:getUserData()
	local bb=b:getUserData()
	text = "Collided: " .. aa .. " and " .. bb
	if bb ~= "Ground" and bb ~= "Robot" and bb ~= "sphere2" then
		table.insert(toRemove,tonumber(bb))
		collected_spheres =  collected_spheres + 1
		addSpheres1_2(balldefs[1], 1)
		energy_music:stop()
		energy_music:play()
	end
end

-- This is called every time a collision end.
function endContact(a, b, c)
	local aa=a:getUserData()
	local bb=b:getUserData()
	text = "Collision ended: " .. aa .. " and " .. bb
end
