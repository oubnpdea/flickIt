-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"
display.setDefault( "background", gray )
composer.gotoScene( "pseudogame" )


-- load menu screen
