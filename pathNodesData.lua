pathNodes = {}

table.insert(pathNodes, createPathNode(0, 0)) -- player node


--wall corners

function loadNodes()

	-- createRoomNodes(837, 964, 1172, 1200)
	-- createRoomNodes(1192, 964, 2280, 1980)
	-- createRoomNodes(2300, 1650, 2435, 1715)
	-- createRoomNodes(2455, 1475, 3270, 2740)
	-- createRoomNodes(3288, 1795, 3365, 1870)
	-- createRoomNodes(3410, 1670, 4218, 2024)
	-- createRoomNodes(3288, 2415, 3365, 2450)
	-- createRoomNodes(3398, 2210, 4214, 2725)
	--createRoomNodes(0, 0, 5000, 5000)
	table.insert(pathNodes, createPathNode(663, 931.89))
	table.insert(pathNodes, createPathNode(979, 885.47))
	table.insert(pathNodes, createPathNode(2692.09, 891.47))
	table.insert(pathNodes, createPathNode(3580.10, 889.47))
	table.insert(pathNodes, createPathNode(4024.09, 1241.71))
	table.insert(pathNodes, createPathNode(4024.09, 1241.71))
	table.insert(pathNodes, createPathNode(4192.60, 1851.48))
	table.insert(pathNodes, createPathNode(4202.60, 2251.49))
	table.insert(pathNodes, createPathNode(4204.60, 2911.60))
	table.insert(pathNodes, createPathNode(4206.60, 3282.72))
	table.insert(pathNodes, createPathNode(4519.54, 3794.95))
	table.insert(pathNodes, createPathNode(4517.54, 4149.17))
	table.insert(pathNodes, createPathNode(3362.86, 3672.27))
	table.insert(pathNodes, createPathNode(3333.57, 4455.03))
	table.insert(pathNodes, createPathNode(3693.54, 4459.03))
	table.insert(pathNodes, createPathNode(3006.83, 3722.09))
	table.insert(pathNodes, createPathNode(3004.83, 4383.49))
	table.insert(pathNodes, createPathNode(2706.85, 4374.97))
	table.insert(pathNodes, createPathNode(1963.50, 4504.89))
	table.insert(pathNodes, createPathNode(1617.44, 4508.89))
	table.insert(pathNodes, createPathNode( 1675.98, 3270.75))
	table.insert(pathNodes, createPathNode(2670.02, 2341.57))
	table.insert(pathNodes, createPathNode(3010.08, 2341.57))

end


function connectNodes()

	-- for i = 1, #pathNodes do
	-- 	adjMat[1][i] = 0
	-- end
	--
	-- for i = 2, #pathNodes do
	-- 	adjMat[i] = {}
	-- 	for j = 1, #pathNodes do
	-- 		if i == j then
	-- 			adjMat[i][j] = 0
	--
	-- 		elseif distanceF(pathNodes[i].x, pathNodes[i].y, pathNodes[j].x, pathNodes[j].y ) <= math.sqrt(2 * (math.pow(density, 2))) then
	-- 			adjMat[i][j] = 1
	--
	-- 		else
	-- 			adjMat[i][j] = 0
	-- 		end
	--
	-- 	end
end

adjMat = 
{ {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, -- player node
	{0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0 }, --14
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 }, --17
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0 },
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1 },
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 }}

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
