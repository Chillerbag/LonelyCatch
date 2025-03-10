-- imgs (global)
ArmNoBall = gfx.image.new("images/armWithBallReleased.png")
PlayerRightStatic = gfx.image.new("images/botRightStatic")
PlayerRightMove = gfx.image.new("images/botRightMove")
PlayerShootArm = gfx.image.new("images/armNoBall")
Ball = gfx.image.new("images/ball.png")
Title = gfx.image.new("images/title")
BallX, BallY = 0, 0

-- sprites (global)
PlayerArmSprite = gfx.sprite.new(PlayerShootArm)
PlayerSprite = gfx.sprite.new(PlayerRightStatic)
BallSprite = gfx.sprite.new(Ball)
TitleSprite = gfx.sprite.new(Title)

PlayerAnim = gfx.imagetable.new("images/botRightMove")
PlayerAnimationLoop = gfx.animation.loop.new(200, PlayerAnim, true)
PlayerDashAnim = gfx.imagetable.new("images/botRightDash")
PlayerDashAnimationLoop = gfx.animation.loop.new(200, PlayerDashAnim, true)