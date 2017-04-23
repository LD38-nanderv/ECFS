return function()

    return {
        name = "clickCoords",
        func = function(event, dt)
            if event.coords.x > CWIDTH and event.coords.x < 400 + CWIDTH and event.coords.y < CWIDTH then
                print("TOP BAR")
                local a = E.move[1].position.rotation
                local z = E.move[1].position.rotation - ((event.coords.x - 200 - CWIDTH) / 800) * math.pi
                E.move[1].mover.towards = z
            end

            if event.coords.y > CWIDTH and event.coords.y < 400 + CWIDTH and event.coords.x > 400 + CWIDTH then
                print("RIGHT BAR")
                local a = E.move[1].position.rotation
                local z = E.move[1].position.rotation - ((event.coords.y - 200 - CWIDTH) / 800) * math.pi - 0.5 * math.pi
                E.move[1].mover.towards = z
            end

            if event.coords.x > CWIDTH and event.coords.x < 400 + CWIDTH and event.coords.y > 400 + CWIDTH then
                print("BOTTOM BAR")
                local a = E.move[1].position.rotation
                local z = E.move[1].position.rotation - ((-event.coords.x + 200 + CWIDTH) / 800) * math.pi + math.pi
                E.move[1].mover.towards = z
            end

            if event.coords.y > CWIDTH and event.coords.y < 400 + CWIDTH and event.coords.x < CWIDTH then
                print("LEFT BAR")
                local a = E.move[1].position.rotation
                local z = E.move[1].position.rotation - ((-event.coords.y + 200 + CWIDTH) / 800) * math.pi + 0.5 * math.pi
                E.move[1].mover.towards = z
            end
            local x, y = event.coords.x, event.coords.y

            if current.choices and #current.choices > 0 then

                if x >CWIDTH and x < 400+CWIDTH then
                    local i =  1-math.floor((y-400)/32)
                    if current.choices[i] then

                        Core.propagate_state(current.choices[i])
                    end
                end
            elseif current.next then
                if x >CWIDTH and x < 400+CWIDTH then
                    local i =  1-math.floor((y-400)/32)
                    if i==1 then
                        Core.propagate_state(current.next)

                    end
                end
            end
                pprint(event)
        end
    }
end
