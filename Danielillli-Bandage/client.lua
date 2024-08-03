RegisterNetEvent('bandage:HealPlayer')
AddEventHandler('bandage:HealPlayer', function(healthToHeal)
    local playerPed = PlayerPedId()
    local playerHealth = GetEntityHealth(playerPed)
    local maxHealth = GetEntityMaxHealth(playerPed)

    if playerHealth < maxHealth then
        SetEntityHealth(playerPed, playerHealth + healthToHeal)
    end
end)

RegisterNetEvent('bandage:DisplayMessage')
AddEventHandler('bandage:DisplayMessage', function(message)
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {'Healing:', message}
    })
end)
