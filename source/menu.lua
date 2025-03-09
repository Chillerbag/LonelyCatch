local pd = playdate
local gfx = pd.graphics

-- render menu and get high score

function RenderMenu()
    -- todo: shouldnt add every frame
    TitleSprite:add()
    TitleSprite:moveTo(200, 60)
    gfx.drawText("Press B to Start", 140, 120)
    gfx.drawText("High Score: " .. HiScore, 140, 160)
    if pd.buttonJustPressed(pd.kButtonB) then
        Score = 0
        TitleSprite:remove()
        GameState = "Starting"
    end
end
