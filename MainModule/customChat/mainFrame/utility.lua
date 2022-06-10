local utility = {}

utility.getChatColor = function(name)
	local colors = string.split(tostring(require(script.Algorithm)(name), ","))
	return tostring(math.floor(colors[1] * 255))..","..tostring(math.floor(colors[2] * 255))..","..tostring(math.floor(colors[3] * 255))
end

utility.command = function(command)
	require(script.commands).run(command)
end



utility.sendMsg = function(data)
	require(script.messages):send(data)
end
return utility
