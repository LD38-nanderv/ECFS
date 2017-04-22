--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 22-4-2017
-- Time: 11:57
-- To change this template use File | Settings | File Templates.
--
CWIDTH = 16
local heading = love.graphics.newImage("heading.png")
local texture = love.graphics.newCanvas(heading:getDimensions())
love.graphics.setCanvas(texture)

love.graphics.setCanvas()

texture:setWrap("repeat","repeat")
return function()
    local pl = E.move[1]-- get player
    local mh = -pl.position.rotation+1.75*math.pi

    love.graphics.setCanvas(texture)
    love.graphics.draw(heading,0,0)

    local asdf = -E.move[1].mover.towards
    print(asdf)
    love.graphics.setColor(255,0,0)
    local xx = 1600*((asdf+4*math.pi)%(math.pi*2))/(math.pi*2)
    love.graphics.line(xx,0,xx,32)
    love.graphics.setColor(255,255,255)
    love.graphics.setCanvas()



    local quad = love.graphics.newQuad( math.floor(1600*(mh)/(math.pi*2)), 1, 400, CWIDTH,texture:getDimensions() )
    love.graphics.draw(texture, quad, CWIDTH,0,0)

    local quad = love.graphics.newQuad( math.floor(1600*(mh+0.5*math.pi)/(math.pi*2)), 1, 400, CWIDTH,texture:getDimensions() )
    love.graphics.draw(texture, quad, 400+2*CWIDTH,CWIDTH,0.5*math.pi)
    local quad = love.graphics.newQuad( math.floor(1600*(mh+1*math.pi)/(math.pi*2)), 1, 400, CWIDTH,texture:getDimensions() )
    love.graphics.draw(texture, quad, 400+CWIDTH,400+2*CWIDTH,math.pi)
    local quad = love.graphics.newQuad( math.floor(1600*(mh+1.5*math.pi)/(math.pi*2)), 1, 400, CWIDTH,texture:getDimensions() )
    love.graphics.draw(texture, quad, 1,400+CWIDTH,(-.5*math.pi))


    --local quad = love.graphics.newQuad( math.floor(800*(pl.position.rotation/2+1.5*math.pi)/(math.pi*2)), 1, 400, 32,heading:getDimensions() )
    --love.graphics.draw(heading, quad, 432,400,math.pi,1)
end

