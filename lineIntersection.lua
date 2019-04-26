function min(table)
	x = table[1]
	for i, v in pairs(table) do
		if v < x then
			x = v
		end
	end
	return x
end

function max(table)
	x = table[1]
	for i, v in pairs(table) do
		if v > x then
			x = v
		end
	end
	return x
end

function lineIntersection(x1, x2, x3, x4, y1, y2, y3, y4)
	local x12 = x1 - x2;
	local x34 = x3 - x4;
	local y12 = y1 - y2;
	local y34 = y3 - y4;

	c = x12 * y34 - y12 * x34;

	if math.abs(c) < 0.01 then
		-- No intersection
		return false
	else
		-- Intersection
		xtable = {x1, x2, x3, x4}
		ytable = {y1, y2, y3, y4}

		local a = x1 * y2 - y1 * x2;
		local b = x3 * y4 - y3 * x4;

		local x = (a * x34 - b * x12) / c;
		local y = (a * y34 - b * y12) / c;
		return not ((min(xtable) > x) or (min(ytable) > y) or (max(xtable) < x) or (max(ytable) < y))
	end
end
-- A = {12, 42}
-- B = {167, 2}
-- C = {127, 1}
-- D = {15, 55}
-- love.graphics.line(A[1], A[2], B[1], B[2])
-- love.graphics.line(C[1], C[2], D[1], D[2])
-- if test(A[1], B[1], C[1], D[1], A[2], B[2], C[2], D[2]) then
--   print("intersect")
-- else
--   print("nope")
-- end
