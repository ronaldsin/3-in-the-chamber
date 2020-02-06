function createPathNode(x, y)

	--create for wall corners and doorways
	local pathNode = {}

	pathNode.x = x
	pathNode.y = y
	pathNode.parent = 0

	function pathNode.draw()

		if displayNodes then
			love.graphics.circle( "fill", x, y, 10, 3)
		end

	end

	return pathNode

end


function drawPaths()

	if displayNodes then
		for i = 1, #pathNodes, 1 do
			for j = i, #pathNodes, 1 do
				if(adjMat[i][j] > 0) then
					love.graphics.line(pathNodes[i].x, pathNodes[i].y, pathNodes[j].x, pathNodes[j].y)
				end
			end
		end
	end

end

function distanceF(x1, y1, x2, y2)

	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)

end


function findClosestNode(x, y, start)--start 1 for enemy, 2 for plater

	close = start
	dis1 = distanceF(x, y, pathNodes[start].x, pathNodes[start].y)

	for i = start, #pathNodes, 1 do
		dis2 = distanceF(x, y, pathNodes[i].x, pathNodes[i].y)
		if (dis2 < dis1) then
			dis1 = dis2
			close = i
		end
	end

	return close

end


function createRoomNodes(x1, y1, x2, y2)

	for i = 1, math.floor(((x2 - x1) / density) + 0.5) + 1 do
		for j = 1, math.floor(((y2 - y1) / density) + 0.5) + 1 do
			table.insert(pathNodes, createPathNode(x1 + (i - 1) * density, y1 + (j - 1) * density))
		end
	end

end
