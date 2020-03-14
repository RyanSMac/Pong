push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[
    Called once at the start to load everything required for the game
]]
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- creates font object
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- set active font
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

-- Draws to screen after update
function love.draw()
    push:apply('start')

    -- clear screen with specific color
    love.graphics.clear(40/255, 45/255, 52/255, 1)

    -- draws welcome at top of screen
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- renders first paddle (left side)
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- renders second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)

    -- render ball (center)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply('end')
end