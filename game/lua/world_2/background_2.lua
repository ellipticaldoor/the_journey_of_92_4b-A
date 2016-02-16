bg_2 = {}

function bg_2.load()
	bg_x = love.graphics.newImage("images/fondofase2.png")
	bg_x_front = love.graphics.newImage("images/fondofase2_front.png")
end

function bg_2.draw()
	-- Background
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(space_bg, 0, space_bg_y)
	love.graphics.draw(sun, 0, space_bg_y)
	love.graphics.draw(bg_x, 0, 0)
end

function bg_2.math(dt)

end

function UPDATE_BG_2(dt)
    bg_2.math(dt)
end

function DRAW_BG_2()
    bg_2.draw()
end