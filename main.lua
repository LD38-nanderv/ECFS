pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.helpers.keyboard_input'
require 'lib.ECFS'
require 'lib.load_all_scripts'
DRONE = love.audio.newSource("music/drone.ogg")
function love.load()
    require 'scripts'
    scripts.systems.collision.init.functions.reset()
    core.system.add(scripts.systems.collision.init)
    require 'scripts.get_convo'

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

    for k,v in pairs(m.layers[1].objects) do
        for i=-2, 2 do
            for j = -2, 2 do
        local c = { type = "test", box = true, polygon = v.polyline, dynamic = true }
        local ent = { collision = c, position = {x=v.x+i*3200, y=v.y+j*3200, rotation=v.rotation} }
        core.entity.add(ent)
            end
        end

    end
    DRONE:setLooping(true)
    love.timer.sleep(1)
    DRONE:play()
    DRONE:setVolume(0.5)
end

function love.update(dt)
    dt = dt * 2
    scripts.handle_fetch_threading(dt)
    scripts.handle_input()
    scripts.handle_pre_world_update(dt)
    scripts.world_update(dt)
    scripts.handle_checkers(dt)
end

BG = love.graphics.newImage("bg.png")


function love.draw()
    love.graphics.draw(BG, 0, 0)
    love.graphics.push()
    local p = E.move[1].position

    -- rotate around the center of the screen by angle radians
    love.graphics.translate(-p.x+200,-p.y+200)
    --scripts.systems.collision.debug_draw(dt)
    --scripts.systems.draw_wiskers(dt)
    love.graphics.pop()
    scripts.systems.radar()
    scripts.systems.heading()
end
