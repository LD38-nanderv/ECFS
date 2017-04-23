--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 22-4-2017
-- Time: 19:56
-- To change this template use File | Settings | File Templates.
--
notes = {}
for j=1,3 do
    notes[j] = {}
    for i=1,10 do
        notes[j][i] = love.audio.newSource("music/"..i..".ogg",true)
        if j == 2 then
            notes[j][i]:setVolume(0.7)
        else
            notes[j][i]:setVolume(1)
        end
        notes[j][i]:setPosition(-10*(2-j),5,0)
    end
end

local timer = 0
local stage = 0
local prev = 0
function sound()
    v = DETECTIONS.data[stage]
    local dist = v.dist

    if prev ~= 0 then
        notes[(stage+2)%3+1][prev]:stop()
    end

    if not dist or dist > 2000 then prev = 0 else
        dist = dist * 1.3
        if dist > 2000 then
            return
        end
        prev =  math.floor((2000-dist)/200)
        prev = math.max(stage, math.min(10,prev))
        notes[stage][prev]:seek(0.1)
        notes[stage][prev]:play()
    end
end
return function(dt)
    timer = timer + dt
    if stage == 0 and timer > 3 then
        stage = 1
        sound()
    end
    if stage == 1 and timer > 3.7 then
        stage = 2
        sound()
    end
    if stage == 2 and timer > 4.4 then
        stage = 3
        sound()
        timer = 0
        stage=0
    end
end