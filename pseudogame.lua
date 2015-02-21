local composer = require "composer"
local scene = composer.newScene()
local physics = require("physics")
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )
   local sceneGroup = self.view

   --display.setDefault( "background", grey )
   physics.start()
   physics.setGravity( 0, 9.8 )
   ball = display.newCircle(display.contentCenterX,display.contentCenterY,25) -- centers the ball, not final position
   physics.addBody(ball)
   ball.bodyType = "dynamic"
   ball:setFillColor( grey )
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


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        print("menu")
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene




