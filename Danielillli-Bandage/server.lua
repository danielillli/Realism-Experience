local bandageCount = {}
local lastBandageTime = {}
local lastRestockTime = {}

-- Command to use a bandage
RegisterCommand('bandage', function(source, args, rawCommand)
    local playerId = tonumber(source)

    if not bandageCount[playerId] then
        bandageCount[playerId] = 3
    end

    local currentTime = os.time()
    local lastTime = lastBandageTime[playerId] or 0
    local cooldown = 8 -- Cooldown in seconds

    if currentTime - lastTime >= cooldown then
        if bandageCount[playerId] > 0 then
            local playerPed = GetPlayerPed(playerId)
            local playerHealth = GetEntityHealth(playerPed)
            local maxHealth = GetEntityMaxHealth(playerPed)
            local healthToHeal = math.random(20, 30) / 100 * maxHealth

            if playerHealth < maxHealth then
                TriggerClientEvent('bandage:HealPlayer', playerId, healthToHeal)
                bandageCount[playerId] = bandageCount[playerId] - 1
                lastBandageTime[playerId] = currentTime
                TriggerClientEvent('bandage:DisplayMessage', playerId, 'You used a bandage and healed ' .. tostring(healthToHeal) .. ' health.')

                if bandageCount[playerId] <= 0 then
                    Citizen.SetTimeout(500000, function()
                        bandageCount[playerId] = 3
                        TriggerClientEvent('bandage:DisplayMessage', playerId, 'You have restocked your bandages. You can now use them again.')
                    end)
                end
            else
                TriggerClientEvent('bandage:DisplayMessage', playerId, 'You are already at full health.')
            end
        else
            TriggerClientEvent('bandage:DisplayMessage', playerId, 'You are out of bandages. Use /restockbandages to get more.')
        end
    else
        local remainingTime = cooldown - (currentTime - lastTime)
        TriggerClientEvent('bandage:DisplayMessage', playerId, 'Please wait ' .. remainingTime .. ' seconds before using another bandage.')
    end
end)

-- Command to restock bandages
RegisterCommand('restockbandages', function(source, args, rawCommand)
    local playerId = tonumber(source)
    local currentTime = os.time()
    local lastTime = lastRestockTime[playerId] or 0
    local cooldown = 500 -- Cooldown in seconds

    if currentTime - lastTime >= cooldown then
        bandageCount[playerId] = 3
        lastRestockTime[playerId] = currentTime
        TriggerClientEvent('bandage:DisplayMessage', playerId, 'You have restocked your bandages. You can now use them again.')
    else
        local remainingTime = cooldown - (currentTime - lastTime)
        TriggerClientEvent('bandage:DisplayMessage', playerId, 'Please wait ' .. remainingTime .. ' seconds before restocking bandages.')
    end
end)
