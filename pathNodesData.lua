pathNodes = {}

--wall corners
table.insert(pathNodes,createPathNode(0, 0)) -- player node
table.insert(pathNodes,createPathNode(1156 + 50, 1254 - 50))

--connecting corridors
table.insert(pathNodes,createPathNode(2326 - 50, (1611+1760)/2)) -- left side
table.insert(pathNodes,createPathNode(2418 + 50, (1611+1760)/2)) -- right side

table.insert(pathNodes,createPathNode(3291 - 50, (1760+1920)/2)) -- left side
table.insert(pathNodes,createPathNode(3377 + 50, (1760+1920)/2)) -- right side

table.insert(pathNodes,createPathNode(3290 - 50, (2350+2500)/2)) -- left side
table.insert(pathNodes,createPathNode(3372 + 50, (2350+2500)/2)) -- right side


--undirected graph
adjMat ={{0,0,0,0,0,0,0,0},
{0,0,1,0,0,0,0,0},
{0,1,0,1,0,0,0,0},
{0,0,1,0,1,0,1,0},
{0,0,0,1,0,1,1,0},
{0,0,0,0,1,0,0,0},
{0,0,0,1,1,0,0,1},
{0,0,0,0,0,0,1,0}}


--[[
corners of doorways
table.insert(pathNodes,createPathNode(2326, 1611))
table.insert(pathNodes,createPathNode(2418, 1760))

table.insert(pathNodes,createPathNode(3291,1760))
table.insert(pathNodes,createPathNode(3377,1920))

table.insert(pathNodes,createPathNode(3290, 2350))
table.insert(pathNodes,createPathNode(3372, 2500))
]]
