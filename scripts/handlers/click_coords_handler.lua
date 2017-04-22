return function()

    return {
        name = "clickCoords",
        func = function(event, dt)
            if event.coords.x > CWIDTH and event.coords.x < 400+CWIDTH and event.coords.y < CWIDTH then
                print("TOP BAR")
                local a = E.move[1].position.rotation
                local z = E.move[1].position.rotation-((event.coords.x-200-CWIDTH)/800)*math.pi
                E.move[1].mover.towards = z
            end

            if event.coords.y > CWIDTH and event.coords.y < 400+CWIDTH and event.coords.x > 400+CWIDTH then
                print("RIGHT BAR")
                local a = E.move[1].position.rotation
                local z = E.move[1].position.rotation-((event.coords.y-200-CWIDTH)/800)*math.pi-0.5*math.pi
                E.move[1].mover.towards = z
            end

            if event.coords.x > CWIDTH and event.coords.x < 400+CWIDTH and event.coords.y > 400+CWIDTH then
                print("BOTTOM BAR")
                local a = E.move[1].position.rotation
                local z = E.move[1].position.rotation-((-event.coords.x+200+CWIDTH)/800)*math.pi+math.pi
                E.move[1].mover.towards = z
            end

            if event.coords.y > CWIDTH and event.coords.y < 400+CWIDTH and event.coords.x < CWIDTH then
                print("LEFT BAR")
                local a = E.move[1].position.rotation
                local z = E.move[1].position.rotation-((-event.coords.y+200+CWIDTH)/800)*math.pi+0.5*math.pi
                E.move[1].mover.towards = z
            end
            pprint(event)
        end
    }
end
