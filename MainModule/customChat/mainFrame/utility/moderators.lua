local ds = game:GetService("DataStoreService"):GetDataStore("Chat datastore")


script.RemoteFunction.OnServerInvoke = function(plr)
	local toReturn = false
	local data = ds:GetAsync(plr.UserId)
	if data[1] == true then
		toReturn = true
	else
		toReturn = false
	end
	return toReturn
end
