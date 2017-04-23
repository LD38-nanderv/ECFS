pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.helpers.keyboard_input'
require 'lib.ECFS'
require 'lib.load_all_scripts'
DRONE = love.audio.newSource("music/drone.ogg")

STATE = "play"
function love.load()
    require 'scripts'
    scripts.systems.collision.init.functions.reset()
    core.system.add(scripts.systems.collision.init)

    local ent = {
        collision = {
            type = "test",
            box = true,
            polygon = { { x = -4, y = 0 }, { x = 0, y = 4 }, { x = 4, y = 0 }, { x = 0, y = -4 } },
            dynamic = true
        },
        position = { x = 1200, y = 1200, rotation = math.pi },
        mover = { speed = 10, towards = math.pi },
        wiskers = { { c = 1, x = 500, y = 2000 }, { c = 2, x = 0, y = 2000 }, { c = 3, x = -500, y = 2000 } }
    }
    core.entity.add(ent)

    -- add handlers
    local wasdplayer1 = scripts.handlers.print_onmove(ent)
    core.addHandler(wasdplayer1.name, wasdplayer1.func)
    local handler2 = scripts.handlers.click_coords_handler()
    core.addHandler(handler2.name, handler2.func)
    local handler2 = scripts.handlers.handle_wisker()
    core.addHandler(handler2.name, handler2.func)
    pprint(handler2)

    -- add block
    local c = { type = "test", box = true, polygon = { { x = -100, y = 0 }, { x = 0, y = 100 }, { x = 100, y = 0 }, { x = 0, y = -100 } }, dynamic = true }
    local ent = { collision = c, position = { x = 250, y = 0, rotation = 0 } }
    core.entity.add(ent)

    local m = require 'data.map'

    for k, v in pairs(m.layers[1].objects) do
        for i = -2, 2 do
            for j = -2, 2 do
                local c = { type = "test", box = true, polygon = v.polyline, dynamic = true }
                local ent = { collision = c, position = { x = v.x + i * 3200, y = v.y + j * 3200, rotation = v.rotation } }
                core.entity.add(ent)
            end
        end
    end
    DRONE:setLooping(true)
    love.timer.sleep(1)
    DRONE:play()
    DRONE:setVolume(0.45)
end

startcounter = 1
startThisFrame = 0
updaters = {
    start = function(dt)
        startThisFrame = startThisFrame + dt
        if startThisFrame > 5 then
            startThisFrame = 0
            startcounter = startcounter + 1
            if startcounter > #sentences then
                STATE = "credits"
            end
        end
    end,
    play = function(dt)
        ii = math.min(1, ii + dt)
        if ii < 1 then
            dt = 0
        else
            dt = dt * 1.7
        end
        scripts.handle_fetch_threading(dt)
        scripts.handle_input()
        scripts.handle_pre_world_update(dt)
        scripts.world_update(dt)
        scripts.handle_checkers(dt)
    end,
    death = function(dt)
        startThisFrame = math.min(1, startThisFrame + dt)

        if love.mouse.isDown(1) then
            STATE = "play"
            CONVO_STATE = {}
            start_CONVO()
            E.move[1].position = { x = 0, y = 0, rotation = math.pi }
            E.move[1].mover.towards = math.pi
        end
    end,
    credits = function(dt)
        startThisFrame = startThisFrame + dt
        if startThisFrame > 5 then
            STATE = "play"
        end
    end
}
function love.update(dt)
    local PS = STATE
    updaters[STATE](dt)
    if PS ~= STATE then
        updaters[STATE](dt)
    end
end

BG = love.graphics.newImage("bg.png")

ii = 0
sentences = { "One day I woke up, and I was here", "I don't know anything from before I got here", "I'm all alone in this strange place" }
drawers = {
    start = function(dt)
        if startThisFrame < 1 then
            love.graphics.setColor(255, 255, 255, 255 * startThisFrame)
        end
        if startThisFrame > 4 then
            love.graphics.setColor(255, 255, 255, 255 * (5 - startThisFrame))
        end
        love.graphics.printf(sentences[startcounter], 82, 200, 300, "center")
        love.graphics.setColor(255, 255, 255, 255)
    end,
    play = function(dt)
        love.graphics.setColor(255, 255, 255, ii * 255)
        love.graphics.draw(BG, 0, 0)
        scripts.systems.radar()
        scripts.systems.heading()
        scripts.systems.get_convo()
    end,
    death = function(dt)
        love.graphics.setColor(255, 255, 255, 255 * math.min(1, startThisFrame))
        love.graphics.draw(BG, 0, 0)
        scripts.systems.heading()
        ii = (1 - math.min(1, startThisFrame))
        scripts.systems.radar()
        scripts.systems.get_convo()

        love.graphics.setColor(255, 255, 255, 255 * math.min(1, startThisFrame))

        love.graphics.setNewFont(24)
        love.graphics.printf("Your vessel crashed, and you are no more.", 82, 200, 300, "center")
        love.graphics.setNewFont(14)
        love.graphics.setColor(255, 255, 255, 255 * math.max(1, math.min(startThisFrame-10)))

        love.graphics.print("Click to restart", 75, 350)
        love.graphics.setColor(255, 255, 255, 255)
    end,
    credits = function()
        if startThisFrame < 1 then
            love.graphics.setColor(255, 255, 255, 255 * startThisFrame)
        end
        if startThisFrame > 4 then
            love.graphics.setColor(255, 255, 255, 255 * (5 - startThisFrame))
        end
        love.graphics.setNewFont(24)
        love.graphics.printf("The lonely captain", 82, 200, 300, "center")
        love.graphics.setNewFont(14)
        love.graphics.print("A game by Nander Voortman", 75, 350)
        love.graphics.setColor(255, 255, 255, 255)
    end
}


function love.draw()
    drawers[STATE]()
end
