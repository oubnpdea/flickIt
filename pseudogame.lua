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
local overlay = require("overlay")
physics.start(); physics.pause()
--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5


function scene:resumeGame()
	composer.hideOverlay()
	reset()
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- create a grey rectangle as the backdrop
	display.setDefault( "background", .14, .23, .31)
  physics.setGravity(0,30)
	ball = display.newImage("ball.png", display.contentCenterX, display.contentCenterY + 220  )
  ball:scale( 0.1, 0.1 )

  target = display.newImage( "targetCover.png", display.contentCenterX, display.contentCenterY - 30 )
  target:scale( 0.3, 0.2 )

  line1 = display.newRect( 0, display.contentCenterY+28,display.contentWidth*2, 1)
  physics.addBody(line1, "static", {density = 0, friction = 0, bounce = 0, isSensor = true,filter = {maskBits = 12, categoryBits = 2}})
  line1:setFillColor( 0.5 )

  line2 = display.newRect( 0, display.contentCenterY-60+28,display.contentWidth*2, 1)
  physics.addBody(line2, "static", {density = 0, friction = 0, bounce = 0, isSensor = true,filter = {maskBits = 12, categoryBits = 2}}) --detection line, must be placed 60px above the initial line

  line3 = display.newRect( 0, display.contentCenterY-92,display.contentWidth*2, 1)
  physics.addBody(line3, "static", {density = 0, friction = 0, bounce = 0, isSensor = true,filter = {maskBits = 12, categoryBits = 2}})
  line3:setFillColor( 0.5 )
  count = 0
  collide1 = 0
  collide2 = 0
  collide3 = 0
  attempt = widget.newButton
	{
		x = display.contentCenterX+130,
		y = display.contentCenterY+300,
		label = "Attempt 0",
		font = "HelveticaNeue-Thin",
		labelColor = {default={1,1,1}, over = {1,1,1}},
		textOnly = true,
		isEnabled = false
	}
	attempts = 0

  function onComplete( event )
   if event.action == "clicked" then
        alerts = 0
        local i = event.index
        if i == 1 then
          ball.bodyType = "static"
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
      ball.bodyType = "static"
  		ball.x = display.contentCenterX
  		ball.y = display.contentCenterY + 220
      collide1 = 0
      collide2 = 0
      collide3 = 0
			attempts = 0
			attempt:setLabel("Attempt " .. attempts)
  	end
  end

  local button1 = widget.newButton
	{
	    width = 45,
	    height = 45,
      defaultFile = "resetButton.png",
      overFile = "resetButtonClicked.png",
	    onEvent = reset
	}

	-- Center the button
	button1.x = display.contentCenterX - 150
	button1.y = display.contentCenterY + 290

	physics.addBody(ball, "static", {friction=1, bounce = 0.3, radius=30, isSleeping = false,filter = {maskBits = 10, categoryBits = 4}})

  function flick(event)
    count = 0
      if event.phase == "began" then
				attempts = attempts+1
        physics.setGravity(0,0)
        display.getCurrentStage():setFocus( ball )
        self.isFocus = true
        startX = event.x
				x1, x2 = startX, startX
        startY = event.y
				y1, y2 = startY, startY
				ball.bodyType = "dynamic"
				time1 = system.getTimer()
      elseif event.phase == "moved" then
        --dragging the bal
				x2 = x1
				y2 = y1
				x1 = event.x
				y1 = event.y
        ball.x = event.x
        ball.y = event.y
        physics.setGravity(0,0)
      elseif event.phase == "ended" then
        --applying force on the ball
				time2 = system.getTimer()
        display.getCurrentStage():setFocus( nil )
        self.isFocus = nil
        print( time1 )
        print( time2 )
        local a = 350
        totalTime = time2 - time1
        totalTimehalf = totalTime * 2
        distance = x2 - x1
        forceApplied = a*(x1-x2)/totalTimehalf
        print( "the total distance is:" .. distance )
        print( "the total force applied was:" .. forceApplied )
        --[[if totalTime < 100 and distance == 0 then
          print( "2nd event triggered" )
          ball:applyForce(-1050/totalTime, -1050/totalTime, ball.x, ball.y)
        elseif totalTime < 100 and distance <= 2 then
          print( "this is supah fast" )
          ball:applyForce(a*(x1-x2)/200, a*(y1-y2)/200, ball.x, ball.y)
        else]]--
          --ball:applyForce(a*(x1-x2)/totalTimehalf, a*(y1-y2)/totalTimehalf, ball.x, ball.y)
        local a = 250
        ball:applyForce(a*(x1-x2)/(time2-time1), a*(y1-y2)/(time2-time1), x1, y1)
				attempt:setLabel("Attempt " .. attempts)
      end
      physics.setGravity(0,24)
			return true
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
					composer.showOverlay("overlay", { isModal = true, effect = "fade", time = 400, params = { win = false }})
						attempts = 0
						attempt:setLabel("Attempt " .. attempts)
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
        composer.showOverlay("overlay", { isModal = true, effect = "fade", time = 400, params = { win = true }})
        collide1 = 0
       collide2 = 0
        collide3 = 0
				attempts = 0
				attempt:setLabel("Attempt " .. attempts)
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
  sceneGroup:insert(target)
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
