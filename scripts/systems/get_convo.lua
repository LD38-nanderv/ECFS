Core = Core or {}
function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
    if not file_exists(file) then return "" end
    lines = ""
    for line in io.lines(file) do
        lines = lines.. line.."\n"
    end
    return lines
end

-- tests the functions above


JSON= require "lib.JSON" -- one-time load of the routines
local raw_json_text =love.filesystem.read("data/test.json")
CONVO = JSON:decode(raw_json_text) -- decode example


current = CONVO[1]
CONVO_STATE = {}
for k,v in ipairs(CONVO) do
    CONVO[v.id] = v
    CONVO[k] = nil
end
--current = CONVO[current.choices[1]]
pprint(CONVO)
local function interpret(state)
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
        pprint(state.branches)
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
    pprint(next)
    local nxt = CONVO[next]
    pprint(nxt)
    current = nxt
    interpret(nxt)
end


return function()
    love.graphics.printf(current.name, 50,80,380)
    if current.choices and #current.choices > 0 then
        for k,v in ipairs(current.choices) do
                love.graphics.setColor(0,180,0)
                love.graphics.rectangle("fill",CWIDTH+1, 400-CWIDTH*(k-1), 400-2,CWIDTH-1)
                love.graphics.setColor(0,200,0)
                love.graphics.rectangle("line",CWIDTH+1, 400-CWIDTH*(k-1), 400-2, CWIDTH-1)
                love.graphics.setColor(255,255,255)
                love.graphics.print(CONVO[v].name, 60, 410-CWIDTH*(k-1))
        end
    elseif current.next then
        love.graphics.setColor(0,180,0)
        love.graphics.rectangle("fill",CWIDTH+1, 400, 400-2,CWIDTH-1)
        love.graphics.setColor(0,200,0)
        love.graphics.rectangle("line",CWIDTH+1, 400, 400-2, CWIDTH-1)
        love.graphics.setColor(255,255,255)
        love.graphics.print("Continue..", 60, 410)
    end
end