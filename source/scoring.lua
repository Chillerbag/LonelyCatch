function SaveHiScore()
    -- Save game data into a table first
    local gameData = {
        HiScore = Score
    }
    -- Serialize game data table into the datastore
    playdate.datastore.write(gameData, "LonelyScore")
end

function LoadHiScore()
    local gameData = pd.datastore.read("LonelyScore")
    if not gameData then
        HiScore = 0
    else
        HiScore = gameData["HiScore"]
    end
end

function RenderScore()
    local scoreStr = "Score: " .. Score
    
    if GameState == "ShootBall" then
        local scoringTable = ReadScoringTable()
        local pendingPoints = scoringTable.bounce + scoringTable.catch
        local multiplier = scoringTable.dashBounceMult + scoringTable.wallBounceMult
        
        if pendingPoints > 1 then
            scoreStr = "Score: " .. Score .. " + " .. pendingPoints
            
            if multiplier > 1 then
                scoreStr = scoreStr .. " x " .. multiplier
            end
        end
    end

    gfx.drawText(scoreStr, 25, 10)
end

function AddToScore()
    local scoringTable = ReadScoringTable()
    local pendingPoints = scoringTable.bounce + scoringTable.catch
    local multiplier = scoringTable.dashBounceMult + scoringTable.wallBounceMult
    local aggScore = 0
    if multiplier ~= 0 then
        aggScore = pendingPoints * multiplier
    else
        aggScore = pendingPoints
    end
    if scoringTable.dashCatch == 1 then
        aggScore *= 3
    end
    return aggScore
end
