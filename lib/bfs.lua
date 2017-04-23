--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 23-4-2017
-- Time: 13:28
-- To change this template use File | Settings | File Templates.
--
function YOUR_CHECK_FUNCTION(v)
    return true
end

function bfs(FROM, TO)
    local target = TO
    local neighbours = {{x=FROM.x, y= FROM.y}}
    local visited = {}
    visited[FROM.x..":"..FROM.y]=true
    local ptr = 1
    local found
    while not found and neighbours[ptr] do
        local x,y = neighbours[ptr].x, neighbours[ptr].y
        local targets = {{x=x+1,y=y, prev=neighbours[ptr]},{x=x-1,y=y, prev=neighbours[ptr]},{x=x,y=y+1, prev=neighbours[ptr]},{x=x,y=y-1, prev=neighbours[ptr]}}
        for k,v in ipairs(targets) do
            if v.x == target.x and v.y == target.y then
                found =  v
            end
            if not visited[v.x..":"..v.y] then
                if not YOUR_CHECK_FUNCTION(v) then
                    neighbours[#neighbours+1]=v
                end
                visited[v.x..":"..v.y] = true
            end
        end
        ptr = ptr + 1
    end

    local prev
    while found do

        prev = found
        local fnd = found.prev
        if fnd then
            fnd.next = found
        end
        found = fnd

    end
    local lst = {} -- your return value
    local found = prev
    while found do
        lst[#lst+1] = {x=found.x, y=found.y}
        found = found.next
    end
    return lst
end
for k,v in ipairs(bfs({x=10,y=10},{x=0,y=0})) do
    print(k,v.x, v.y)
end