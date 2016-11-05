local composer = require( "composer" )

local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0,4.8)


function scene:create()
	contentX = display.contentCenterX
	contentY = display.contentCenterY

	local flyOverBird = display.newImageRect("Images/bird.png",50,50)
	flyOverBird.x = -30
	flyOverBird.y = contentY

	physics.addBody(flyOverBird, "dynamic",{density=1,friction=0.4,bounce=1})
	flyOverBird.gravityScale = 0 --change this object's gravity to 0 so it can flow. 
	transition.to(flyOverBird,{x = 300, time = 3000})

	local fallingApple = display.newImageRect("Images/apple.png",50,50)
	fallingApple.x = 175
	fallingApple.y = -100
	physics.addBody(fallingApple, "dynamic",{density=1,friction=0.4,bounce=1})

	local ground = display.newRect(contentX, 768,  768, 10)
	ground:setFillColor(1,1,1,1)
	
----------------------------------------------
-- go to scene home page. 
	local function gotoMenu(event)
		flyOverBird:removeSelf()
		fallingApple:removeSelf()
		local composer = require("composer")
		local temp = require("Menu")
		composer.gotoScene("Menu")
	end	

	timer.performWithDelay(4500,gotoMenu)
----------------------------------------------
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