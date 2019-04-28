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

	s2.x = x3
	s2.y = y3
	e2.x = x4
	e2.y = y4

	local x, y = intersection(s1, e1, s2, e2)

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
