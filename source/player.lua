local playerSpeed = 5
local direction = 1
local dashTime = 10
local dashDuration = 0
local dashing = false
local dashSpeed = 10

function PlayerStartup()
            
            -- Player is 200 always on the y 
            PlayerSprite:setCollideRect(0, 0, 32, 48)
            PlayerSprite.collisionResponse = gfx.sprite.kCollisionTypeBounce
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
    if pd.buttonIsPressed(pd.kButtonRight) and playerSpeed > 0 then
        direction = 1
        PlayerSprite:setImage(PlayerAnimationLoop:image(), 0, 1, 1)
        PlayerArmSprite:moveBy(playerSpeed * direction, 0)
        PlayerSprite:moveBy(playerSpeed * direction, 0)
    end
    
    if pd.buttonIsPressed(pd.kButtonLeft) and playerSpeed > 0 then
        direction = -1
        PlayerSprite:setImage(PlayerAnimationLoop:image(), 1, 1, 1)
        PlayerArmSprite:moveBy(playerSpeed * direction, 0)
        PlayerSprite:moveBy(playerSpeed * direction, 0)
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
        -- choose a random inital velocity
        InitialVelocity = math.random(8, 15)
        BallVelocityX = InitialVelocity * math.cos(angleRadians)
        BallVelocityY = InitialVelocity * math.sin(angleRadians)
        
        BallImmunityCounter = 0
        PlayerArmSprite:clearCollideRect()
        ArmCollisionEnabled = false
        GameState = "ShootBall"
    end
end

function CanDash()
    if pd.buttonJustPressed(pd.kButtonB) and dashing == false then
        PlayerSprite:setRotation(90, 1, 1)
        if direction == -1 then
            PlayerSprite:setImage(PlayerDashAnimationLoop:image(), 1, 1, 1)
        else
            PlayerSprite:setImage(PlayerDashAnimationLoop:image(), 0, 1, 1)
        end
        dashing = true
    end
end
function StartDash()
    if dashDuration < dashTime then
        local x, y = PlayerSprite:getPosition()
        -- stop player from moving
        playerSpeed = 0
        PlayerArmSprite:moveTo(x + (dashSpeed * direction), y)
        PlayerSprite:moveTo(x + (dashSpeed * direction), y)
        playerSpeed = 5
        dashDuration += 1
        dashSpeed *= 0.95
    else
        dashing = false
        PlayerSprite:setRotation(0, 1, 1)
        if direction == -1 then
            PlayerSprite:setImage(PlayerRightStatic, 1, 1, 1)
        else
            PlayerSprite:setImage(PlayerRightStatic, 0, 1, 1)
        end
        
        dashDuration = 0
        dashSpeed = 10
    end
end

function CanPaddle()

end

function PlayerCaughtState()
    PlayerArmSprite:setImage(PlayerShootArm)
    CanShoot()
    BasicMovement()
end

function PlayerShootState()
    PlayerArmSprite:setImage(ArmNoBall)
    BasicMovement()
    CanDash()
    if dashing == true then
        StartDash()
    end
end

function StopPlayer()
    PlayerSprite:moveBy(playerSpeed * -direction, 0)
    PlayerArmSprite:moveBy(playerSpeed * -direction, 0)
end
