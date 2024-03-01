import "dvd" -- DEMO
import "Counter"

local dvd = dvd(1, -1) -- DEMO
local counter = Counter(10, 100, 50, 50)

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local function loadGame()
	playdate.display.setRefreshRate(50) -- Sets framerate to 50 fps
	math.randomseed(playdate.getSecondsSinceEpoch()) -- seed for math.random
	gfx.setFont(font) -- DEMO
end

local function updateGame()
	dvd:update() -- DEMO
	counter:update()
end

local function drawGame()
	gfx.clear() -- Clears the screen
	dvd:draw() -- DEMO
	counter:draw()
end

loadGame()

function playdate.update()
	updateGame()
	drawGame()
	playdate.drawFPS(0,0) -- FPS widget
end