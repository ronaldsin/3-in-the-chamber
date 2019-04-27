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

function abs(x)
	if x < 0 then
		return x * -1
	end
	return x
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

function intersection (x1, x2, x3, x4, y1, y2, y3, y4)
	local d = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
	local a = x1 * y2 - y1 * x2
	local b = x3 * y4 - y3 * x4
	local x = (a * (x3 - x4) - (x1 - x2) * b) / d
	local y = (a * (y3 - y4) - (y1 - y2) * b) / d
	return x, y
end

function intersection (s1, e1, s2, e2)
	local d = (s1.x - e1.x) * (s2.y - e2.y) - (s1.y - e1.y) * (s2.x - e2.x)
	local a = s1.x * e1.y - s1.y * e1.x
	local b = s2.x * e2.y - s2.y * e2.x
	local x = (a * (s2.x - e2.x) - (s1.x - e1.x) * b) / d
	local y = (a * (s2.y - e2.y) - (s1.y - e1.y) * b) / d
	return x, y
end

function lineIntersection(x1, x2, x3, x4, y1, y2, y3, y4)
	local s1 = {}
	local e1 = {}

	local s2 = {}
	local e2 = {}

	s1.x = x1
	s1.y = y1
	e1.x = x2
	e1.y = y2

<<<<<<< HEAD
	s2.x = x3
	s2.y = y3
	e2.x = x4
	e2.y = y4

	local x, y = intersection(s1, e1, s2, e2)
=======
	if abs(der) < 0.001 then -- if the determinant is roughly 0 then it's parallel -> no intersection
		return false
	else
		local x = (B2 * C1 - B1 * C2) / der
		local y = (A1 * C1 - A2 * C1) / der
>>>>>>> 181fa65be591783fa18affd258faf94d3ad4dbc1

	local xtable1 = {x1, x2}
	local ytable1 = {y1, y2}

	local xtable2 = {x3, x4}
	local ytable2 = {y3, y4}


	if ((min(xtable1) > x) or (min(ytable1) > y) or (max(xtable1) < x) or (max(ytable1) < y)) or
	((min(xtable2) > x) or (min(ytable2) > y) or (max(xtable2) < x) or (max(ytable2) < y)) then
		return false
	else
		return true
	end

end
