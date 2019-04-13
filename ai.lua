--[[
function findClosestNode()
	local lowest = 1000000000000
	local lowestIndex

	local temp

	for i = 1, #pathNodes do
		temp = distanceF(e.x, e.y, pathNodes[i].x, pathNodes[i].y)

		if temp < lowest then
			lowest = temp
			lowestIndex = i
		end
	end

	return lowestIndex
end
]]
