-- dont mind just testing forks

local ds = game:GetService("DataStoreService"):GetDataStore("Chat datastore")

return function(data)
	local success, err = pcall(function()
		for i,v in pairs(data.moderators) do
			local data = ds:GetAsync(v)
			if data == nil then
				ds:SetAsync(v, {true})
			end
		end
		if data.colors then
			if data.colors.messageInput then
				script.customChat.mainFrame.MessageBox.Text.TextColor3 = data.colors.messageInput.text
			end
		end
		--script.chatServer.setSettings:FireServer("message_deletion",data.message_deletion)
		script.chat.Parent = game.ReplicatedStorage
		script.customChat.Parent = game.StarterGui
		script.chatServer.Parent = game.ServerScriptService
		task.wait()
		script:Destroy()
	end)
	if not success then
		warn("Failure while loading the chat; error: "..err)
	end
end
