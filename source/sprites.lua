local pd = playdate
local gfx = pd.graphics

-- imgs (global)
ArmNoBall = gfx.image.new("images/armWithBallReleased.png")
PlayerRightStatic = gfx.image.new("images/botRightStatic")
PlayerShootArm = gfx.image.new("images/armNoBall")
BallImg = gfx.image.new("images/ball.png")

-- sprites (global)
PlayerArmSprite = gfx.sprite.new(PlayerShootArm)
PlayerSprite = gfx.sprite.new(PlayerRightStatic)
BallSprite = gfx.sprite.new(BallImg)