--Initialization
display.setDefault( "background", 0, 0.3, 0.8 )
local physics = require("physics")
physics.start()
physics.setGravity( 0, 50 )

--Starts the game
function StartGame()
  local secondsLeft = TimerField.text  -- 10 minutes * 60 seconds
  secondsLeft = secondsLeft - 1
  -- Time is tracked in seconds; convert it to minutes and seconds
  Minutes = math.floor( secondsLeft / 60 )
  Seconds = secondsLeft % 60
  StartTime = string.format( "%02d:%02d", Minutes, Seconds )
  ClockText = display.newText( StartTime, display.contentCenterX, 90, native.systemFont, 72 )
  ClockText:setFillColor( 0.7, 0.7, 1 )
  function UpdateTime()
 
    -- Decrement the number of seconds
    secondsLeft = secondsLeft - 1
    -- Time is tracked in seconds; convert it to minutes and seconds
    Minutes = math.floor( secondsLeft / 60 )
    Seconds = secondsLeft % 60
 
    -- Make it a formatted string
    local timeDisplay = string.format( "%02d:%02d", Minutes, Seconds )
    display.remove(ClockText);
    -- Update the text object
    ClockText = display.newText( timeDisplay, display.contentCenterX, 90, native.systemFont, 72 )
    ClockText:setFillColor( 0.7, 0.7, 1 )
    if secondsLeft == 0 then
      ScoreScreen();
    end
end

CountDownTimer = timer.performWithDelay( 1000, UpdateTime, secondsLeft )
local CS = CSField.text
local score = 0
display.remove(StartButton)
display.remove(CSField)
display.remove(CSText)
display.remove(TimerField)
display.remove(TimerText)

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
    local yCoord = math.random( 150, 650 )
    transition.to( Circle, { time=0, x=xCoord, y=yCoord } )
    score = score + 1
    display.remove(Score)
    Score = display.newText( score, 900, 40, native.systemFont, 28 )
    Cooldown = true;
  end
  timer.performWithDelay(200, endCooldown);
end

function ScoreScreen()  
  display.remove(Circle);
  display.remove(ResetButton);
  display.remove(Instructions);
  display.remove(Score);
  display.remove(ClockText);
  local result = string.format( "Final Score: %02d", score )
  ResultScoreText = display.newText( result, display.contentCenterX, 200, native.systemFont, 50 )
  MenuButton = display.newImage("Menu_Button.png", display.contentCenterX, 400);
  MenuButton:addEventListener("touch", StartScreen)
end

function Reset()
  score = 0
  display.remove(Circle);
  display.remove(ResetButton);
  display.remove(Instructions);
  display.remove(Score);
  display.remove(ClockText);
  timer.cancel(CountDownTimer);
  StartScreen();
end

ResetButton:addEventListener( "touch", Reset)
Circle:addEventListener( "touch", accurate)

end

function StartScreen()
  display.remove(ResultScoreText);
  display.remove(MenuButton);
  StartButton = display.newImage( "Capture.png", 500, 200)
  StartButton:addEventListener("touch", StartGame)
  CSField = native.newTextField( 500, 400, 100, 50 )
  CSField.inputType = "decimal";
  CSText = display.newText( "CircleSize:", 300, 400, native.systemFont, 28 )
  TimerField = native.newTextField( 500, 500, 100, 50 )
  TimerField.inputType = "decimal";
  TimerText = display.newText( "Time Allowed:", 300, 500, native.systemFont, 28 )
end

Cooldown = false;
StartButton = display.newImage( "Capture.png", 500, 200)
StartButton:addEventListener("touch", StartGame)
CSField = native.newTextField( 500, 400, 100, 50 )
CSField.inputType = "decimal";
CSText = display.newText( "CircleSize:", 300, 400, native.systemFont, 28 )
TimerField = native.newTextField( 500, 500, 100, 50 )
TimerField.inputType = "decimal";
TimerText = display.newText( "Time Allowed:", 300, 500, native.systemFont, 28 )