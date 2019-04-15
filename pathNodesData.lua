pathNodes = {}

table.insert(pathNodes, createPathNode(0, 0)) -- player node

adjMat = {{}}
--wall corners

density = 100



for i = 1, math.floor(((2323 - 1168) / density) + 0.5) + 1 do
	for j = 1, math.floor(((2021 - 936) / density) + 0.5) + 1 do
		table.insert(pathNodes, createPathNode(1168 + (i - 1) * density, 936 + (j - 1) * density))
	end
end

for i = 1, #pathNodes do
	adjMat[1][i] = 0
end

for i = 2, #pathNodes do
	adjMat[i] = {}
	for j = 1, #pathNodes do
		if i == j then
			adjMat[i][j] = 0
		elseif distanceF(pathNodes[i].x, pathNodes[i].y, pathNodes[j].x, pathNodes[j].y ) <= density then
			adjMat[i][j] = 1
		else
			adjMat[i][j] = 0
		end
	end
end
--[[

table.insert(pathNodes, createPathNode(1156 + 50, 1254 - 50))

--connecting corridors
table.insert(pathNodes, createPathNode(2326 - 50, (1611 + 1760) / 2)) -- left side
table.insert(pathNodes, createPathNode(2418 + 50, (1611 + 1760) / 2)) -- right side

table.insert(pathNodes, createPathNode(3291 - 50, (1760 + 1920) / 2)) -- left side
table.insert(pathNodes, createPathNode(3377 + 50, (1760 + 1920) / 2)) -- right side

table.insert(pathNodes, createPathNode(3290 - 50, (2350 + 2500) / 2)) -- left side
table.insert(pathNodes, createPathNode(3372 + 50, (2350 + 2500) / 2)) -- right side


--undirected graph
adjMat =
{ {0, 0, 0, 0, 0, 0, 0, 0}, -- player node
	{0, 0, 1, 0, 0, 0, 0, 0},
	{0, 1, 0, 1, 0, 0, 0, 0},
	{0, 0, 1, 0, 1, 0, 1, 0},
	{0, 0, 0, 1, 0, 1, 1, 0},
	{0, 0, 0, 0, 1, 0, 0, 0},
	{0, 0, 0, 1, 1, 0, 0, 1},
{ 0, 0, 0, 0, 0, 0, 1, 0}}


--[[
corners of doorways
table.insert(pathNodes,createPathNode(2326, 1611))
table.insert(pathNodes,createPathNode(2418, 1760))

table.insert(pathNodes,createPathNode(3291,1760))
table.insert(pathNodes,createPathNode(3377,1920))

table.insert(pathNodes,createPathNode(3290, 2350))
table.insert(pathNodes,createPathNode(3372, 2500))
]]
