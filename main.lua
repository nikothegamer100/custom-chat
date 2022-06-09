local UIS = game:GetService("UserInputService")
local Focused = false
wait(0.3)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
local userColor = require(script.Algorithm)
local utility = require(script.Parent.utility)
local commands = {
	["clear"] = {
		Func = function()
			for i,v in pairs(script.Parent.Main:GetChildren()) do
				if v:IsA("GuiObject") then
					v:Destroy()
				end
			end
		end,
	}
}






local function sendMsg(plr, msg, id,tags, System)
	if System and System == true then
		local clone = script.Parent.Parent.message:Clone()
		clone.Parent = script.Parent.Main
		clone.messageId.Value = id
		clone.user.Value = "System"
		clone.Text = " [SYSTEM]: "..msg
		clone.Visible = true
	else
		local color = userColor(plr.Name)
		local clone = script.Parent.Parent.message:Clone()
		clone.Parent = script.Parent.Main
		clone.messageId.Value = id
		clone.user.Value = plr.Name
		local colors = string.split(tostring(color), ",")
		clone.Text = tags.." <font color='rgb("..utility.getChatColor(plr.Name)..")'>["..plr.Name.."]: </font> "..msg
		clone.Visible = true
	end
	script.Parent.Main.CanvasPosition += Vector2.new(0,30)
end
local Shift = false
local slash = false
UIS.InputBegan:Connect(function(input)
	if Focused == true and input.KeyCode == Enum.KeyCode.Return then
		if string.len(script.Parent.MessageBox.Text.Text) >= 250 then
			sendMsg("", "Your message is too long; < 250", true)
			
		end
		local args = string.split(script.Parent.MessageBox.Text.Text, " ")
		local command = string.sub(args[1], 2, string.len(args[1]))
		if string.sub(args[1],1,1) == "/" then
		local success, err = pcall(function()
			commands[command].Func()
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
	sendMsg(plr,msg, id,tags)
end)

game.ReplicatedStorage.chat.deleteMsg.OnClientEvent:Connect(function(plr,id)
	for i,v in pairs(script.Parent.Main:GetChildren()) do
		if v:IsA("GuiObject") and v.messageId.Value == id and v.user.Value == plr.Name then
			v:Destroy()
		end
	end
end)
