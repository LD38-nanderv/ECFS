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
for k,v in ipairs(CONVO) do
    CONVO[v.id] = v
    CONVO[k] = nil
end
pprint(current.choices)