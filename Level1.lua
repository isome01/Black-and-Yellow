local composer = require("composer")
local widget = require ("widget")
local scene = composer.newScene()	

--------------------------------------------- change on the apple (initialize)


---------------------------------------------end

--[[Here is where we should load our variables
~Note: the problem with the removeSelf() function in the appleButton(event) is that when you run the function,
 it runs over and over again (Because CoronaSDK/Lua...) When it runs over and over again, the function expects
 the declaration of the apple (but, as I stated, the problem is that it's being removed) which essential causes
 the runtime error.
]]
--Button functions and such.

---------------------------------------------end

function scene:create()

	local timer = 60 -- when timer runs out, ends the game
	local appleTable = {}
	local numOfApple = 0
	local highestScoreTable = {}
	local tick = 1000 -- time between game loop in mm

	local sceneGroup = self.view
	local Warning = 0
	local myScore = 0
	local treeAnger = 0
	local appleScore = 100 
	----------------------------Tree: everytime the tree is tapped will store energy to itself. when it is full, it will shake off all of the apples.
	local function treeButton( event )
		local phase = event.phase
		treeAnger = treeAnger +1 
		myScore = myScore - 50

		if "ended" == phase then
			if Warning == 0 then
				Warning = Warning + 1
				print( "i'm tapped" )
				--do some sort of animation to tell user not to tap the tree.
			else
				if treeAnger == 10 then -- check if to use the skill or not
					-- shake off all the apple
					treeAnger = 0
				end
			end
		end
	end

	local treeButton1 = widget.newButton
	{
		left = contentX -80,
		top = contentY - 150,
		width = 320,
		height = 320,
		defaultFile = "Images/tree.png",
		id = "Background1",
		onEvent = treeButton,
	}

	----------------------------------- end

	---------------------------------------- apple 
	local function appleButton( event )
		local phase = event.phase
		myScore = myScore + appleScore
		timer = timer + 5
	
		if "began" == phase then 
			--appleButton1.removeSelf()
			print("I'm tapped")
		end
		
		if "ended" == phase then
			print("tap the next apple")
		end
		
	end
	
	--[[
	local appleButton1 = widget.newButton
	{
		left = math.random(170,440),
		top = math.random(30,200),
		width = 20,
		height = 20,
		defaultFile = "Images/apple.png",
		id = "AppleButton1",
		onEvent = appleButton,
	}
	
	local function loadApple()
		for i = 0, 3, 1 do
			numOfApple = numOfApple + 1
			appleTable[numOfApple] = appleButton1 --add apple to table
			physics.addBody(appleTable[numOfApple],{density=1,friction=0.4,bounce=1})
			appleTable[numOfApple].myName="apple"
		end
	end]]--
	
	local function loadApple()
		numOfApple = numOfApple + 1
		appleTable[numOfApple] = display.newImageRect("Images/apple.png", 20, 20)--add apple to table
		physics.addBody(appleTable[numOfApple],{density=1,friction=0.4,bounce=1})
		appleTable[numOfApple].myName="apple"
		appleTable[numOfApple].x = math.random(170, 440)
		appleTable[numOfApple].y = math.random(30, 200)
	end
	
	local function tapApple(event)
		if (event.object1.myName == "apple") then
			event.object1:removeSelf()
			event.object1.myName = nil
		end
	end
	
	local function gameLoop()
		loadApple()--load a new apple
		-- if score > 2000 and tick > 800 then
		-- 	tick = 800
		-- elseif score > 5000 and tick > 700 then
		-- 	tick = 700
		-- elseif score> 10000 and tick > 600 then
		-- 	tick = 600
		-- elseif score > 15000 and tick > 500 then
		-- 	tick = 500
		-- elseif score > 20000 and tick > 450 then 
		-- 	tick = 450
		-- elseif score > 25000 and tick > 400 then
		--  tick = 400
		-- end
	end

	function startGame()
		--appleTable:addEventListener("tap", tapApple)
    	--Runtime:addEventListener("collision", onCollision)
    	timer.performWithDelay(tick, gameLoop, 0)-- a new apple should appear every second
	end

	-----------------------------------------

	----------------------------------sceneGroup
	sceneGroup:insert(treeButton1)
	--sceneGroup:insert(appleButton1)
end

function scene:show()
--This here is the unsolved problem:	
	startGame()
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
print("reached")

return scene