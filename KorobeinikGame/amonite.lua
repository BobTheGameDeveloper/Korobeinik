function CreateAmonite(world,x,y)
    local amonite = {}
    amonite.body = love.physics.newBody(world, x, y, "static")
    amonite.shape = love.physics.newRectangleShape(43, 57)
    amonite.fixture = love.physics.newFixture(amonite.body,amonite.shape,1)
    amonite.fixture:setFriction(0.5)
    amonite.fixture:setUserData(amonite)
    amonite.tag = "amonite"
    amonitPic = love.graphics.newImage("assets/amonite.png")
    return  amonite
end

function DrawAmonite(amonites)

    for i = 1,#amonites,1 do 
        love.graphics.draw(amonitPic,amonites[i].body:getX()-32, amonites[i].body:getY()-39,0,2,2)
        --love.graphics.setColor(1, 0, 0)
        --love.graphics.polygon("fill", amonites[i].body:getWorldPoints(amonites[i].shape:getPoints()))
        
    end
end