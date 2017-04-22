local events = {}
local Down = core.keyboard.isDown

local a = function(evt)
    events[evt] = evt
end
a(core.When(core.PreFill(love.mouse.isDown,1), function() core.add_event( "pre", scripts.events.click_coords({ x = love.mouse.getX( ), y = love.mouse.getY( ) } ) ) end))



return function(dt)
    for k, v in pairs(events) do
        v(dt)
    end
end