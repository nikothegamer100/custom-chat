return function(data)
	local success, err = pcall(function()
		for i,v in pairs(data.moderators) do
			script.chatServer.setMod:Fire(v)
		end
		script.chatServer.setSettings:Fire("message_deletion",data.message_deletion)
		script.chat.Parent = game.ReplicatedStorage
		script.customChat.Parent = game.StarterGui
		script.chatServer.Parent = game.ServerScriptService
		wait()
		script:Destroy()
	end)
	if not success then
		warn("Failure while loading the chat.")
		warn(err)
	end
end