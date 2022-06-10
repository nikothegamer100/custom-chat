return function(user, data)
		local clone = script.Parent.Parent.Parent.message:Clone()
	clone.Text = data.tags.." <font color='rgb("..require(script.Parent).getChatColor(user.Name)..")'>["..user.Name.."]: </font>  "..data.content
		clone.Parent = script.Parent.Parent.Main
		clone.Visible = true
end
