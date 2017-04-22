return function(dt)
    for _, v in pairs(E.wiskers) do
        local sx = v.position.x
        local sy = v.position.y


        love.graphics.circle("line", v.position.x, v.position.y, 10)
        for _, w in ipairs(v.wiskers) do
            local z = core.rotate_point(w, v.position.rotation)
            love.graphics.line(sx, sy, z.x + sx, z.y+sy)
        end
        for _, w in ipairs(COLS) do
            love.graphics.circle("line", w.x, w.y, 30)
        end
    end
end