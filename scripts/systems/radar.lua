--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 22-4-2017
-- Time: 13:49
-- To change this template use File | Settings | File Templates.
--
local directions = { { y = 200, x = 200 }, { y = 200, x = 0 }, { y = 200, x = -200 } }
return function()
    love.graphics.setColor(255, 0, 0)



    for k, v in pairs(DETECTIONS.data) do
        local dist = v.dist
        if not dist or dist > 10000 then dist = "<=>" else dist = math.floor(dist) end

        love.graphics.print(dist, 200 + CWIDTH + 20 + (-k + 2) * 140, 45)
    end

    love.graphics.setColor(255, 255, 255)
end


