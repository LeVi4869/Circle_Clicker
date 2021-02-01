-- Project #5 - Here's an empty project for you to work with.
-- (Your changes to this project are saved automatically for the duration of this session.)
display.setDefault( "background", 0, 0.3, 0.8 )

local physics = require("physics")
physics.start()
physics.setGravity( 0, 50 )

local score = 0

local starter = display.newCircle( 900, 600, 30)
physics.addBody( starter, "static")
starter:setFillColor( 0.5 )

  local xCoord = math.random( 100, 900 )
  local yCoord = math.random( 100, 600 )
  local circle = display.newCircle( 500, 300, 20)
--physics.addBody( circle, "static")

local instructions = display.newText( "Tap the shield to start, press the star to reset", display.contentCenterX, 40, "fonts/OpenSansRegular.ttf", 28 )
instructions:setFillColor( 1 )
  instructions = display.newText( score, 900, 40, native.systemFont, 28 )


local function accurate()
  local xCoord = math.random( 100, 900 )
  local yCoord = math.random( 100, 500 )
  transition.to( circle, { time=0, x=xCoord, y=yCoord } )
  score = score + 1
  display.remove(instructions)
  instructions = display.newText( score, 900, 40, native.systemFont, 28 )
end

local function reset()
  score = 0
  display.remove(instructions)
  instructions = display.newText( score, 900, 40, native.systemFont, 28 )
end

starter:addEventListener( "touch", reset)
circle:addEventListener( "touch", accurate)

