Core = Core or {}

JSON= require "lib.JSON" -- one-time load of the routines
CONVO = nil
current = nil
CONVO_STATE = {}

function load_new_CONVO(file)
    local raw_json_text =love.filesystem.read("data/"..file)
    CONVO = JSON:decode(raw_json_text) -- decode example
    current = CONVO[1]
    local currentt
    for k,v in ipairs(CONVO) do
        if CONVO[k].actor == "FIRST" then
            currentt = CONVO[k].next

        end
        CONVO[v.id] = v
        CONVO[k] = nil
    end
    if currentt then
        Core.propagate_state(currentt)

    end
end

function start_CONVO()
    load_new_CONVO("test.json")
end

start_CONVO()
local function interpret(state)
    if state.name and string.sub(state.name, 1, 4) == "!@#$" then
        load_new_CONVO(string.sub(state.name, 5))
    end
    if state.type == "Set" then
        CONVO_STATE[state.variable] = state.value
        if state.next then
            Core.propagate_state(state.next)
        end
    end
    if state.type =="Choice" then
        if state.next then
            Core.propagate_state(state.next)
        else
            print("state doesn't have next after choices")
        end
    end
    if state.type == "Branch" then

        if CONVO_STATE[state.variable] and state.branches[CONVO_STATE[state.variable]] then
            Core.propagate_state(state.branches[CONVO_STATE[state.variable]])
        elseif state.branches._default then
            Core.propagate_state(state.branches._default)
        else
            print("NO NEXT STATE, PROBABLY CRASHED")
        end
    end
end

function Core.propagate_state(next)
    local nxt = CONVO[next]
    current = nxt
    interpret(nxt)
end

return function()
    love.graphics.printf(current.name, 50,80,370)
    if current.choices and #current.choices > 0 then
        for k,v in ipairs(current.choices) do
                love.graphics.setColor(0,180,0,255*ii)
                love.graphics.rectangle("fill",CWIDTH+1, 400-CWIDTH*(k-1), 400-2,CWIDTH-1)
                love.graphics.setColor(0,200,0,255*ii)
                love.graphics.rectangle("line",CWIDTH+1, 400-CWIDTH*(k-1), 400-2, CWIDTH-1)
                love.graphics.setColor(255,255,255,255*ii)
                love.graphics.print(CONVO[v].name, 60, 410-CWIDTH*(k-1))
        end
    elseif current.next then
        love.graphics.setColor(0,180,0,255*ii)
        love.graphics.rectangle("fill",CWIDTH+1, 400, 400-2,CWIDTH-1)
        love.graphics.setColor(0,200,0,255*ii)
        love.graphics.rectangle("line",CWIDTH+1, 400, 400-2, CWIDTH-1)
        love.graphics.setColor(255,255,255,255*ii)
        love.graphics.print("Continue..", 60, 410)
    end
end