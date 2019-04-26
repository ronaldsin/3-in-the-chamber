function min(table)
	if table[1] > table[2] then
		return table[2]
	else
		return table[1]
	end
end

function max(table)
	if table[1] < table[2] then
		return table[2]
	else
		return table[1]
	end
end
--
-- function lineIntersection(x1, x2, x3, x4, y1, y2, y3, y4)
-- 	local x12 = x1 - x2;
-- 	local x34 = x3 - x4;
-- 	local y12 = y1 - y2;
-- 	local y34 = y3 - y4;
--
-- 	c = x12 * y34 - y12 * x34;
--
-- 	if math.abs(c) < 0.01 then
-- 		-- No intersection
-- 		return false
-- 	else
-- 		-- Intersection
-- 		xtable = {x1, x2}
-- 		ytable = {y1, y2}
--
-- 		local a = x1 * y2 - y1 * x2;
-- 		local b = x3 * y4 - y3 * x4;
--
-- 		local x = (a * x34 - b * x12) / c;
-- 		local y = (a * y34 - b * y12) / c;
--
-- 		return not ((min(xtable) > x) or (min(ytable) > y) or (max(xtable) < x) or (max(ytable) < y))
-- 	end
-- end
-- -- A = {12, 42}
-- -- B = {167, 2}
-- -- C = {127, 1}
-- -- D = {15, 55}
-- -- love.graphics.line(A[1], A[2], B[1], B[2])
-- -- love.graphics.line(C[1], C[2], D[1], D[2])
-- -- if test(A[1], B[1], C[1], D[1], A[2], B[2], C[2], D[2]) then
-- --   print("intersect")
-- -- else
-- --   print("nope")
-- -- end

function lineIntersection(x1, x2, x3, x4, y1, y2, y3, y4)

	local A1 = y2 - y1
	local B1 = x1 - x2
	local C1 = (A1 * x1) + (B1 * y1)

	local A2 = y4 - y3
	local B2 = x3 - x4
	local C2 = (A2 * x3) + (B2 * y3)

	local der = (A1 * B2) - (A2 * B1)


	if der == 0 then
		return false
	else
		local x = (B2 * C1 - B1 * C2) / der
		local y = (A1 * C1 - A2 * C1) / der

		local xtable1 = {x1, x2}
		local ytable1 = {y1, y2}

		local xtable2 = {x3, x4}
		local ytable2 = {y3, y4}


		if (min(xtable1) > x) or (min(ytable1) > y) or (max(xtable1) < x) or (max(ytable1) < y) or
		(min(xtable2) > x) or (min(ytable2) > y) or (max(xtable2) < x) or (max(ytable2) < y) then
			return false
		else
			return true
		end
	end
end
