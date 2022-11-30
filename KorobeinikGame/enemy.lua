function CreateEnemy(world, x, y, t)
    local enemy = {}
    enemy.body = love.physics.newBody(world, x, y, "dynamic")
    enemy.shape = love.physics.newRectangleShape(30, 30)
    enemy.fixture = love.physics.newFixture(enemy.body, enemy.shape, 1)
    enemy.tag = "enemy"
    enemy.fixture:setUserData(enemy)
    enemy.type = t
    enemy.collisionnormal = vector2.new(0, 0)
    enemy.direction = -1
    return enemy
end

function UpdateEnemies(enemies, dt)

    for i = 1, #enemies, 1 do
        if enemies[i].type == 1 then
            --blue enemy
            if enemies[i].collisionnormal.x == 1 or enemies[i].collisionnormal.x == -1 then
                --enemies[i].direction = enemies[i].collisionnormal.x
                enemies[i].direction = -enemies[i].direction
                enemies[i].collisionnormal.x = 0
            end

            local enemyvelocity = vector2.new(enemies[i].body:getLinearVelocity())
            enemies[i].body:setLinearVelocity(100 * enemies[i].direction, enemyvelocity.y)

        elseif enemies[i].type == 2 then
            --yellow enemy

        end
    end

    function BeginContactEnemy(fixtureA, fixtureB, contact)
        -- Enemy contact with platforms
        if (fixtureA:getUserData().tag == "enemy" and fixtureB:getUserData().tag == "platform") then
            fixtureA:getUserData().collisionnormal = vector2.new(contact:getNormal())
        elseif (fixtureA:getUserData().tag == "platform" and fixtureB:getUserData().tag == "enemy") then
            fixtureB:getUserData().collisionnormal = vector2.new(contact:getNormal())
            
            -- Enemy contact with boxes
        elseif (fixtureA:getUserData().tag == "enemy" and fixtureB:getUserData().tag == "box") then
            fixtureA:getUserData().collisionnormal = vector2.new(contact:getNormal())
        elseif (fixtureA:getUserData().tag == "box" and fixtureB:getUserData().tag == "enemy") then
            fixtureB:getUserData().collisionnormal = vector2.new(contact:getNormal())

            -- Enemy contact with Stones
        elseif (fixtureA:getUserData().tag == "enemy" and fixtureB:getUserData().tag == "stone") then
            fixtureA:getUserData().collisionnormal = vector2.new(contact:getNormal())
        elseif (fixtureA:getUserData().tag == "stone" and fixtureB:getUserData().tag == "enemy") then
            fixtureB:getUserData().collisionnormal = vector2.new(contact:getNormal())

            -- Enemy contact with Enemies
        elseif (fixtureA:getUserData().tag == "enemy" and fixtureB:getUserData().tag == "enemy") then
            fixtureA:getUserData().collisionnormal = vector2.new(contact:getNormal())
        elseif (fixtureA:getUserData().tag == "enemy" and fixtureB:getUserData().tag == "enemy") then
            fixtureB:getUserData().collisionnormal = vector2.new(contact:getNormal())

            --[[ Enemy contact with amonites
        elseif (fixtureA:getUserData().tag == "enemy" and fixtureB:getUserData().tag == "amonite") then
            fixtureA:getUserData().collisionnormal = vector2.new(contact:getNormal())
        elseif (fixtureA:getUserData().tag == "amonite" and fixtureB:getUserData().tag == "enemy") then
            fixtureB:getUserData().collisionnormal = vector2.new(contact:getNormal())
        end]]
        
       
    end
end


function DrawEnemies(enemies)
    for i = 1, #enemies, 1 do
        if enemies[i].type == 1 then
            love.graphics.setColor(0, 0, 1)

        elseif enemies[i].type == 2 then
            love.graphics.setColor(1, 1, 0)
        end
        love.graphics.polygon("fill", enemies[i].body:getWorldPoints(enemies[i].shape:getPoints()))
    end
end
end
