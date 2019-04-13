function createPathNode(x,y)
  --create for wall corners and doorways
  local pathNode = {}

  pathNode.x = x
  pathNode.y = y

  function pathNode.draw()
    if displayHitbox then
      love.graphics.circle( "fill", x, y, 10, 3)
    end
  end

  return pathNode
end

function drawPaths()
  if displayHitbox then
    for i=1, #pathNodes, 1 do
      for j=i, #pathNodes, 1 do
        if(adjMat[i][j] > 0) then
          love.graphics.line(pathNodes[i].x,pathNodes[i].y,pathNodes[j].x,pathNodes[j].y)
        end
      end
    end
  end
end

function distanceF(x1,y1,x2,y2)
  return math.sqrt((x1-x2)^2+(y1-y2)^2)
end
