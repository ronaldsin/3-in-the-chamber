function createButton(x1, x2, y1, y2)
  local button = {} -- create button table

  button.left = x1
  button.right = x2
  button.top = y1
  button.down = y2

  function button.checkClicked()
      if love.mouse.isDown(input_player_shoot) and love.mouse.getX() > button.left and love.mouse.getX() < button.right and love.mouse.getY() > button.top and love.mouse.getY() < button.bottom then
        return true
      end
      return false
  end

 return button
end
