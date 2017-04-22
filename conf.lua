CWIDTH = 16

love.conf = function(t)
    t.title = "Submarine"
    t.version = "0.10.2"
    t.window.width = 400+2*CWIDTH
    t.window.height = 400+2*CWIDTH
    t.window.resizable = false
    --t.console = true
    t.window.vsync = false
end