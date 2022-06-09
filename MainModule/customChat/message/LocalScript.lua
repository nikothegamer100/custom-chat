script.Parent.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.chat.deleteMsg:FireServer(script.Parent.messageId.Value)
	--[[for i,v in pairs(script.Parent.Parent:GetChildren()) do
		if v:IsA("GuiObject") then
			v.Frame.Visible = false
		end
	end
	script.Parent.Frame.Visible = true]]
end)