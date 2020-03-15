push = require 'push'

Class = require 'class'

require 'Paddle'
require 'Ball'

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

    -- "seed" the RNG so that calls to random are always random
    -- use the current time, since every set up is a new second
    math.randomseed(os.time())

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

    -- initialize our player paddles; make them global so that they can be
    -- detected by other functions and modules
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    -- place a ball in the middle of the screen
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- state game state
    gameState = 'start'
end

function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed to current y scaled by delta time
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed to current y scaled by delta time
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed to current y scaled by delta time
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed to current y scaled by delta time
        player2.dy = -PADDLE_SPEED
    else
        player2.dy = 0
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            
            -- ball's new reset method
            ball:reset()
        end
    end
end

-- Draws to screen after update
function love.draw()
    push:apply('start')

    -- clear screen with specific color
    love.graphics.clear(40/255, 45/255, 52/255, 1)

    -- draws welcome at top of screen
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    -- draw score on left and right center of the screen
    -- need to switch fonts
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    player1:render()
    player2:render()
    ball:render()

    push:apply('end')
end