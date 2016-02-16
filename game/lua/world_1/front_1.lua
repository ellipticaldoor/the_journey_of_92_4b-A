front_1 = {}

spheres1 = {}
spheres2 = {}
toRemove = {}

function front_1.load()
	energy_music = love.audio.newSource("sound/energy.mp3")

	images = {
		sphere1 = love.graphics.newImage("/images/sphere1.png"),
		sphere2 = love.graphics.newImage("/images/sphere2.png"),
	}

	balldefs = {
		{ i = images.sphere1, r = 20 , ox = 20, oy = 20},
		{ i = images.sphere2, r = 20 , ox = 20, oy = 20},
	}

	addSpheres1(balldefs[1], 40)
	addSpheres2(balldefs[2], 200)
end

function front_1.draw()
	for i, v in ipairs(spheres1) do
		if v.b:isActive() then
			love.graphics.draw(v.i, v.b:getX()-30, v.b:getY()-30, v.b:getAngle(), 1, 1, v.ox, v.oy)
		end
	end

	for i, v in ipairs(spheres2) do
		if v.b:isActive() then
			love.graphics.draw(v.i, v.b:getX()-30, v.b:getY()-30, v.b:getAngle(), 1, 1, v.ox, v.oy)
		end
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(sun, 0, space_bg_y)
end

function front_1.math(dt)
	if energy > 0 then
		for i, v in ipairs(spheres1) do
			v.b:setY( v.b:getY() + 200*dt )
		end

		for i, v in ipairs(spheres2) do
			v.b:setY( v.b:getY() + 200*dt )
		end
	end

	for i, v in ipairs(toRemove) do
		remove_sphere(v)
	end


end

function UPDATE_FRONT_1(dt)
	front_1.math(dt)
end

function DRAW_FRONT_1()
	front_1.draw()
end

function remove_sphere(sphere_number)
	for i, v in ipairs(spheres1) do
		if i == sphere_number then
			v.b:setActive(false)
			v = nil
		end
	end
end

-- Añadir bolas
function addSpheres1(def, num)
	for i = 1, num do
		local x, y = math.random(300, 1100), -math.random(-150, space_bg_height*4)
		--local x, y = math.random(300, 1100), math.random(200, 500)
		local t = {}
		t.b = love.physics.newBody(world, x, y, "static")
		t.s = love.physics.newCircleShape(def.r)
		t.f = love.physics.newFixture(t.b, t.s)
		t.f:setUserData(i)
		t.i = def.i
		t.ox = def.ox
		t.oy = def.oy
		t.b:setMassData(t.s:computeMass( 1 ))
		table.insert(spheres1, t)
	end
end

-- Añadir bolas
function addSpheres2(def, num)
	for i = 1, num do
		local x, y = math.random(300, 1100), -math.random(-150, space_bg_height*4)
		--local x, y = math.random(300, 1100), math.random(200, 500)
		local t = {}
		t.b = love.physics.newBody(world, x, y, "static")
		t.s = love.physics.newCircleShape(def.r)
		t.f = love.physics.newFixture(t.b, t.s)
		t.f:setUserData("sphere2")
		t.i = def.i
		t.ox = def.ox
		t.oy = def.oy
		t.b:setMassData(t.s:computeMass( 1 ))
		table.insert(spheres2, t)
	end
end
