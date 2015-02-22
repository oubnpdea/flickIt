local composer = require "composer"
local scene = composer.newScene()
local physics = require("physics")
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

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

-- "scene:create()"
function scene:create( event )
   local sceneGroup = self.view
   print("create called")
   display.setDefault( "background", grey )
   print("background = grey")
   physics.start()
   print("physics started")
   physics.setGravity( 0, 9.8 )
   print("setGravity")
   ball = display.newCircle(display.contentCenterX,display.contentCenterY,25) -- centers the ball, not final position
   print("ball created")
   physics.addBody(ball)
   print("ball added")
   ball.bodyType = "dynamic"
   print("dynamic ball")
   ball:setFillColor( grey )
   print("ball filled")
   sceneGroup:insert(ball)
   print("ball inserted")
    detector = timer.performWithDelay( 0, collisiondetector ,0 ) --checks if ball hit the top of the screen or not
    print("detector")
    ball:addEventListener( "touch", flick )
    print("ball event listener added")
end


-- "scene:show()"
function scene:show( event )
     print("show called")
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        print("will (pseudo)")
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        print("menu")
    end
end


-- "scene:hide()"
function scene:hide( event )
     print("hide called")
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
     print("destroy called")
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




