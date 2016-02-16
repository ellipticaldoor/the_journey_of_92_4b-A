--require "/lua/background"

player_2 = {}

function player_2.load()
	-- Create a world with standard gravity
	world2 = love.physics.newWorld(0, (9.81*32)/2, true)

	-- Create the ground body at (0, 0) static
	ground_2 = love.physics.newBody(world2, 0, 0, "static")

	-- Create the ground shape at (400,500) with size (600,10).
	ground_shape_2 = love.physics.newRectangleShape( 863, 646, 1080, 10)
	ground_shape2_2 = love.physics.newRectangleShape( 1740, 0, 1080, 10)
	ground_shape2b_2 = love.physics.newRectangleShape( 740-200, 0, 1080, 10)
	ground_shape3_2 = love.physics.newRectangleShape( 200, 360, 10, 720)
	ground_shape4_2 = love.physics.newRectangleShape( 1246, 360, 10, 720)

	-- Create fixture between body and shape
	ground_fixture1_2 = love.physics.newFixture( ground_2, ground_shape_2)
	ground_fixture2_2 = love.physics.newFixture( ground_2, ground_shape2_2)
	ground_fixture2_2 = love.physics.newFixture( ground_2, ground_shape2b_2)
	ground_fixture3_2 = love.physics.newFixture( ground_2, ground_shape3_2)
	ground_fixture4_2 = love.physics.newFixture( ground_2, ground_shape4_2)

	-- Load the image of the robot.
	robot_2 = love.graphics.newImage("images/robot_2.png")

	-- Create a Body for the robot
	body_2 = love.physics.newBody(world2, 725, 570, "dynamic")
	
	-- Attatch a shape to the body.
	circle_shape_2 = love.physics.newRectangleShape( 0,0,125,144)
	
    -- Create fixture between body and shape
    fixture_2 = love.physics.newFixture( body_2, circle_shape_2)

	-- Calculate the mass of the body based on attatched shapes.
	-- This gives realistic simulations.
	body_2:setMassData(circle_shape_2:computeMass( 1 ))
end

function player_2.draw()
	love.graphics.setColor(52, 73, 94)
	-- Draws the ground.
	love.graphics.polygon("line", ground:getWorldPoints(ground_shape_2:getPoints()))
	--love.graphics.polygon("line", ground:getWorldPoints(ground_shape2_2:getPoints()))
	--love.graphics.polygon("line", ground:getWorldPoints(ground_shape2b_2:getPoints()))
	--love.graphics.polygon("line", ground:getWorldPoints(ground_shape3_2:getPoints()))
	--love.graphics.polygon("line", ground:getWorldPoints(ground_shape4_2:getPoints()))

	-- Draw the robot.
	love.graphics.setColor(255,255,255)
	love.graphics.draw(robot_2, body_2:getX(), body_2:getY(), body_2:getAngle(),1,1,62,72)
end

function player_2.math(dt)
	world2:update(dt)
	body_2:setAngle(0)
end

function  player_2.move(key)
	if current_level == 'x' and energy > 0 then
		if love.keyboard.isDown(' ') or love.keyboard.isDown('up') then
			-- Apply a random impulse
			body_2:applyLinearImpulse(0,-100)
		end
		if love.keyboard.isDown('right') then
			-- Apply a random impulse
			body_2:applyLinearImpulse(80,0)
		end
		if love.keyboard.isDown('left') then
			-- Apply a random impulse
			body_2:applyLinearImpulse(-80,0)
		end
	end
end

function UPDATE_PLAYER_2(dt, key)
	player_2.math(dt)
	player_2.move(key)
end

function DRAW_PLAYER_2()
	player_2.draw()
end
