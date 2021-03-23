--Initialization
display.setDefault( "background", 0, 0.3, 0.8 )
local physics = require("physics")
physics.start()
physics.setGravity( 0, 50 )

--Starts the game
function StartGame()
local CS = NumericField.text
local score = 0
display.remove(StartButton)
display.remove(NumericField)
display.remove(SettingsText)

local ResetButton = display.newCircle(1100, 720, 30)
physics.addBody( ResetButton, "static")
ResetButton:setFillColor( 0.5 )

Circle = display.newCircle( 500, 300, 160/CS);

Instructions = display.newText( "Tap the bottom right button to reset", display.contentCenterX, 40, native.systemFont, 28 )
Instructions:setFillColor( 1 )
Score = display.newText( score, 900, 40, native.systemFont, 28 )

local function endCooldown()
  Cooldown = false;
end

local function accurate()
  if Cooldown == false then
    local xCoord = math.random( 20, 1000 )
    local yCoord = math.random( 100, 650 )
    transition.to( Circle, { time=0, x=xCoord, y=yCoord } )
    score = score + 1
    display.remove(Score)
    Score = display.newText( score, 900, 40, native.systemFont, 28 )
    Cooldown = true;
  end
  timer.performWithDelay(200, endCooldown);
end

function Reset()
  score = 0
  display.remove(Circle);
  display.remove(ResetButton);
  display.remove(Instructions);
  display.remove(Score);
  StartScreen();
end

ResetButton:addEventListener( "touch", Reset)
Circle:addEventListener( "touch", accurate)

end

function StartScreen()
  StartButton = display.newImage( "Capture.png", 500, 200)
  StartButton:addEventListener("touch", StartGame)
  NumericField = native.newTextField( 500, 400, 100, 50 )
  NumericField.inputType = "decimal";
  SettingsText = display.newText( "CircleSize:", 300, 400, native.systemFont, 28 )
end

Cooldown = false;
StartButton = display.newImage( "Capture.png", 500, 200)
StartButton:addEventListener("touch", StartGame)
NumericField = native.newTextField( 500, 400, 100, 50 )
NumericField.inputType = "decimal";
SettingsText = display.newText( "CircleSize:", 300, 400, native.systemFont, 28 )