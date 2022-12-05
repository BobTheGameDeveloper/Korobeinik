require "menu"
require "vector2"
require "player"
require "platform"
require "Box_physics"
require "hood"
require "Config"
require "EventArea"
require "enemy"
require "amonite"
require 'Stone'
require 'AmmoBox'
require "weapons"

local world
local player
local level1
local BoxInLevel1
local stones
local amonites
local level1end

function love.load()
    hoodload()
    background = love.graphics.newImage("assets/swamp.png")
    world = love.physics.newWorld(0,3000, true)
    world:setCallbacks(BeginContact,EndContact, nil, nil)
    player = CreatePlayer(world,100,300)
 
    BoxInLevel1 = {}
    BoxInLevel1[1] = BoxLoad(world,130,522,65,62)
    BoxInLevel1[2] = BoxLoad(world,1000,522,65,62)

    stones = {}
    stones[1] = StoneLoad(world,55, 547, 5, 5)
    stones[2] = StoneLoad(world,745, 547, 5, 5)
    stones[3] = StoneLoad(world,903, 547, 5, 5)
    stones[3] = StoneLoad(world,1497, 547, 5, 5)


    DethArea1 = CreateEventArea(world, 0, 1500, 210000, 1670, "deth1")
    DethArea2 = CreateEventArea(world, 0, 2500, 210000, 2100, "deth2")
    DethArea3 = CreateEventArea(world, 0, 4300, 210000, 1100, "deth3")
    level1end = CreateEventArea(world, 146500, 475, 400, 700, "level1end")

    level1 = {}
    level1[1] = CreatePlatform(world,400,575,700,50 )
    level1[2] = CreatePlatform(world,400,430,100,30 )
    level1[3] = CreatePlatform(world,1200,575,600,50 )
    level1[4] = CreatePlatform(world,1870,585,600,50 )
    level1[5] = CreatePlatform(world,2440,525,600,50 )
    level1[6] = CreatePlatform(world,3500,514,600,50 )
    level1[7] = CreatePlatform(world,4230,505,600,50 )
    level1[8] = CreatePlatform(world,5000,520,600,50 )
    level1[9] = CreatePlatform(world,5710,505,600,50 )
    level1[10] = CreatePlatform(world,6400,525,600,50 )
    level1[11] = CreatePlatform(world,7100,540,600,50 )
    level1[12] = CreatePlatform(world,7820,555,600,50 )
    level1[13] = CreatePlatform(world,8510,515,600,50 )
    level1[14] = CreatePlatform(world,9220,530,600,50 )
    level1[15] = CreatePlatform(world,9940,515,600,50 )
    level1[16] = CreatePlatform(world,10620,530,600,50 )
    level1[17] = CreatePlatform(world,11350,545,600,50 )
    level1[18] = CreatePlatform(world,12050,555,600,50 )
    level1[19] = CreatePlatform(world,12740,505,600,50 )
    level1[20] = CreatePlatform(world,13450,515,600,50 )
    level1[21] = CreatePlatform(world,14050,485,1300,50 )
    level1[22] = CreatePlatform(world,14650,475,100,50 )

    enemies = {}
    enemies[1] = CreateEnemy(world, 600 , 500 , 1 )
    enemies[2] = CreateEnemy(world, 200 , 500 , 1 )
    enemies[3] = CreateEnemy(world, 400 , 500 , 1 )
    enemies[4] = CreateEnemy(world, 1200 , 500 , 2 )



    amonites = {}
    amonites[1] = CreateAmonite(world,660,535) 



    ammo1 = {}
    ammo1[1]=CreateAmmo(world ,400,382)


    bullet = love.graphics.newImage("assets/bullet.png")
    bullets = {}
    bulletSpeed = 1000
	bulletShootingRate = 0.2
	bulletShootingTime = 0

    bullets1 = {}
	bulletSpeed1 = 2000
	bulletShootingRate1 = 0.2
	bulletShootingTime1 = 0

    bcounter = 15

    donut = love.graphics.newImage("assets/donut.png")
    donuts = {}
	donutSpeed = 1000
	donutShootingRate = 0.6
	donutShootingTime = 0

    donuts1 = {}
	donutSpeed1 = 1000
	donutShootingRate1 =  0.8
	donutShootingTime1 = 0 
    --createbullets()
    --createdonuts()
end
function BeginContact(fixtureA, fixtureB, contact)
  BeginContactPlayer(fixtureA,fixtureB,contact,player)
  BeginContactEnemy(fixtureA, fixtureB, contact)
  --BeginContactAmonite(fixtureA, fixtureB, contact, amonite)
end

function EndContact(fixtureA, fixtureB, contact)
    if (fixtureA:getUserData().tag == "player" and 
    fixtureB:getUserData().tag == "platform") or 
    (fixtureA:getUserData().tag == "platform" and 
    fixtureB:getUserData().tag == "player") or

    (fixtureA:getUserData().tag == "player" and 
    fixtureB:getUserData().tag == "box") or 
    (fixtureA:getUserData().tag == "box" and 
    fixtureB:getUserData().tag == "player") or

    (fixtureA:getUserData().tag == "player" and 
    fixtureB:getUserData().tag == "amonite") or 
    (fixtureA:getUserData().tag == "amonite" and 
    fixtureB:getUserData().tag == "player") then
        player.onground = false
        player.collisionnormal = vector2.new(0,0)
    end
end 

function love.keyreleased(key)
    keyreleasedPlayer(key,player)
end

function love.update(dt)

    UpdatePlayer(player,dt)
    UpdateEnemies(enemies, dt)
    world:update(dt)
    bulletShootingTime = bulletShootingTime + dt

	donutShootingTime = donutShootingTime + dt

    for i,v in ipairs(bullets) do
        v.x = v.x + v.bulletSpeed * dt 
    end

    for i,v in ipairs(bullets1) do
        v.x = v.x - v.bulletSpeed1  * dt 
    end

    for i,v in ipairs(donuts) do
        v.x = v.x + v.donutSpeed * dt 
    end

    for i,v in ipairs(donuts1) do
        v.x = v.x - v.donutSpeed1 * dt 
    end

    if love.mouse.isDown(1) and player.mode and bcounter > 0  then 
        love.audio.play(player.balalayka)
        if bulletShootingTime > bulletShootingRate then
            bulletSpawn()
            bulletShootingTime = 0
            bcounter = bcounter - 1
        end
    end
    
    if love.mouse.isDown(1) and player.mode and bcounter == 0  then 
        love.audio.play(player.netsrun)
    end
    
    if love.mouse.isDown(1) and not player.mode then 
        player.korobeinik:update(dt)
        player.korobeinik:setTag("trow1")    
        if donutShootingTime > donutShootingRate then     
        player.korobeinik:update(dt)
        player.korobeinik:setTag("def")  
        love.audio.play(player.vzmach)
        donutSpawn()
        donutShootingTime = 0
    end
end

    if love.mouse.isDown(1) and not player.mode and not player.onground then 
        player.korobeinik:update(dt) 
        player.korobeinik:setTag("jump3")
    end
end


function bulletSpawn()
    if direction == "right" then 
        table.insert(bullets,{x = player.body:getX()+46, y = player.body:getY()-4 ,bulletSpeed = bulletSpeed })
    end 
    
    if direction == "left" then 
        table.insert(bullets1,{x = player.body:getX()-46, y = player.body:getY()-4 ,bulletSpeed1 = bulletSpeed })
    end
end

function donutSpawn()
    if direction == "right" then 
        table.insert(donuts,{x = player.body:getX()+30, y = player.body:getY()-7 ,donutSpeed = donutSpeed })
    end
    
    if direction == "left" then
        table.insert(donuts1,{x = player.body:getX()-30, y = player.body:getY()-7 ,donutSpeed1 = donutSpeed })
    end
end

function love.draw()      
    love.graphics.push()
    love.graphics.draw(background)
    local playerposition = vector2.new(-player.body:getPosition(),player.body:getPosition())
    love.graphics.translate(playerposition.x+600,0)
    DrawPlayer(player)
    DrawAmmo(ammo1)  
    DrawAmonite(amonites)
    BoxDraw(BoxInLevel1)
    DrawStone(stones)
    DrawLevel(level1)
    DrawEnemies(enemies)
    
    --if direction == "right"  then   
    for i,v in ipairs(bullets) do 
        love.graphics.draw(bullet,v.x,v.y,0,bulletDirection,1)
        bulletDirection = 1 
    end
    
    --  if direction == "left"  then 
    for i,v in ipairs(bullets1) do 
        love.graphics.draw(bullet,v.x,v.y,0,bulletDirection,1)
        bulletDirection = -1 
    end
    
    --  if direction == "right"  then 
    for i,v in ipairs(donuts) do 
        donutDirection = 1 
        love.graphics.draw(donut,v.x,v.y,0,donutDirection ,1)
    end
    
    -- if direction == "left"  then 
    for i,v in ipairs(donuts1) do 
        donutDirection = -1
        love.graphics.draw(donut,v.x,v.y,0,donutDirection,1)
    end
    
    love.graphics.pop()
    DrawScreenDeath()
    hooddraw()
    
    function DrawLevelEnd(player)
        if player.completedlevel == true then
            love.graphics.print("LEVEL COMPLETED!", 550, 200)
        end
    end
end
