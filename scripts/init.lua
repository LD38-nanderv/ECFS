scripts = scripts or {}
local collision_update = scripts.systems.collision.init.functions.update

scripts.world_update = function(dt)
    collision_update(dt)
end

function scripts.handle_input(dt)
    scripts.input.wasd(dt)
    scripts.input.wisker(dt)
end

function scripts.handle_pre_world_update(dt)
    for k, v in ipairs(core.get_list("pre")) do
        core.runHandlers(k, v, "pre", dt)
    end
end

function scripts.handle_checkers() end

function scripts.handle_fetch_threading() end
