
function ai(monster, dt)

	if p.los and not checkWallCollision(monster.hitbox)then
		monster.goToNode(1, dt)

	elseif monster.lost == true then
		local start = findClosestNode(monster.x, monster.y, 1)
		currents = start
		stack = createStack()

		local temp = pathFind(start, 1)

		while true do
			stack.push(temp)
			temp = pathNodes[temp].parent

			if temp == 0 then
				monster.lost = false
				break
			end
		end

		-- for i = #stack, 1, - 1 do
		-- 	print(stack[i])
		-- end
	else
		if not monster.goToNode(currents, dt) then

			if not (currents == 1) then
				currents = stack.pop()
			end
			--print("current: " .. current)
		end
	end

end


function pathFind(first, goal)

	local current = first
	local visited = {first}
	local queue = createQueue()

	pathNodes[current].parent = 0

	queue.push(current)

	while true do
		current = queue.pop()

		if current == goal then
			return current
		end
		--print("pop: " .. current)
		for i = 1, #pathNodes do
			-- print("c: " .. current)
			-- print("i: " .. i)
			-- print(adjMat[current][i])
			if adjMat[current][i] > 0 then

				if i == goal then
					pathNodes[i].parent = current
					return i
				end

				for j = 1, #visited do
					if visited[j] == i then
						goto fail
					end
				end

				table.insert(visited, i)
				pathNodes[i].parent = current
				-- print("push" .. i)
				queue.push(i)
			end
			::fail::
		end
	end

end
