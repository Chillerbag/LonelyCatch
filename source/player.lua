local playerSpeed = 5

function PlayerStartup()
            
            -- Player is 200 always on the y 
            PlayerSprite:moveTo(200, 200)
            PlayerSprite:add()
    
            -- arm 
            PlayerArmSprite:setCenter(0.5, 1)
            local x, y = PlayerSprite:getPosition()
            PlayerArmSprite:moveTo(x, y+4)
            PlayerArmSprite:add()
end

function BasicMovement()
    -- handle basic Player controls
    if pd.buttonIsPressed(pd.kButtonRight) then
        PlayerSprite:setImage(PlayerAnimationLoop:image(), 0, 1, 1)
        PlayerArmSprite:moveBy(playerSpeed, 0)
        PlayerSprite:moveBy(playerSpeed, 0)
    end
    
    if pd.buttonIsPressed(pd.kButtonLeft) then
        PlayerSprite:setImage(PlayerAnimationLoop:image(), 1, 1, 1)
        PlayerArmSprite:moveBy(-playerSpeed, 0)
        PlayerSprite:moveBy(-playerSpeed, 0)
    end

    if pd.buttonJustReleased(pd.kButtonLeft) then
        PlayerSprite:setImage(PlayerRightStatic, 1, 1, 1)
    end

    if pd.buttonJustReleased(pd.kButtonRight) then
        PlayerSprite:setImage(PlayerRightStatic, 0, 1, 1)
    end
    local crankPos = pd.getCrankPosition() 
    PlayerArmSprite:setRotation(crankPos, 1, 1)
end 

function CanShoot()
    if pd.buttonJustPressed(pd.kButtonA) then
        local armX, armY = PlayerArmSprite:getPosition()
        BallSprite:moveTo(armX, armY)
        local angle = pd.getCrankPosition() 
        local adjustedAngle = angle - 90 
        local angleRadians = math.rad(adjustedAngle)
        
        BallVelocityX = InitialVelocity * math.cos(angleRadians)
        BallVelocityY = InitialVelocity * math.sin(angleRadians)
        
        BallImmunityCounter = 0
        PlayerArmSprite:clearCollideRect()
        ArmCollisionEnabled = false
        GameState = "ShootBall"
    end
end

function PlayerCaughtState()
    PlayerArmSprite:setImage(PlayerShootArm)
    CanShoot()
    BasicMovement()
end

function PlayerShootState()
    PlayerArmSprite:setImage(ArmNoBall)
    BasicMovement()
end