--require "main"
function hoodload()
    font = love.graphics.newFont("assets/TriodPostnaja.ttf", 43)
    h = 3
    counterhood = love.graphics.newImage("assets/balalayka.png")
    heart = love.graphics.newImage("assets/heart.png")
    xh = 950
end

function hooddraw()
    love.graphics.setColor(1,1,1,0.9)
    love.graphics.print("X:"..bcounter, font, xh+60, 50)
    love.graphics.draw(counterhood, xh, 50, 0, 2, 2)
    for i = 1, h, 1 do
        love.graphics.draw(heart, 10 + i * 40, 50, 0, 4, 4)
    end
end