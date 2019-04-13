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
    for i=1, 7, 1 do
      for j=i, 7, 1 do
        if(adjMat[i][j] > 0) then
          love.graphics.line(pathNodes[i].x,pathNodes[i].y,pathNodes[j].x,pathNodes[j].y)
        end
      end
    end
  end
end
