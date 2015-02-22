-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local gameUI = require("gameUI")
-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5


function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- create a grey rectangle as the backdrop
	display.setDefault( "background", 0.1,0.2,0.3 )
  physics.setGravity(0,12)
  ball = display.newCircle(display.contentCenterX,display.contentCenterY+200,25)
  ball.linearDamping = 0.4
  ball.angularDamping = 0.6
  local dragBody = gameUI.dragBody
  ball:addEventListener( "touch", dragBody )
  function flick(event)
    return gameUI.dragBody(event)
    --
      --if event.phase == "began" then
        --physics.setGravity(0,0)
        --startX = event.x
        --startY = event.y
        --physics.addBody(ball, "dynamic", {friction=1.5, bounce = 0.3, radius=25, isSleeping = false,filter = {maskBits = 10, categoryBits = 4}})
      --elseif event.phase == "moved" then
        --dragging the ball
        --ball.x = event.x
        --ball.y = event.y
        --physics.setGravity(0,12)
      --elseif event.phase == "ended" then
        --applying force on the ball
        --ball:applyForce(-(startX-event.x)*.3, -(startY-event.y)*.3, 0, 0)
      --end
      --
    end

  local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
        print("collision detected")
    elseif ( event.phase == "ended" ) then
        print( "collision over" )
    end
  end

  topWall = display.newRect( display.contentWidth*0.5, 0,display.contentWidth+20, 25 )
  bottomWall = display.newRect( display.contentWidth*0.5, display.contentHeight, display.contentWidth+20, 25 )
  leftWall = display.newRect( -5, display.contentHeight*0.5, 30, display.contentHeight+20 )
  rightWall = display.newRect( display.contentWidth+5, display.contentHeight*0.5, 30, display.contentHeight+20 )
  physics.addBody(topWall, "static", {density = 15, friction = 1, bounce = 0, isSensor = false,filter = {maskBits = 12, categoryBits = 2}})
  physics.addBody(bottomWall, "static", {density = 15, friction = 1, bounce = 0, isSensor = false,filter = {maskBits = 12, categoryBits = 2}})
  physics.addBody(leftWall, "static", {density = 15, friction = 1, bounce = 0, isSensor = false,filter = {maskBits = 12, categoryBits = 2}})
  physics.addBody(rightWall, "static", {density = 15, friction = 1, bounce = 0, isSensor = false,filter = {maskBits = 12, categoryBits = 2}})

  topWall.collision = onLocalCollision
  topWall:addEventListener( "collision", topWall )

  sceneGroup:insert(ball)
  sceneGroup:insert(topWall)
  sceneGroup:insert(bottomWall)
  sceneGroup:insert(leftWall)
  sceneGroup:insert(rightWall)
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
		physics.start()
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
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene