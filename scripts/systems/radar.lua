--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 22-4-2017
-- Time: 13:49
-- To change this template use File | Settings | File Templates.
--
local directions ={{y=200,x=200},{y=200,x=0}, {y=200,x=-200}}
return function()
    for i,v in ipairs(directions) do
        local aa, b, c = scripts.systems.collision.init.ray(E.move[1], { x = 0, y = 0 }, v)
        local dist = ">100"
        if aa then


            local d, e = b - E.move[1].position.x, c - E.move[1].position.y
            dist  = "".. math.floor(math.sqrt(d * d + e * e))

        end
        love.graphics.print( dist, 200-(i-2)*180, 26)
    end


end


