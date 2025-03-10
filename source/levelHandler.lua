function RenderLevel()
    RenderScore()
    -- draw the borders of the room
    gfx.drawLine(20, 225, 380, 225)
    gfx.drawLine(380, 0, 380, 225)
    gfx.drawLine(20, 0, 20, 225)
end

function LevelStartup()
    FloorSprite = gfx.sprite.new()
    FloorSprite:setCollideRect(20, 225, 360, 15)
    FloorSprite:add()

    WallSpriteL = gfx.sprite.new()
    WallSpriteL:setCollideRect(380, -600, 20, 1000)
    WallSpriteL:add()

    WallSpriteR = gfx.sprite.new()
    WallSpriteR:setCollideRect(0, -600, 20, 1000)
    WallSpriteR:add()
end

function EndGame()
    SquareSynth:playMIDINote("D3", 1, 0.5)
    -- TODO: change this to use a spriteArray
    if Score > HiScore then
        SaveHiScore()
        gfx.drawTextAligned("Game Over", 200, 20, kTextAlignment.center)
        gfx.drawTextAligned("New High Score", 200, 40, kTextAlignment.center)
        pd.wait(1000)
        HiScore = Score
    end

    gfx.drawTextAligned("Game Over", 200, 20, kTextAlignment.center)
    pd.wait(500)

    BallCreated = false
    PlayerCatching = false
    ArmCollisionEnabled = false

    -- reset player rotation (if in dash)
    PlayerSprite:setRotation(0, 1, 1)
    ResetScoringTable()
    gfx.sprite.removeAll()
    GameState = "Menu"
end

