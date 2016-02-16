gui = {}

function gui.load()
	-- Panel
	panel_border = 3
	panel_width = 200

	-- World selector
	world_selector = love.graphics.newImage("/images/gui/world_selector.png")
	world_1 = love.graphics.newImage("/images/gui/world_1.png")
	world_2 = love.graphics.newImage("/images/gui/world_2.png")
	selector_position = 'z'
	s_img_width = world_selector:getWidth()

	-- Status section
	status_height = 360
	status_separation = 40
	line_height = 25
end

function gui.draw()
	-- Panel
	love.graphics.setColor(236, 240, 241, 220)
	love.graphics.rectangle("fill", 0, 0, panel_width, 720)
	love.graphics.setColor(52, 73, 94)
	love.graphics.rectangle("fill", panel_width, 0, panel_border, 720)

	-- World selector section
	love.graphics.setColor(52, 73, 94)
	love.graphics.setFont(f)
	sizetext = f:getWidth("WORLDS")
	love.graphics.print("WORLDS", (panel_width-sizetext)/2, 20)

	love.graphics.setColor(255,255,255,255)
	if selector_position == 'z' then
		love.graphics.draw(world_selector, (panel_width-s_img_width)/2, 50)
	else
		love.graphics.draw(world_selector, (panel_width-s_img_width)/2, 50*3.5)
	end
	love.graphics.draw(world_1, (panel_width-s_img_width)/2, 50)
	love.graphics.draw(world_2, (panel_width-s_img_width)/2, 50*3.5)

	-- Stats section
	love.graphics.setColor(52, 73, 94)
	love.graphics.setFont(f)
	sizetext = f:getWidth("STATUS")
	love.graphics.print("STATUS", (panel_width-sizetext)/2, status_height)

	love.graphics.setFont(f2)
	--love.graphics.print("Current World: " .. current_level, 20, status_height + status_separation + line_height*1)
	love.graphics.print("92.4b-A Energy: " .. energy, 20, status_height + status_separation + line_height*1)
	love.graphics.print("Saved Spheres: " .. collected_spheres, 20, status_height + status_separation + line_height*2)
end

function gui.math(dt)
	-- Selector
	if love.keyboard.isDown('z') then
		selector_position = 'z'
		current_level = 'z'
	end

	if love.keyboard.isDown('x') then
		selector_position = 'x'
		current_level = 'x'
	end
end

function UPDATE_GUI(dt)
	gui.math(dt)
end

function DRAW_GUI()
	gui.draw()
end
