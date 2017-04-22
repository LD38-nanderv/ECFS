return function(dt)
    for _, v in pairs(E.wiskers) do

        love.graphics.circle("line", v.position.x, v.position.y, 10)
        local a = {}
        local beep = false
        for l, w in ipairs(v.wiskers) do
            local z = core.rotate_point(w, v.position.rotation)
            local aa, b, c = scripts.systems.collision.init.ray(v, { x = 0, y = 0 }, { x = z.x, y = z.y })

            if aa then
                local d, e = b - v.position.x, c - v.position.y

                a[w.c] = { entity = a, x = b, y = c, d = d, e = e, dist = math.sqrt(d * d + e * e) }
                beep = true
            else
                a[w.c] = { dist = 1 / 0 }
            end
        end
        core.add_event("pre", scripts.events.create_wisker_collision_event(v, a))
    end
end