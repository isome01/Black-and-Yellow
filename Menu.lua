---i'm here right now
local composer = require( "composer" )
local widget = require("widget")
require("Level1")

local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0,4.8)

function scene:create()
	local sceneGroup = self.view
	local contentX = display.contentCenterX
	local contentY = display.contentCenterY
	
--------------------------------------------------------------------background

	local background1 = widget.newButton
	{
		left = contentX -80 ,
		top = contentY - 150,
		width = 320,
		height = 320,
		defaultFile = "Images/tree.png",
		id = "Background1",
		onEvent = background,
	}
------------------------------------------------------------------------------

--------------------------------------------------------------------Start Widget
	local function startButton( event )
		local phase = event.phase
			if "ended" == phase then 
				composer.gotoScene("Level1")
			end
	end

	local startButton1 = widget.newButton
	{
		left = contentX - 190,
		top = contentY + 50,
		width = 70,
		height = 70,
		defaultFile = "Images/Start.png",
		id = "StartButton1",
		onEvent = startButton,
	}
 -------------------------------------------------------------------

---------------------------------------------------------------------------Exit Wudget
	local function exitButton( event )
		local phase = event.phase
			if "ended" == phase then
				composer.gotoScene("loadingscene")--for now, need to change later
			end
	end

	local exitButton1 = widget.newButton
	{
		left = contentX - 240,
		top = contentY -155,
		width = 45,
		height = 35,
		defaultFile = "Images/Exit.png",
		id = "ExitButton1",
		onEvent = exitButton,
	}
---------------------------------------------------------------------------

---------------------------------------------------------------------------Setting Wudget
	local function settingButton( event )
		local phase = event.phase
			if "ended" == phase then
				composer.gotoScene("Setting")--for now, need to change later
			end
	end

	local settingButton1 = widget.newButton
	{
		left = contentX - 190,
		top = contentY -155,
		width = 45,
		height = 35,
		defaultFile = "Images/setting.png",
		id = "SettingButton1",
		onEvent = settingButton,
	}
---------------------------------------------------------------------------
	

---------------------------------------------------------------------sceneGroup
	sceneGroup:insert(startButton1)
	sceneGroup:insert(exitButton1)
	sceneGroup:insert(background1)
	sceneGroup:insert(settingButton1)
end
function scene:show()

	end

 function scene:hide()
	-- body
	end

  function scene:destroy()
	-- body
	end
--settingbutton:addEventListener("tap",settingButton)
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destory", scene)


return scene