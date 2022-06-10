local BC = BrickColor.new

local ChatColors = {
	BC("Bright red").Color,
    BC("Bright blue").Color,
  	BC("Earth green").Color,
  	BC("Bright violet").Color,
  	BC("Bright orange").Color,
  	BC("Bright yellow").Color,
  	BC("Light reddish violet").Color,
  	BC("Brick yellow").Color,
}

function getChatColorsIndex(username)
	local usernameLength = #username
	local totalValue = 0
	
	for i = 1, usernameLength do 
		local letter = string.sub(username, i, i)
		local letterValue = string.byte(letter)
		local iReversed = usernameLength - i + 1 
		if usernameLength % 2 == 1 then 
			iReversed = iReversed - 1			
		end
		if iReversed % 4 >= 2 then
			letterValue = -letterValue 			
		end 
		totalValue += letterValue 
	end 
	
	local index = (totalValue % #ChatColors) + 1
	return index
end 



local module = function(username)
	local index = getChatColorsIndex(username)
	local color = ChatColors[index]
	return color
end

return module
