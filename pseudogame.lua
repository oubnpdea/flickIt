--  _____   _____ ______ _    _ _____   ____     _____ ____  _____  ______ 
-- |  __ \ / ____|  ____| |  | |  __ \ / __ \   / ____/ __ \|  __ \|  ____|
-- | |__) | (___ | |__  | |  | | |  | | |  | | | |   | |  | | |  | | |__   
-- |  ___/ \___ \|  __| | |  | | |  | | |  | | | |   | |  | | |  | |  __|  
-- | |     ____) | |____| |__| | |__| | |__| | | |___| |__| | |__| | |____ 
-- |_|    |_____/|______|\____/|_____/ \____/   \_____\____/|_____/|______| 

display.setStatusBar( display.HiddenStatusBar )
local physics = require("physics")
physics.start()
physics.setGravity( 0, 9.8 ) --standard earth gravity, we can change this value later on

-- include the Corona "composer" module
local composer = require "composer"

function scene:create( event )
	local sceneGroup = self.view
	display.setDefault( "background", 1,1,1 )
	flicked = display.newCircle() -- generates the cirle that's flicked, put in position info later
	sceneGroup:insert(flicked)


end



