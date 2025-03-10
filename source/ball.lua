

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
    BallSprite:moveBy(BallVelocityX, BallVelocityY)
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

