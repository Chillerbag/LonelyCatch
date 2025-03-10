

function BallStartup()
    BallSprite:setCollideRect(0, 0, 24, 24)
    BallSprite.collisionResponse = gfx.sprite.kCollisionTypeBounce
end

function ShootBall()
    -- this needs to be in the update loop unfortunately
    BallX, BallY = BallSprite:getPosition()

    if not BallCreated then 
        BallSprite:add()
        BallCreated = true
    end
    BallVelocityY = BallVelocityY + Gravity
    local _, _, collisions, collisionsLen = BallSprite:moveWithCollisions(BallX + BallVelocityX, BallY + BallVelocityY)

    if collisionsLen ~= 0 then
        for i = 1, #collisions do 
            local collidedSprite = collisions[i].other
            -- handle wall collisions with ball
            if collidedSprite == WallSpriteL or collidedSprite == WallSpriteR then
                HandleBallWall()
            end

            -- handle catch collision with ball
            if collidedSprite == PlayerArmSprite then 
                HandleBallCatch()
            end

            if collidedSprite == FloorSprite then
                EndGame()
            end
        end
    end

    BallSprite:setRotation(BallSprite:getRotation() + 5)
    local armX, armY = PlayerArmSprite:getPosition()

    BallImmunityCounter += 1
    
    -- Calculate distance between ball and arm
    local dx = BallX - armX
    local dy = BallY - armY
    local distance = math.sqrt(dx*dx + dy*dy)
    
    -- Only enable collision after ball has moved a safe distance away AND immunity period is over
    if distance > 60 and BallImmunityCounter >= BallImmunityFrames and not ArmCollisionEnabled then
        PlayerArmSprite:setCollideRect(16, 0, 24, 32)
        ArmCollisionEnabled = true
    end
end

