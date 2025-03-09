local pd = playdate
local gfx = pd.graphics

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
    WallSpriteL:setCollideRect(380, 0, 20, 225)
    WallSpriteL:add()

    WallSpriteR = gfx.sprite.new()
    WallSpriteR:setCollideRect(0, 0, 20, 225)
    WallSpriteR:add()
end

