local composer = require( "composer" )
local widget = require ("widget")
local overlay = composer.newScene()


function overlay:create(event)
	local overlayGroup = self.view
  local win = event.params
	for k, v in pairs( win ) do
   win = v
	end
  if win == "true" then
    didWin = display.newImage("overlayBlue.png", display.contentCenterX/20, display.contentCenterY/20)
    didWin.x = display.contentCenterX
    didWin.y = display.contentCenterY - 10
    didWin:scale( 0.33, 0.33 )
  else
    didWin = display.newImage("overlayRed.png", display.contentCenterX/20, display.contentCenterY/20)
    didWin.x = display.contentCenterX
    didWin.y = display.contentCenterY - 10
    didWin:scale(0.33, 0.33)
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
