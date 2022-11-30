require "Player"
require "vector2"
function CreateBullets(world,x,y)
    local bullets = {}
    bullets.pic = love.graphics.newImage("assets/bullet.png")
    --bullets.body = love.physics.newBody(world, 10,30, "dynamic")
    --bullets.shape = love.physics.newRectangleShape(5, 3)
    --bullets.fixture = love.physics.newFixture(bullets.body, bullets.shape, 1)
    --bullets.fixture:setFriction(1)
    --bullets.body:setFixedRotation(true)

    bullets.x = 100
    bullets.y = 200
	bullets.Speed = 1000
	
	bullets.ShootingRate = 0.9
	
	bullets.ShootingTime = 0

    return bullets
end

--[[function CreateDonuts(world,x,y)
    local donuts = {}
	donuts.Speed = 1000
	donuts.ShootingRate = 0.9
	donuts.ShootingTime = 0
    return donuts
end]]


--[[function BulletUpdate(bullets,dt)
    local BulletSpeed = vector2.new(1500, 0)
    if love.mouse.isDown(1) then 
        bullets.body:applyForce(BulletSpeed.x, BulletSpeed.y)
    end
function BulletSpawn()
    table.insert(bullets,{x = X, y = Y ,BulletSpeed})
end
end]]

function bulletSpawn(bullets)
   
    table.insert(bullets,{x = bullets.x+46, y = bullets.y+29 ,bulletSpeed = bullets.Speed })
    function createbullets()
    local bullets = {}
    bullets.bullet = love.graphics.newImage("assets/bullet.png")
   
    bullets.bulletSpeed = 2000
    bullets.bulletShootingRate = 0.9
    bullets.bulletShootingTime = 0
    
    return bullets
end

bcounter = 15 

function createdonuts()
    local donuts = {}
    donuts.donut = love.graphics.newImage("assets/donut.png")
    donuts.donutSpeed = 400
    donuts.donutShootingRate = 0.35
    donuts.donutShootingTime = 0
    return donuts
end



function bulletsUpdate(bullets,dt)
    for i,v in ipairs(bullets) do
        v.x = v.x + v.bulletSpeed * dt 
    end
end

function donutsUpdate(donuts,dt)
    for i,v in ipairs(donuts) do
        v.x = v.x + v.donutSpeed * dt 
    end
end

function bulletSpawn(bullets,player)
    table.insert(bullets,{x = player.body:getX()+46, y = player.body:getY()-4 ,bulletSpeed = bullets.bulletSpeed })
end

function donutSpawn(donuts,player)
    
    table.insert(donuts,{x = player.body:getX()+42, y = player.body:getY() ,donutSpeed = donuts.donutSpeed })

end


function bulletDraw(bullets)
    for i,v in ipairs(bullets) do 
        love.graphics.draw(bullets.bullet,v.x,v.y,0,1,1)
    end
end

function donutDraw(donuts)
    for i,v in ipairs(donuts) do 
        love.graphics.draw(donuts.donut,v.x,v.y,0,1,1)
    end
end
end

function BulletDraw(bullets)
    for i,v in ipairs(bullets) do 
        love.graphics.draw(bullets.pic,v.x,v.y,0,0.6,0.6)
    end
end
--[[for i,v in ipairs(donuts) do 
    love.graphics.draw(donut,v.x,v.y,0,0.4,0.4)
end]]


