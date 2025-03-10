local pd = playdate
local gfx = pd.graphics

-- this is awful. We need to rewrite this
local scoringTable

local DEFAULT_SCORING_TABLE = {
    dashBounceMult = 0,
    bounce = 0,
    wallBounceMult = 0,
    dashCatch = 0,
    catch = 1 -- default point
}

function ResetScoringTable()
    -- Create a new table with the default values
    scoringTable = {}
    for k, v in pairs(DEFAULT_SCORING_TABLE) do
        scoringTable[k] = v
    end
end

function ReadScoringTable()
    return scoringTable
end

-- kill this, later
function HandlePlayerCollisions()
    -- todo: rewrite with collisions object.
    local collisions = gfx.sprite.allOverlappingSprites()

    for _, collisionPair in ipairs(collisions) do
        local sprite1, sprite2 = collisionPair[1], collisionPair[2]
        
        local isWallCollision = (sprite1 == WallSpriteL or sprite1 == WallSpriteR or 
                                 sprite2 == WallSpriteL or sprite2 == WallSpriteR)

        local isPlayerCollision = (sprite1 == PlayerSprite or sprite2 == PlayerSprite)

        if isPlayerCollision and isWallCollision then 
            StopPlayer()
        end
    end
end

function HandleBallFloor()
    EndGame()
end

function HandleBallWall()
    BallVelocityX = -BallVelocityX * 0.9
    scoringTable.wallBounceMult += 1

end

function HandleBallCatch()
    if PlayerCatching == true then
        -- TODO: make scoring more interesting
        -- have to do a unique combo, etc.
        if GetPlayerisDashing() then
            scoringTable.dashCatch = 1
        end
        local tempScore = AddToScore()
        if tempScore ~= 1 then
            Score += tempScore
        end
        GameState = "Caught"
        BallSprite:removeSprite()
        BallCreated = false
        PlayerArmSprite:clearCollideRect()
        PlayerSprite:setRotation(0, 1, 1)
        ArmCollisionEnabled = false
        ResetScoringTable()
    else 
        if GetPlayerisDashing() then
            scoringTable.dashBounceMult += 1
        else
            scoringTable.bounce += 1
        end
        SinSynth:playNote(1318.63, 1, 0.05, 0)
        SinSynth:playNote(1318.63, 1, 0.05, 0.06)
        local randomFactor = math.random(1, 3) * GetPlayerDirection()
        BallVelocityY = -BallVelocityY + randomFactor
        BallVelocityX = -BallVelocityX + randomFactor
        PlayerArmSprite:clearCollideRect()
        ArmCollisionEnabled = false
        BallImmunityCounter = 0
    end
end