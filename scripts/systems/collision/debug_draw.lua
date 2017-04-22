-- Draw debug shapes of the collision system.
local s = function(dt)
    if not E.collision then
        return
    end
    local p = E.move[1].position

    for _, v in ipairs(E.collision) do

        local arr = {}
        for _, w in ipairs(v.collision.polygon) do
            local x = core.rotate_point2(w, v.position.rotation)
            arr[#arr + 1] = x.x + v.position.x
            arr[#arr + 1] = x.y + v.position.y
        end
        local x = core.rotate_point2(v.collision.polygon[1], v.position.rotation)
        arr[#arr + 1] = x.x + v.position.x
        arr[#arr + 1] = x.y + v.position.y
        love.graphics.polygon("line", unpack(arr))
    end
end

return s
