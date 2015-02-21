--  _____   _____ ______ _    _ _____   ____     _____ ____  _____  ______ 
-- |  __ \ / ____|  ____| |  | |  __ \ / __ \   / ____/ __ \|  __ \|  ____|
-- | |__) | (___ | |__  | |  | | |  | | |  | | | |   | |  | | |  | | |__   
-- |  ___/ \___ \|  __| | |  | | |  | | |  | | | |   | |  | | |  | |  __|  
-- | |     ____) | |____| |__| | |__| | |__| | | |___| |__| | |__| | |____ 
-- |_|    |_____/|______|\____/|_____/ \____/   \_____\____/|_____/|______| 

--LUA IS TOP DOWN LANGUAGE, BE SURE TO DECLARE ALL YOUR VARIABLES AND FUNCTIONS BEFORE CALLING THEM

display.setStatusBar( display.HiddenStatusBar )
local physics = require("physics")
physics.start()
physics.setGravity( 0, 9.8 ) --standard earth gravity, we can change this value later on

-- include the Corona "composer" module
local composer = require "composer"


function scene:create( event )
	local sceneGroup = self.view
	display.setDefault( "background", 1,1,1 )
	ball = display.newCircle(display.contentCenterX,display.contentCenterY,25) -- centers the ball, not final position
	physics.addBody(ball)
	ball.bodyType = "static"
	 -- generates the cirle that's flicked, put in position info later
	 --keep it static here so the ball doesn't fall on start
	 --change to dynamic in the flick function
	sceneGroup:insert(ball)


	function flick (event) --function that checks for flick and applies proper force
     if event.phase == "began" then
     	ball.bodyType = "dynamic" --now the ball is able to move and respond to gravity
     elseif event.phase == "moved" then
          --dragging the ball
          ball.x = event.x
          ball.y = event.y
     elseif event.phase == "ended" then
          --applying force on the ball
          ball:applyForce( (ball.x) * 0.5, (ball.y) * 0.5, ball.x, ball.y )
     end

     function collisiondetector (event)
     	if ball.y == 0 then 
     		composer.gotoScene( "gameEnd")
     		timer.cancel( detector )
     	end
     end 

     detector = timer.performWithDelay( 0, collisiondetector ,0 ) --checks if ball hit the top of the screen or not

end



	ball:addEventListener( "touch", flick )

end



