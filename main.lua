function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0
    gameState = 1      -- 1.Menu 2.In Game


    gameFont = love.graphics.newFont(40)

    sprites = {}
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.target = love.graphics.newImage('sprites/target.png')

    love.mouse.setVisible(false)
end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end
    if timer < 0 then
        timer = 0
        gameState = 1
    end
end

function love.draw()

    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score:" .. score, 5, 5) 
    love.graphics.print("Time:" .. math.ceil(timer), 200, 5)

    if gameState == 1 then
        message = "Click anywhere on the screen!"
        love.graphics.printf(message, 0, love.graphics.getHeight()/2, love.graphics.getWidth(), 'center')
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y  - target.radius)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
    
end

function  love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gameState == 2 then
        if targetHit(x, y) then
            score = score + 1
            moveTarget()
        else
            if score > 0 then
                score = score - 1
            end
        end
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end

    if button == 2 and gameState == 2 then
        if targetHit(x, y) then
            score = score + 2
            moveTarget()
        else
            if timer > 0 then
                timer = timer - 1
            end
        end
    end
end

function targetHit(x, y)
    local mouseToTarget = distanceBetween(x, y, target.x, target.y)        
        if mouseToTarget < target.radius then
            return true
        end
    return false
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function moveTarget()
    -- target.radius = math.random(20, 50)
    
    target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
    target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
end