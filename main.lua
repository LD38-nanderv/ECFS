pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.helpers.keyboard_input'
require 'lib.ECFS'
require 'lib.load_all_scripts'

function love.load()
    require 'scripts'
    scripts.systems.collision.init.functions.reset()
    core.system.add(scripts.systems.collision.init)


    local ent = { collision = { type = "test", box = true, polygon = { { x = -1, y = 0 }, { x = 0, y = 1 }, { x = 1, y = 0 }, { x = 0, y = -1 } },
        dynamic = true }, position = { x = 250, y = 350, rotation =math.pi }  , mover={speed=10,towards=math.pi}, wiskers = { { c=1, x = 200, y = 200 }, {c=2, x=0, y=200}, { c=3, x = -200, y = 200 } }}
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
    love.graphics.draw(BG,0,0)
    love.graphics.push()
    local p = E.move[1].position

    -- rotate around the center of the screen by angle radians

    scripts.systems.collision.debug_draw(dt)
    scripts.systems.draw_wiskers(dt)
    love.graphics.pop()
    scripts.systems.radar()
    scripts.systems.heading()
end
