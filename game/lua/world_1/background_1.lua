bg_1 = {}

function bg_1.load()
	space_bg = love.graphics.newImage("images/space_bg.jpg")
	sun = love.graphics.newImage("images/sun.png")
	--space_bg_y = -8000+720
	space_bg_y = -8000+720
	space_bg_height = 8000
	bg_vel = 50
end

function bg_1.draw()
	-- Background
	love.graphics.setColor(52, 152, 219)
	--love.graphics.rectangle("fill", 0, 0, 1280, 1720)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(space_bg, 0, space_bg_y)
end

function bg_1.math(dt)
	if energy > 0 and space_bg_y <= -100 then
		space_bg_y = space_bg_y + bg_vel*dt
	end
end

function UPDATE_BG_1(dt)
	bg_1.math(dt)
end

function DRAW_BG_1()
	bg_1.draw()
end
