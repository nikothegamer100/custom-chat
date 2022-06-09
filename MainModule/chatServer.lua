local events = game.ReplicatedStorage:WaitForChild("chat")
local mods = {}
local TextService = game:GetService("TextService")
local Settings = {
	["message_deletion"] = false
}
events.sendMsg.OnServerEvent:Connect(function(plr, msg)
	local tags = ""
	
	if table.find(mods, plr.Name) then
		tags = tags.."<font color='rgb(255,165,0)'>[MOD]</font>"
	end
	
	local filtered = TextService:FilterStringAsync(msg, plr.UserId)
	filtered = filtered:GetNonChatStringForBroadcastAsync()
	events.sendMsg:FireAllClients(plr, filtered,tags, game.HttpService:GenerateGUID())
end)

events.deleteMsg.OnServerEvent:Connect(function(plr, msgId)
	if Settings.message_deletion == false then return end
	events.deleteMsg:FireAllClients(plr,msgId)
end)

script.setMod.Event:Connect(function(plr)
	table.insert(mods, plr)
end)

script.setSettings.Event:Connect(function(setting, value)
	Settings[setting] = value
end)