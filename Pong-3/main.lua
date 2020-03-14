push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- constant for paddle speed; x by dt in update
PADDLE_SPEED = 200

--[[
    Called once at the start to load everything required for the game
]]
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- creates font object
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- larger font for drawing the score
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- set active font
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize score variables, used to render score to screen
    -- track of the winner
    player1Score = 0
    player2Score = 0

    -- paddle positions on the y axis (they can only move up or down)
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current y scaled by delta time
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current y scaled by delta time
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current y scaled by delta time
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current y scaled by delta time
        player2Y = player2Y + PADDLE_SPEED * dt
    end
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
    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- draw score on left and right center of the screen
    -- need to switch fonts
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    -- renders first paddle (left side)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- renders second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- render ball (center)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply('end')
end