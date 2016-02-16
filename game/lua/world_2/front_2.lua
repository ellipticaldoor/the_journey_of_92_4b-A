front_2 = {}
spheres1_2 = {}

function front_2.load()
	--addSpheres1_2(balldefs[1], 1)
end

function front_2.draw()
	for i, v in ipairs(spheres1_2) do
		if v.b:isActive() then
			love.graphics.draw(images.sphere1, v.b:getX()-30, v.b:getY()-30, 0, 1, 1, v.ox, v.oy)
		end
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(bg_x_front, 0, 0)
end

function front_2.math(dt)
	for i, v in ipairs(spheres1_2) do
		if v.b:getY() > 720 then
			collected_spheres = collected_spheres - 1
			v.b:setActive(false)
			v.b:setY(-500)
			energy = energy + 10
		end
	end
end

function UPDATE_FRONT_2(dt)
    front_2.math(dt)
end

function DRAW_FRONT_2()
    front_2.draw()
end

-- Añadir bolas
function addSpheres1_2(def, num)
	for i = 1, num do
		local x, y = math.random(1132, 1133), math.random(-100, -110)
		local t = {}
		t.b = love.physics.newBody(world2, x, y, "dynamic")
		t.s = love.physics.newCircleShape(def.r)
		t.f = love.physics.newFixture(t.b, t.s)
		t.f:setUserData("spheres1_2" .. i)
		t.i = def.i
		t.ox = def.ox
		t.oy = def.oy
		t.b:setMassData(t.s:computeMass( 1 ))
		table.insert(spheres1_2, t)
	end
end