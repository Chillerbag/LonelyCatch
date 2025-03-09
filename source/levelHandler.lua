function RenderLevel()
    gfx.drawText("Score: " .. Score, 25, 10)
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
    WallSpriteL:setCollideRect(380, 0, 20, 200)
    WallSpriteL:add()

    WallSpriteR = gfx.sprite.new()
    WallSpriteR:setCollideRect(0, 0, 20, 200)
    WallSpriteR:add()
end

function EndGame()

    -- TODO: change this to use a spriteArray
    if Score > HiScore then
        SaveHiScore()
        gfx.drawTextAligned("New High Score", 200, 40, kTextAlignment.center)
        pd.wait(1000)
        HiScore = Score
    end
    
    gfx.sprite.removeAll()
    ArmCollisionEnabled = false
    GameState = "Menu"
end

