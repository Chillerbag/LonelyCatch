import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"

pd = playdate
gfx = pd.graphics

-- files with globals
-- as a note, it is not possible to do the requires syntax in the playdate 
-- runtime, so all functions are global
import "sprites"
import "globals"
import "ball"
import "handleCollisions"
import "levelHandler"
import "menu"
import "player"
import "scoring"

LoadHiScore()

function pd.update()
    -- update sprites each frame
    HandleCollisions()
    gfx.sprite.update()
    if GameState == "Menu" then
        RenderMenu()
    end

    if GameState ~= "Menu" then
        RenderLevel()
    end

    -- this may be unsafe
    if GameState == "Starting" then 
        PlayerStartup()
        LevelStartup()
        BallStartup()
        GameState = "Caught"
    end 

    -- control behaviour for when player can shoot the ball
    if GameState == "Caught" then 
        PlayerCaughtState()
    end
    
    -- control behaviour for when player can fetch the ball
    if GameState == "ShootBall" then
        ShootBall()
        PlayerShootState()
    end
end






