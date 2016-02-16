require "/lua/gui"

require "/lua/world_1/background_1"
require "/lua/world_1/front_1"
require "/lua/world_1/player_1"

require "/lua/world_2/background_2"
require "/lua/world_2/front_2"
require "/lua/world_2/player_2"

math.randomseed( os.time() )

function love.load()
	f = love.graphics.newFont( "fonts/Lato/Lato-Light.ttf", 38 )
	f2 = love.graphics.newFont( "fonts/Lato/Lato-Regular.ttf", 18 )

	-- Global variables
	current_level = "z"

	-- Loading classes
	love.mouse.setVisible(false)

	music = love.audio.newSource("sound/theme.mp3")
	music:setLooping(true)
	music:play()

	-- Intro
	intro1 = love.graphics.newImage("images/intro/intro1.png")
	intro2 = love.graphics.newImage("images/intro/intro2.png")
	intro3 = love.graphics.newImage("images/intro/intro3.png")

	gameover = love.graphics.newImage("/images/gameover.png")
	win = love.graphics.newImage("/images/win.png")

	actual_intro = 1

	-- World 1
	bg_1.load()
	player_1.load()
	front_1.load()

	-- World 2
	bg_2.load()
	player_2.load()
	front_2.load()

	gui.load()
end

function love.update(dt)
	if actual_intro > 3 then
		-- World 1
		UPDATE_BG_1(dt)
		UPDATE_PLAYER_1(dt)
		UPDATE_FRONT_1(dt)

		-- World 2
		UPDATE_BG_2(dt)
		UPDATE_PLAYER_2(dt)
		UPDATE_FRONT_2(dt)

		UPDATE_GUI(dt)
	end

	local fps=love.timer.getFPS
	love.window.setTitle("Ludum Dare 30 - "..fps().." FPS")
end

function love.draw()
	if actual_intro > 3 then
		if current_level == "z" then
			-- World 1
			DRAW_BG_1()
			DRAW_PLAYER_1()
			DRAW_FRONT_1()
		else
			-- World 2
			DRAW_BG_2()
			DRAW_PLAYER_2()
			DRAW_FRONT_2()
		end

		DRAW_GUI()
	else
		love.graphics.setColor(255, 255, 255)
		if actual_intro == 1 then love.graphics.draw(intro1, 0, 0) end
		if actual_intro == 2 then love.graphics.draw(intro2, 0, 0) end
		if actual_intro == 3 then love.graphics.draw(intro3, 0, 0) end
	end	
	if energy <= 0 then
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(gameover, 0, 0)
	end
	if space_bg_y > -100 then
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(win, 0, 0)
	end
end

function love.keypressed(key)
	if key == 'escape' then love.event.quit() end

	if actual_intro <= 3 then
		if key == 'return' or key == ' ' then
			actual_intro = actual_intro + 1
		end
	end


	if energy <= 0 or space_bg_y > -100 then
		if key == 'return' or key == ' ' then
			actual_intro = 1
			spheres1 = {}
			spheres2 = {}
			toRemove = {}
			spheres1_2 = {}
			music:stop()
			love.load()
		end
	end
end
