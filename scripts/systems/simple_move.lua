-- A system that applies a constant movement to an object.
return function(dt)
    if not E.move then
        return
    end
    dt = dt
    for _, v in ipairs(E.move) do

        local a_rot = v.mover.towards- v.position.rotation
        -- normalize rotation
        while  a_rot < 0 do
            a_rot =  a_rot+math.pi*2
        end
        while a_rot > math.pi*2 do
            a_rot = a_rot - math.pi*2
        end
        if math.abs(a_rot) > 0.05 then
            if a_rot > math.pi then
                v.position.rotation = v.position.rotation  - dt/20
            else
                v.position.rotation = v.position.rotation  + dt/20
            end
        end
        v.position.x = v.position.x + dt * v.mover.speed * math.sin(v.position.rotation)
        v.position.y = v.position.y + dt * v.mover.speed * math.cos(v.position.rotation)
    end
end

