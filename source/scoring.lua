
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