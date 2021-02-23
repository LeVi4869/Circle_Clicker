display.setDefault( "background", 0, 0.3, 0.8 )

local physics = require("physics")
physics.start()
physics.setGravity( 0, 50 )

local function startGame()
local score = 0
display.remove(Button)

local Starter = display.newCircle( 900, 600, 30)
physics.addBody( Starter, "static")
Starter:setFillColor( 0.5 )

  local xCoord = math.random( 100, 900 )
  local yCoord = math.random( 100, 600 )
  Circle = display.newCircle( 500, 300, 20)
--physics.addBody( circle, "static")

Instructions = display.newText( "Tap the bottom right button to reset", display.contentCenterX, 40, native.systemFont, 28 )
Instructions:setFillColor( 1 )
Score = display.newText( score, 900, 40, native.systemFont, 28 )

local function endCooldown()
  Cooldown = false;
end

local function accurate()
  if Cooldown == false then
    local xCoord = math.random( 100, 900 )
    local yCoord = math.random( 100, 500 )
    transition.to( Circle, { time=0, x=xCoord, y=yCoord } )
    score = score + 1
    display.remove(Score)
    Score = display.newText( score, 900, 40, native.systemFont, 28 )
    Cooldown = true;
  end
  timer.performWithDelay(200, endCooldown);
end

local function reset()
  score = 0
  display.remove(Circle);
  display.remove(Starter);
  display.remove(Instructions);
  display.remove(Score);
  startGame();
end

Starter:addEventListener( "touch", reset)
Circle:addEventListener( "touch", accurate)

end
Cooldown = false;
Button = display.newImage( "Capture.png", 500, 200)
Button:addEventListener("touch", startGame)

--local startButton = display.newRect(parent,x,y,width,height);
--local button = widget.newButton(options);