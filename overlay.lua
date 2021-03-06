local composer = require( "composer" )
local widget = require ("widget")
local overlay = composer.newScene()



local function reset (event)
	if event.phase == "ended" then
		print( "this is working" )
		composer.hideOverlay( "fade", 400 )
		composer.removeScene( "level"..level )
		composer.removeScene("overlay")
		composer.gotoScene("level"..level, "fade", 400)
	end
end

function winner()
	composer.removeScene("level"..level)
	composer.gotoScene("level"..(level+1))
end


function overlay:create(event)
	local overlayGroup = self.view
	backgroundOverlay = display.newRect (display.contentCenterX,display.contentCenterY, 360, 670)
	backgroundOverlay:setFillColor( black )
	backgroundOverlay.alpha = 0.4
  local win = event.params
	i = 0
	for k, v in pairs( win ) do
		if i == 0 then
   		win = v
		elseif i == 1 then
			level = v
		end
		i = i + 1
	end
	goto = "level"..(level+1)
	print("goto = " .. goto)
	print("level = " .. level)
  if win == "true" then
    didWin = display.newImage("overlayBlue.png", display.contentCenterX/20, display.contentCenterY/20)
    didWin.x = display.contentCenterX
    didWin.y = display.contentCenterY - 25
    didWin:scale( 0.35, 0.35 )
    	local completeLabel = widget.newButton
		{
			x = display.contentCenterX,
			y = display.contentCenterY-85,
			label = "Complete!",
			labelXOffset = 2,
			font = "HelveticaNeue-Thin",
			labelColor = {default={1,1,1}, over = {1,1,1}},
			textOnly = true,
			fontSize = 36,
			isEnabled = false
		}

		local levelLabel = widget.newButton
		{
			x = display.contentCenterX,
			y = display.contentCenterY-30,
			label = "Level "..level,
			font = "HelveticaNeue-Bold",
			labelColor = {default={1,1,1}, over = {1,1,1}},
			textOnly = true,
			fontSize = 40,
			isEnabled = false
		}
		local button1 = widget.newButton
		{
			x = display.contentCenterX-50,
			y = display.contentCenterY+40,
		    width = 60,
		    height = 60,
	      	defaultFile = "resetButton.png",
	      	overFile = "resetButtonClicked.png",
			onEvent = reset
		}
		local button2 = widget.newButton
		{
			x = display.contentCenterX+50,
			y = display.contentCenterY+40,
		    width = 60,
		    height = 60,
	      	defaultFile = "continueButton.png",
	      	overFile = "continueButton.png",
			onEvent = winner
		}
	overlayGroup:insert(backgroundOverlay)
	overlayGroup:insert(didWin)
	overlayGroup:insert(completeLabel)
	overlayGroup:insert(levelLabel)
	overlayGroup:insert(button2)
	overlayGroup:insert(button1)
  else
    didWin = display.newImage("overlayRed.png", display.contentCenterX/20, display.contentCenterY/20)
    didWin.x = display.contentCenterX
    didWin.y = display.contentCenterY - 25
    didWin:scale(0.35, 0.35)
		local label1 = widget.newButton
		{
			x = display.contentCenterX,
			y = display.contentCenterY-85,
			label = "Game Over",
			font = "HelveticaNeue-Thin",
			labelColor = {default={1,1,1}, over = {1,1,1}},
			textOnly = true,
			fontSize = 36,
			isEnabled = false
		}
		local label2 = widget.newButton
		{
			x = display.contentCenterX,
			y = display.contentCenterY-30,
			label = "Level " .. level,
			font = "HelveticaNeue-Bold",
			labelColor = {default={1,1,1}, over = {1,1,1}},
			textOnly = true,
			fontSize = 40,
			isEnabled = false
		}
		local button1 = widget.newButton
		{
			x = display.contentCenterX,
			y = display.contentCenterY+40,
		    width = 60,
		    height = 60,
	      	defaultFile = "resetButton.png",
	      	overFile = "resetButtonClicked.png",
			onEvent = reset
		}
	overlayGroup:insert(backgroundOverlay)
	overlayGroup:insert(didWin)
	overlayGroup:insert(button1)
	overlayGroup:insert(label1)
	overlayGroup:insert(label2)
  end
end


function overlay:show(event)
	local overlayGroup = self.view
	local phase = event.phase
	if phase == "did" then

	end
end

function overlay:hide( event )
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

function overlay:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
end



overlay:addEventListener( "create", overlay )
overlay:addEventListener( "show", overlay )
overlay:addEventListener( "hide", overlay )
overlay:addEventListener( "destroy", overlay )

return overlay
