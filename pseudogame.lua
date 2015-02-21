--  _____   _____ ______ _    _ _____   ____     _____ ____  _____  ______ 
-- |  __ \ / ____|  ____| |  | |  __ \ / __ \   / ____/ __ \|  __ \|  ____|
-- | |__) | (___ | |__  | |  | | |  | | |  | | | |   | |  | | |  | | |__   
-- |  ___/ \___ \|  __| | |  | | |  | | |  | | | |   | |  | | |  | |  __|  
-- | |     ____) | |____| |__| | |__| | |__| | | |___| |__| | |__| | |____ 
-- |_|    |_____/|______|\____/|_____/ \____/   \_____\____/|_____/|______| 

--LUA IS TOP DOWN LANGUAGE, BE SURE TO DECLARE ALL YOUR VARIABLES AND FUNCTIONS BEFORE CALLING THEM

local composer = require "composer"
local scene = composer.newScene()
display.setStatusBar( display.HiddenStatusBar )
physics = require("physics")

function scene:create( event )
	
	local sceneGroup = self.view
	
	print( "this works?" )
	physics.start()
	physics.setGravity( 0, 9.8 ) --standard earth gravity, we can change this value later on

	display.setDefault( "background", 255,255,255 )
	
	ball = display.newCircle(display.contentCenterX,display.contentCenterY,25) -- centers the ball, not final position
	physics.addBody(ball)
	ball.bodyType = "dynamic"
	ball:setFillColor( grey )
	 -- generates the cirle that's flicked, put in position info later
	 --keep it static here so the ball doesn't fall on start
	 --change to dynamic in the flick function
	sceneGroup:insert(ball)


	function flick (event) --function that checks for flick and applies proper force
    	if event.phase == "began" then
     	--ball.bodyType = "dynamic" --now the ball is able to move and respond to gravity
    	elseif event.phase == "moved" then
        	--dragging the ball
        	ball.x = event.x
        	ball.y = event.y
    	elseif event.phase == "ended" then
        	--applying force on the ball
        	ball:applyForce( (ball.x) * 0.5, (ball.y) * 0.5, ball.x, ball.y )
     	end
   	end

    function collisiondetector (event)
     	if ball.y == 0 then 
     		composer.gotoScene( "gameEnd")
     		timer.cancel( detector )
     	end
    end 

    detector = timer.performWithDelay( 0, collisiondetector ,0 ) --checks if ball hit the top of the screen or not
    ball:addEventListener( "touch", flick )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
end


---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
--scene:addEventListener( "show", scene )
--scene:addEventListener( "hide", scene )
--scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
