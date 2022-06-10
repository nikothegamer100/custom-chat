local UIS = game:GetService("UserInputService")
local Focused = false
local mods = {}
wait(0.3)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
local userColor = require(script.Parent.utility.Algorithm)
local utility = require(script.Parent.utility)
local Icon = require(script.Parent.utility.Icon)

local icon = Icon.new()
:setImage(9237764773)
:setLabel("Chat")
:setCaption("Opens chat")
:setTip("Open Chat")
:bindToggleItem(script.toggle)
icon.toggled:Connect(function(isSelected)
	--print(icon:getToggleState(isSelected))
	if icon:getToggleState(isSelected) == "deselected" then
		game.TweenService:Create(script.Parent, TweenInfo.new(0.5), {Position = UDim2.new(-0.3,0,0.012,0)}):Play()
	
	elseif icon:getToggleState(isSelected) == "selected" then
		game.TweenService:Create(script.Parent, TweenInfo.new(0.5), {Position = UDim2.new(0,0,0.012,0)}):Play()
	
	end
end)


local Shift = false
local slash = false
UIS.InputBegan:Connect(function(input)
	if Focused == true and input.KeyCode == Enum.KeyCode.Return then
		if string.len(script.Parent.MessageBox.Text.Text) >= 250 then
			require(script.Parent.utility.messages):send({message = "your message is too long", user = "System"})
			
		end
		local args = string.split(script.Parent.MessageBox.Text.Text, " ")
		local command = string.sub(args[1], 2, string.len(args[1]))
		if string.sub(args[1],1,1) == "/" then
		local success, err = pcall(function()
			utility.command(command)
			end)
			if err then
				game.ReplicatedStorage.chat.sendMsg:FireServer(script.Parent.MessageBox.Text.Text, game.HttpService:GenerateGUID())
				script.Parent.MessageBox.Text.Text = ""
			end
		else
			game.ReplicatedStorage.chat.sendMsg:FireServer(script.Parent.MessageBox.Text.Text, game.HttpService:GenerateGUID())
			script.Parent.MessageBox.Text.Text = ""
		end
	elseif input.KeyCode == Enum.KeyCode.RightShift then
		script.Parent.MessageBox.Text:CaptureFocus()
	elseif input.KeyCode == Enum.KeyCode.Slash then
		task.wait()
		script.Parent.MessageBox.Text:CaptureFocus()
	end
end)

UIS.TextBoxFocused:Connect(function(textbox)
	if textbox == script.Parent.MessageBox.Text then
		wait()
		Focused = true
	end
end)

UIS.TextBoxFocusReleased:Connect(function(textbox)
	if textbox == script.Parent.MessageBox.Text then
		wait()
		Focused = false
	end
end)


game.ReplicatedStorage.chat.sendMsg.OnClientEvent:Connect(function(plr, msg,tags, id)
	
	require(script.Parent.utility.messages):send({message = msg, user = plr})
end)

game.ReplicatedStorage.chat.deleteMsg.OnClientEvent:Connect(function(plr,id)
	require(script.Parent.utility.messages):delete({user = plr, messageId = id})
end)

script.setMod.OnClientEvent:Connect(function(plr)
	table.insert(mods, plr)
end)
