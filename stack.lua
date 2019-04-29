function createStack()
	local stack = {}

	function stack.push(item)
		table.insert(stack, item)
	end

	function stack.pop()
		local item = stack[#stack]

		table.remove(stack, #stack)

		return item
	end

	return stack
end
