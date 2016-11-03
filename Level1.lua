local composer = require("composer")
local widget = require ("widget")
local scene = composer.newScene()
	
function scene:create()
	local sceneGroup = self.view
	local Warning = 0
	local myScore = 0
	local treeAnger = 0
	----------------------------Tree: everytime the tree is taped will store energy to itself. when it is full, it will shake off all the apple .
	local function treeButton( event )
		treeAngere = treeAngere +1 
		myScore = myScore - 50

		if "ended" == phase then
			if Warning == 0 then
				Warning = Warning + 1
				--do some sort of animation to tell user not to tap the tree.
			else
				if treeAngere == 10 then -- check if to use the skill or not
					-- shake off all the apple
					treeAngere = 0
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

	-----------------------------------
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