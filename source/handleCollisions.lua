local pd = playdate
local gfx = pd.graphics

function HandleCollisions()
    -- todo: rewrite with collisions object.
    local collisions = gfx.sprite.allOverlappingSprites()

    for _, collisionPair in ipairs(collisions) do
        local sprite1, sprite2 = collisionPair[1], collisionPair[2]
        
        local isBallCollision = (sprite1 == BallSprite or sprite2 == BallSprite)
        
        local isWallCollision = (sprite1 == WallSpriteL or sprite1 == WallSpriteR or 
                                 sprite2 == WallSpriteL or sprite2 == WallSpriteR)

        local isFloorCollision = (sprite1 == FloorSprite or sprite2 == FloorSprite)

        local isCatchCollision = (sprite1 == PlayerArmSprite or sprite2 == PlayerArmSprite)

        local isPlayerCollision = (sprite1 == PlayerSprite or sprite2 == PlayerSprite)

        if isPlayerCollision and isWallCollision then 
            StopPlayer()
        end
        
        if isBallCollision and isWallCollision then
            BallVelocityX = -BallVelocityX * 0.9
        end

        if isCatchCollision and isBallCollision then
            if PlayerCatching == true then
                -- TODO: make scoring more interesting
                Score += 1
                -- have to do a unique combo, etc.
                GameState = "Caught"
                BallSprite:removeSprite()
                BallCreated = false
                PlayerArmSprite:clearCollideRect()
                ArmCollisionEnabled = false
                PlayerCatching = false
            else 
                Score += 1 
                local randomFactor = math.random(1, 3) * GetPlayerDirection()
                BallVelocityY = -BallVelocityY + randomFactor
                BallVelocityX = -BallVelocityX + randomFactor
                PlayerArmSprite:clearCollideRect()
                ArmCollisionEnabled = false
                BallImmunityCounter = 0
            end

        end

        if (isBallCollision and isFloorCollision) or (BallY > 225 or BallX < 0 or BallX > 400) then
            BallCreated = false
            PlayerCatching = false
            EndGame()
        end
    end
end