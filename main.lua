display.setStatusBar( display.HiddenStatusBar )

local composer = require( "composer" )

local scene = composer.newScene()

composer.recycleOnSceneChange = true


composer.gotoScene( "loadingscene" )



return scenes