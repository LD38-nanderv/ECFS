return function(dt)
    for _, v in pairs(E.wiskers) do

        love.graphics.circle("line", v.position.x, v.position.y, 10)
        local a = {}
        local beep = false
        for l, w in ipairs(v.wiskers) do
            local aa, b, c = scripts.systems.collision.init.ray(v, { x = 0, y = 0 }, { x = w.x, y = w.y })

            if aa then
                a[w] = { entity = a, x = b, y = c }
                local d, e = b - v.position.x, c - v.position.y
                print(d, e, math.sqrt(d * d + e * e))
                beep = true
            end
        end
        if beep then
            core.add_event("pre", scripts.events.create_wisker_collision_event(v, a))
        end
    end
end