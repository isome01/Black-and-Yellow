--problems for this scene: sound on and off only apply to this scene. once leave the page, music turn back on automatically.


local composer = require( "composer" )
local widget = require ("widget")
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0,4.8)

function scene:create()

	local sceneGroup = self.view
	contentX = display.contentCenterX
	contentY = display.contentCenterY


------------------------testing scene
local text = display.newText("Volumn On: ", 70, contentY - 100, nil, 20)
	text:setFillColor(1,0,0)
	
local text2 = display.newText("Volumn Off: ", 72, contentY - 70, nil, 20)
	text2:setFillColor(1,0,0)

---------------------------------------------------------------------------VolumnOn Wudget
	local function volumnOn( event )
		local phase = event.phase
			if testVon == "T" then
				if "ended" == phase then
					audio.play( randomsongMusicChannel )-- ask what channel should I use and how to prevent it from play twice
					_G.musicnum = 0
					testVon = "F"
					testVoff = "T"
				else 
					return 0
				end
			end
	end

	local volumnOn1 = widget.newButton
	{
		left = 130,
		top = contentY -115,
		width = 35,
		height = 27,
		defaultFile = "Images/SoundOn.png",
		id = "VolumnOn1",
		onEvent = volumnOn,
	}
---------------------------------------------------------------------------

---------------------------------------------------------------------------VolumnOff Wudget

	local function volumnOff( event )
		local phase = event.phase
			if testVoff == "T" then
				if "ended" == phase then
					audio.stop(1)
					_G.musicnum = 1
					testVoff = "F"
					testVon = "T"
				else
					return 0
				end
			end
	end

	local volumnOff1 = widget.newButton
	{
		left = 135,
		top = contentY -85,
		width = 35,
		height = 27,
		defaultFile = "Images/SoundOff.png",
		id = "VolumnOff1",
		onEvent = volumnOff,
	}
---------------------------------------------------------------------------

--------------------------------------------------------------------------return widget
local function returnButton ( event )
			local phase = event.phase

			if "ended" == phase then
				composer.gotoScene("Menu")
			end
		end


		--create button
		local returnButton1 = widget.newButton
		{
			left = 0,
			top = contentY +140,
			width = 50,
			height = 20,
			defaultFile = "Images/White_rec.png",
			overFile = "Images/Black_rec.png",
			id = "returnButton1",
			label = "Return",
			labelColor = { default={ 0.1, 0.8, 0.9 }, over={ 1, 1, 1, 0.5 } },
			fontSize = 15,
			onEvent = returnButton,
			--mealGroup:insert(returnButton1.view)
		}
-----------------------------------------------------------------------
	sceneGroup:insert(text)
	sceneGroup:insert(text2)
	sceneGroup:insert(volumnOn1)
	sceneGroup:insert(volumnOff1)
	sceneGroup:insert(returnButton1)
end
function scene:show()

	end

 function scene:hide()
	-- body
	end

  function scene:destory()
	-- body
	end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destory", scene)

return scene