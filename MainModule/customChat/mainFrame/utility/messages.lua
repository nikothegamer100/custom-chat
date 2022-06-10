local msgs = {}
local create = require(script.Parent.createMessage)

function msgs:send(data)
	create(data.user, {
		tags = require(script.Parent.tags)(data.user);
		content = data.message
	})
	script.Parent.Parent.Main.CanvasPosition += Vector2.new(0,30,0)
	--[[local clone = script.Parent.Parent.Parent.message:Clone()
	clone.Text = data.tags.." ["..data.user.."]: "..data.message
	clone.Parent = script.Parent.Parent.Main
	clone.Visible = false]]
end

function msgs:delete(data)
	for i,v in pairs(script.Parent.Parent.Main:GetChildren()) do
		if v:IsA("GuiObject") and v.messageId.Value == data.messageId and v.user.Value == data.user then
			v:Destroy()
		end
	end
end

return msgs
