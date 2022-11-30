function CreateAmmo(world,x,y)
    local ammo = {}
    ammo.body = love.physics.newBody(world, x, y, "kinematic")
    ammo.shape = love.physics.newRectangleShape(58, 64)
    ammo.fixture = love.physics.newFixture(ammo.body,ammo.shape,1)
    ammo.fixture:setFriction(0.1)
    ammo.fixture:setUserData(ammo)
    ammo.tag = "ammo"
    ammoPic = love.graphics.newImage("assets/ammobox.png")
    return  ammo
end

function DrawAmmo(ammo1)

    for i = 1,#ammo1,1 do 
        love.graphics.draw(ammoPic,ammo1[i].body:getX()-32, ammo1[i].body:getY()-95,0,4,4)
        --love.graphics.setColor(1, 0, 0)
        --love.graphics.polygon("fill", ammo1[i].body:getWorldPoints(ammo1[i].shape:getPoints()))
        
    end
end