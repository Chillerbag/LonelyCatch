local rendered = false

function RenderMenu()
    -- todo: shouldnt add every frame
    if not rendered then
        TitleSprite:add()
        rendered = true
    end
    TitleSprite:moveTo(200, 60)
    gfx.drawText("Press B to Start", 140, 120)
    gfx.drawText("High Score: " .. HiScore, 140, 160)
    if pd.buttonJustPressed(pd.kButtonB) then
        Score = 0
        rendered = false
        TitleSprite:remove()
        GameState = "Starting"
    end
end
