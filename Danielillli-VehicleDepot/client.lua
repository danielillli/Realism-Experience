RegisterNetEvent('vehicle:spawn')
AddEventHandler('vehicle:spawn', function(vehicleName)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    
    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    local vehicle = CreateVehicle(vehicleName, coords.x, coords.y, coords.z, heading, true, false)
    SetPedIntoVehicle(playerPed, vehicle, -1)
    SetModelAsNoLongerNeeded(vehicleName)
    TriggerEvent('chat:addMessage', {
        color = {255, 255, 255},
        multiline = true,
        args = {"Vehicle Spawner", "Spawned vehicle: " .. vehicleName}
    })
end)

RegisterNetEvent('vehicle:repair')
AddEventHandler('vehicle:repair', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle ~= 0 then
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0)
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"Repair", "Your vehicle has been repaired!"}
        })
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Repair", "You are not in a vehicle!"}
        })
    end
end)
