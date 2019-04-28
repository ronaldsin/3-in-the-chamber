function createQueue()

	local queue = {}

	function queue.push(item)

		table.insert(queue, item)

	end

	function queue.pop()

		local item = queue[1]

		table.remove(queue, 1)

		return item

	end

	return queue

end
