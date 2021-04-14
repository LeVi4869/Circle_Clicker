--Initialization
local physics = require("physics")
physics.start()
physics.setGravity( 0, 50 )
--Starts the game
function StartGame()
  display.setDefault( "background", 0, 0, 0 )
  InGame = true;
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

  Clicks = 0;
  Hits = 0;

  Accuracy = string.format( "0.00" )
  
  local function endClickCooldown()
    ClickCooldown = false;
  end

  local function OnMouseEvent(event)
    if (event.phase == "began") then
        if InGame == true then
          if ClickCooldown == false then
            Clicks = Clicks + 1;
            display.remove(AccuracyText);
            if Clicks == 0 then
              Accuracy = string.format( "100.00" )
            else
              Accuracy = string.format( "%.2f", (Hits/Clicks)*100 )
            end
            AccuracyText = display.newText( Accuracy, 800, 90, native.systemFont, 40 )
            ClickCooldown = true;
          end
      end
    elseif (event.phase == "ended") then
    endClickCooldown();
    end
  end
              
  -- Add the mouse event listener.
  Runtime:addEventListener("touch", OnMouseEvent )

  CountDownTimer = timer.performWithDelay( 1000, UpdateTime, secondsLeft )
  local CS = CSField.text
  local score = 0
  display.remove(StartButton)
  display.remove(CSField)
  display.remove(CSText)
  display.remove(TimerField)
  display.remove(TimerText)

  local ResetButton = display.newCircle(970, 700, 30)
  physics.addBody( ResetButton, "static")
  ResetButton:setFillColor( 0.5 )

  Circle = display.newCircle( 500, 300, 160/CS);

  Instructions = display.newText( "Tap the bottom right button to reset", display.contentCenterX, 40, native.systemFont, 28 )
  Instructions:setFillColor( 1 )
  Score = display.newText( score, 900, 40, native.systemFont, 28 )


  local function accurate()
    if ClickCooldown == false then
      local xCoord = math.random( 60, 960 )
      local yCoord = math.random( 150, 650 )
      transition.to( Circle, { time=0, x=xCoord, y=yCoord } )
      score = score + 1
      Hits = Hits + 1;
      display.remove(Score)
      Score = display.newText( score, 900, 40, native.systemFont, 28 )
    end
  end

  function ScoreScreen()  
    display.setDefault( "background", 0, 0.3, 0.8 )
    display.remove(Circle);
    display.remove(ResetButton);
    display.remove(Instructions);
    display.remove(Score);
    display.remove(AccuracyText);
    display.remove(ClockText);
    display.remove(AccuracyText);
    InGame = false;
    local result = string.format( "Hits: %02d", score )
    ResultScoreText = display.newText( result, display.contentCenterX, 200, native.systemFont, 50 )
    local resultAcc = string.format("Accuracy: %s", Accuracy)
    ResultAccText = display.newText( resultAcc, display.contentCenterX, 300, native.systemFont, 50 )
    local res_points = (Hits/Clicks) * 1000 * score;
    local resultPoints = string.format("Final Score: %d", res_points);
    ResultPointsText = display.newText( resultPoints, display.contentCenterX, 400, native.systemFont, 50 )
    MenuButton = display.newImage("Menu_Button.png", display.contentCenterX, 500);
    MenuButton:addEventListener("touch", StartScreen)
  end

  function Reset()
    score = 0
    display.remove(Circle);
    display.remove(ResetButton);
    display.remove(Instructions);
    display.remove(Score);
    display.remove(AccuracyText);
    display.remove(ClockText);
    timer.cancel(CountDownTimer);
    StartScreen();
  end

  ResetButton:addEventListener( "touch", Reset)
  Circle:addEventListener( "touch", accurate)

end

function Start(event)  
  if (event.phase == "began") then
  elseif (event.phase == "ended") then
    StartGame();
  end
end

function StartScreen()
  display.setDefault( "background", 0, 0.3, 0.8 )
  display.remove(ResultScoreText);
  display.remove(ResultAccText);
  display.remove(ResultPointsText);
  display.remove(MenuButton);
  InGame = false;
  StartButton = display.newImage( "Capture.png", 500, 200)
  StartButton:addEventListener("touch", Start)
  CSField = native.newTextField( 500, 400, 100, 50 )
  CSField.inputType = "decimal";
  CSText = display.newText( "CircleSize:", 300, 400, native.systemFont, 28 )
  TimerField = native.newTextField( 500, 500, 100, 50 )
  TimerField.inputType = "decimal";
  TimerText = display.newText( "Time Allowed:", 300, 500, native.systemFont, 28 )
end
display.setDefault( "background", 0, 0.3, 0.8 )
StartButton = display.newImage( "Capture.png", 500, 200)
  StartButton:addEventListener("touch", Start)
  CSField = native.newTextField( 500, 400, 100, 50 )
  CSField.inputType = "decimal";
  CSText = display.newText( "CircleSize:", 300, 400, native.systemFont, 28 )
  TimerField = native.newTextField( 500, 500, 100, 50 )
  TimerField.inputType = "decimal";
  TimerText = display.newText( "Time Allowed:", 300, 500, native.systemFont, 28 )