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
	local appleTable = {}
	local removedApples = {} -- very immature and half baked, but we can work with a table to store all of our removed apples
	local numOfApple = 0
	local highestScoreTable = {}
	local tick = 1000 --
	local losetime = 0
	local sceneGroup = self.view
	local Warning = 0
	local myScore = 0
	local myTime = 60
	local treeAnger = 0
	local appleScore = 100 
	local appleNumber = 1

	
	
	--Here is where we will first blit our information onto the screen
	local function allTextToScreen()
		playerScore = display.newText("Score: "..myScore, 0, 20, nil, 20)
		playerTimer = display.newText("Time: "..myTime, 0, 40, nil, 20)
	end
	--We call this function to update the score for each time an apple has been "tapped".
	local function updateScore()
		playerScore.text = "Score: "..myScore
		playerScore.x = 10
		--This is where we will refresh the player's score varialble.
	end

	local updateTimer = {}
	function updateTimer:timer ( event )
		myTime = myTime - 1
		if (myTime <= 0) then
			print("quit the game")
			 timer.cancel(event.source)
			composer.gotoScene("Menu")
		else 
			playerTimer.text = "Time: "..myTime
			playerTimer.x = 0
		end
	end
	----------------------------Tree: everytime the tree is tapped will store energy to itself. when it is full, it will shake off all of the apples.
	local function errorMessage( event ) -- for error message
	    if ( event.action == "clicked" ) then
	        local i = event.index
	        	if ( i == 1 ) then
				-- dismiss the button
				end
		end
	end
	
	local function treeButton()
		treeAnger = treeAnger + 1 
		--print("Tree is tapped.", treeAnger)
		
		if (Warning == 0) then
			Warning = Warning + 1
			local alert = native.showAlert( "Warning.","This tree is ticklish...",{"Resume"}, errorMessage ) -- fix this alart later
			--print( "Tree: Don't tap me" )
			--do some sort of animation to tell user not to tap the tree.
			
		else
			if (treeAnger >= 1) then -- check if to use the skill or not
				-- shake off all the apple
				-- Michael says "Will do, sir!"
				myTime = myTime - losetime - numOfApple*5
				--print("numOfApple: ", numOfApple) -- checked
				for index = 0, numOfApple, 1 do
					if (appleTable[index]~= nil) then
						--print(appleTable[index].id) 
						
						apple = appleTable[index]
						physics.addBody(apple, {density = 100, friction = 0, bounce = 0} )
						
					else 
						--print("This object is nil.")

					end
				end
				
				--We just add physics bodies to the table of objects, but this turned out to not work so hot: its detecting the values as nil values.
				--numOfApple = 0
				treeAnger = 0
				numOfApple = 0
				appleNumber = 1
				
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
	}
	treeButton1:addEventListener("tap", treeButton)

	----------------------------------- end

	---------------------------------------- apple 
	local function appleButton( event )
		local phase = event.phase
		if "began" == phase then 
			-- this if statement is only added because we are tapping the tree through the apple, so we
			--have to reset treeAnger
			numOfApple = numOfApple - 1
			treeAnger = treeAnger - 1
			--print("Apple number", event.target.id)
			event.target:removeSelf()        -- Also remember to remove from display
		    appleTable[event.target.id] = nil         -- We remove object from table
			myScore = myScore + appleScore -- for some reason this doesn't work as excepted.

			updateScore()
			myTime = myTime + 2
			--numOfApple = numOfApple - 1
		end
	end

	local function loadApple()
		
		--if (numOfApple <= 5) then
			numOfApple = numOfApple + 1
			local appleButton1 = widget.newButton -- we need to declare the apple in this function
			{
				left = math.random(170,440),
				top = math.random(30,200),
				width = 20,
				height = 20,
				defaultFile = "Images/apple.png",
				id = appleNumber,
				onEvent = appleButton,
			}
			
			--Fix--sceneGroup:insert(appleButton1.id) -- how to insert this appletable into scene?

			appleTable[numOfApple] = appleButton1 --add apple to table
			--physics.addBody(appleTable[numOfApple],{density=1,friction=0.4,bounce=1})
			appleTable[numOfApple].myName = "apple"
			
			appleNumber = appleNumber + 1
		--end
		
	end
	
	--[[local function tapApple(event)
		if (event.object1.myName == "apple") then
			event.object1:removeSelf()
			event.object1.myName = nil
		end
	end]]--
----------------------------------------------------------------

---------------------------------------------------------------pause button
local pause = false

local pauseButton1 = widget.newButton
{
	left = display.contentCenterX -100,
	top = 10,
	width = 40,
	height = 40,
	defaultFile = "images/pause.png",
	id = pauseButton,
	onEvent = pause,
} 

local function pause (event)
	local phase = event.phase
	if "began" == phase then 

	end
end

-------------------------------------------------------------	
	local gameLoop = {}
	function gameLoop:timer ( event )
		if (myTime <= 0) then
			 timer.cancel(event.source)
			 for index = 0, numOfApple, 1 do
				if (appleTable[index]~= nil) then
					--print(appleTable[index].id) 
					apple = appleTable[index]
					physics.addBody(apple, {density = 100, friction = 0, bounce = 0} )	
				else 
					--print("This object is nil.")
				end
			end

		else 
			 if myScore > 500 and tick > 800 then
			 	losetime = 1
			 	tick = 800
			 elseif myScore > 1000 and tick > 700 then
			 	losetime = 2
			 	tick = 700
			 elseif myScore> 2000 and tick > 600 then
			 	losetime = 5
			 	tick = 600
			 elseif myScore > 3500 and tick > 500 then
			 	losetime = 7
			 	tick = 500
			 elseif myScore > 5500 and tick > 450 then 
			 	losetime = 10
			 	tick = 450
			 elseif myScore > 7000 and tick > 400 then
			  	losetime = 12
			  	tick = 400
			 elseif myScore > 10000 and tick > 350 then
			 	losetime = 15
			 	tick = 350
			 elseif myScore > 13500 and tick > 300 then 
			 	losetime = 18
			 	tick = 300
			 elseif myScore > 20000 and tick > 150 then
			  	losetime = 35
			  	tick = 150
			end
			loadApple()--load a new apple
		end
	end
	
	
	function startGame()
		--appleTable:addEventListener("tap", tapApple)
    	--Runtime:addEventListener("collision", onCollision)
    	timer.performWithDelay(tick, gameLoop, 0)-- a new apple should appear every second
    	timer.performWithDelay(1000, updateTimer, 0)
	end
	
	allTextToScreen()
	startGame()
	-----------------------------------------

	----------------------------------sceneGroup
	sceneGroup:insert(treeButton1)
	sceneGroup:insert(playerTimer)
	sceneGroup:insert(playerScore)
	sceneGroup:insert(pauseButton1)
end

function scene:show()	
	

end

function scene:hide()
	-- body
end

 function scene:destory()

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destory", scene)

return scene