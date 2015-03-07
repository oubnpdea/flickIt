-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require ("widget")
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
  physics.setGravity(0,18)
	ball = display.newImage("ball.png", display.contentCenterX, display.contentCenterY + 220  )
  ball:scale( 0.1, 0.1 )
    
    
  line1 = display.newRect( 0, display.contentCenterY,display.contentWidth*2, 1)
  physics.addBody(line1, "static", {density = 0, friction = 0, bounce = 0, isSensor = true,filter = {maskBits = 12, categoryBits = 2}})
  line1:setFillColor( 0.5 )

  line2 = display.newRect( 0, display.contentCenterY-60,display.contentWidth*2, 1)
  physics.addBody(line2, "static", {density = 0, friction = 0, bounce = 0, isSensor = true,filter = {maskBits = 12, categoryBits = 2}}) --detection line, must be placed 60px above the initial line

  line3 = display.newRect( 0, display.contentCenterY-85,display.contentWidth*2, 1)
  physics.addBody(line3, "static", {density = 0, friction = 0, bounce = 0, isSensor = true,filter = {maskBits = 12, categoryBits = 2}})
  line3:setFillColor( 0.5 )
  count = 0
  collide1 = 0
  collide2 = 0
  collide3 = 0

  function onComplete( event )
   if event.action == "clicked" then
        alerts = 0
        local i = event.index
        if i == 1 then
          physics.removeBody( ball )
          ball.x = display.contentCenterX
          ball.y = display.contentCenterY + 220
          collide1 = 0
          collide2 = 0
          collide3 = 0
        end
    end
  end

  function reset (event)
  	if event.phase == "began" then
  		physics.removeBody( ball )
  		ball.x = display.contentCenterX
  		ball.y = display.contentCenterY + 220
      collide1 = 0
      collide2 = 0
      collide3 = 0
  	end
  end

  local button1 = widget.newButton
	{
	    width = 240,
	    height = 120,
	    label = "Reset",
	    onEvent = reset
	}

	-- Center the button
	button1.x = display.contentCenterX
	button1.y = display.contentCenterY - 150 

  function flick(event)
    count = 0
      if event.phase == "began" then
        physics.setGravity(0,0)
         tableX = {}
         tableY = {}
         tableT = {}
        startX = event.x
        startY = event.y
        tableX[0], tableY[0] = startX, startY
        tableT[0] = system.getTimer()
        physics.addBody(ball, "dynamic", {friction=1, bounce = 0.3, radius=30, isSleeping = false,filter = {maskBits = 10, categoryBits = 4}})
      elseif event.phase == "moved" then
        --dragging the ball
        i = 1
        if not x1 then
                x1 = display.contentCenterX
        end
        if not y1 then
                y1 = display.contentCenterY
        end
        x2 = x1
        y2 = y1
        x1 = event.x
        y1 = event.y
        tableX[i], tableY[i] = x1, y1
        tableT[i] = system.getTimer()
        i = i + 1
        ball.x = event.x
        ball.y = event.y
        physics.setGravity(0,0)
      elseif event.phase == "ended" then
        --applying force on the ball
        local a = 50/(tableT[1]-tableT[0])
        local xV, yV = a*(tableX[1]-tableX[0]), a*(tableY[1]-tableY[0])
        print("xV = " .. xV .. ", yV = " .. yV)
        ball:applyForce(xV, yV, ball.x, ball.y)
      end
      physics.setGravity(0,10)
  end



  local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
        collide3 = 1
        if not alerts then
                alerts = 0
        end
        alerts = alerts + 1
        count = 0
        print("collision detected")
        if alerts == 1 then
            local alert = native.showAlert( "You Lost!", "Haha you're bad at this game", { "Crap!" }, onComplete )
            
        end
    elseif ( event.phase == "ended" ) then
        print( "collision over" )
    end
  end

  local function onLocalCollisionline1( self, event )
    if ( event.phase == "began" ) then
        print("collision detected")
        collide1 = 1
        print( collide1 )
    elseif ( event.phase == "ended" ) then
        collide1 = 2
    end
  end

  local function onLocalCollisionline2( self, event )
    if ( event.phase == "began" ) then
        print("collision detected")
        collide2 = 1
    elseif ( event.phase == "ended" ) then
        collide2 = 2
    end

    if collide1 == 1 then
      count = count + 1
      print("count = "); print(count)
      if count ==  2 then
        alert = native.showAlert( "You Win", "gr8 b8 m8 i r8 8/8", { "Alright!" }, onComplete )
        collide1 = 0
       collide2 = 0
        collide3 = 0
       count = 0
      end
    end
  end






  topWall = display.newRect( display.contentWidth*0.5, -15,display.contentWidth+20, 25 )
  bottomWall = display.newRect( display.contentWidth*0.5, display.contentHeight + 14, display.contentWidth+20, 25 )
  leftWall = display.newRect( -20, display.contentHeight*0.5, 30, display.contentHeight+20 )
  rightWall = display.newRect( display.contentWidth+15, display.contentHeight*0.5, 30, display.contentHeight+20 )
  physics.addBody(topWall, "static", {density = 15, friction = 0, bounce = 0, isSensor = false,filter = {maskBits = 12, categoryBits = 2}})
  physics.addBody(bottomWall, "static", {density = 15, friction = 0, bounce = 0, isSensor = false,filter = {maskBits = 12, categoryBits = 2}})
  physics.addBody(leftWall, "static", {density = 15, friction = 0, bounce = 0, isSensor = false,filter = {maskBits = 12, categoryBits = 2}})
  physics.addBody(rightWall, "static", {density = 15, friction = 0, bounce = 0, isSensor = false,filter = {maskBits = 12, categoryBits = 2}})

  topWall.collision = onLocalCollision
  topWall:addEventListener( "collision", topWall )
  line3.collision = onLocalCollision
  line3:addEventListener( "collision", line3 )
  line1.collision = onLocalCollisionline1
  line1:addEventListener( "collision", line1 )
  line2.collision = onLocalCollisionline2
  line2:addEventListener( "collision", line2 )
	
  ball:addEventListener( "touch", flick ) --ball movement

  
  
  sceneGroup:insert(line1)
  sceneGroup:insert(line2)
  sceneGroup:insert(line3)
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