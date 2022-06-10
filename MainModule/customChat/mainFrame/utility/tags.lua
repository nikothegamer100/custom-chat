return function (user)
	local tags = ""
	local isMod = script.Parent.moderators.RemoteFunction:InvokeServer()
	if isMod then
		tags = tags.."<font color='rgb(213, 115, 61)'>[MOD]</font>"
	end
	return tags
end
