--notes: 1:change the time
--2: tap on tap make apple disappear, add score
--3: connect to database, and keep track high score.
--4: you die when apple hits the ground
--need to put tree to the back
local composer = require("composer")
local widget = require ("widget")
local scene = composer.newScene()
local physics = require("physics")	-- add this later
physics.setGravity(0, 9.8)

function scene:create()

--All of our fancy variables n such.
	local countdown = 60 -- when timer runs out, ends the game
	local appleTable = {}
	local numOfApple = 0
	local highestScoreTable = {}
	local tick = 1000 --

	local sceneGroup = self.view
	local Warning = 0
	local myScore = 0
	local treeAnger = 0
	local appleScore = 100 
	
	
	
	--Here is where we will first blit our information onto the screen
	local function allTextToScreen()
		playerScore = display.newText("Score: "..myScore, 0, 20, nil, 20)
	end
	--We call this function to update the score for each time an apple has been "tapped".
	local function updateScore()
		playerScore.text = "Score: "..myScore
		playerScore.x = 10
		--This is where we will refresh the player's score varialble.
	end

	
	
	
	----------------------------Tree: everytime the tree is tapped will store energy to itself. when it is full, it will shake off all of the apples.
	local function treeButton( event )
		local phase = event.phase
		treeAnger = treeAnger +1 

		if "ended" == phase then
			if Warning == 0 then
				Warning = Warning + 1
				print( "Tree:i'm tapped" )
				--do some sort of animation to tell user not to tap the tree.
				
			else
				if (treeAnger == 10) then -- check if to use the skill or not
					-- shake off all the apple
					-- Michael says "Will do, sir!"
					
					
					for index = 0, numOfApple, 1 do
						if (appleTable[index] ~= nil) then
							print("This object is not nil.")
							apple = appleTable[index]
							physics.addBody(apple, {density = 10, friction = 0, bounce = 0} )
							
						else 
							print("This object is nil.")
						end
					end
					
					--We just add physics bodies to the table of objects, but this turned out to not work so hot: its detecting the values as nil values.

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
		
	
		if "began" == phase then 
		    appleTable[event.target.id] = nil         -- We remove object from table
			event.target:removeSelf()        -- Also remember to remove from display
			myScore = myScore + appleScore -- for some reason this doesn't work as excepted.
			updateScore()
			countdown = countdown + 5
			numOfApple = numOfApple - 1
			
		end
		
	end

	local function loadApple()
		
		if (numOfApple ~= 10) then
		
			numOfApple = numOfApple + 1
			local appleButton1 = widget.newButton -- we need to declare the apple in this function
			{
				left = math.random(170,440),
				top = math.random(30,200),
				width = 20,
				height = 20,
				defaultFile = "Images/apple.png",
				id = "AppleButton1",
				onEvent = appleButton,
			}
			sceneGroup:insert(appleButton1) -- add the new apple into the scene

			appleTable[numOfApple] = appleButton1 --add apple to table
			--physics.addBody(appleTable[numOfApple],{density=1,friction=0.4,bounce=1})
			appleTable[numOfApple].myName="apple"
		end
		
	end
	
	--[[local function tapApple(event)
		if (event.object1.myName == "apple") then
			event.object1:removeSelf()
			event.object1.myName = nil
		end
	end]]--
	
	
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
	
	allTextToScreen()
	startGame()
	-----------------------------------------

	----------------------------------sceneGroup
	sceneGroup:insert(treeButton1)
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