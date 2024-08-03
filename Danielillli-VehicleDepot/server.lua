RegisterCommand('repairvehicle', function(source, args, rawCommand)
    local playerId = source
    TriggerClientEvent('vehicle:repair', playerId)
end, false)

RegisterCommand('spawnvehicle', function(source, args, rawCommand)
    local playerId = source
    local vehicleName = args[1] or "adder" -- Default vehicle if none specified

    if IsModelInCdimage(vehicleName) and IsModelAVehicle(vehicleName) then
        TriggerClientEvent('vehicle:spawn', playerId, vehicleName)
    else
        TriggerClientEvent('chat:addMessage', playerId, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Spawner", "Invalid vehicle model!"}
        })
    end
end, false)
