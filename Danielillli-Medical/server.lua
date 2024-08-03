local password = "999" -- Change this to your desired password

-- Command to become a medic
RegisterCommand('medic', function(source, args)
    local player = source
    local enteredPassword = args[1]

    -- Check if the entered password matches the defined password
    if enteredPassword == password then
        -- Grant the player medic permissions and open the menu
        TriggerClientEvent('medic:GrantMedicPermissions', player)
        TriggerClientEvent('medic:OpenMedicMenu', player)
        -- Add your Discord role integration here to give the player the appropriate Discord role
        -- Discord role integration code goes here
        TriggerEvent('chat:addMessage', { args = { '^2Medic:', 'You are now a medic!' } })
    else
        -- Display an error message if the password is incorrect
        TriggerEvent('chat:addMessage', { args = { '^1Error:', 'Incorrect password!' } })
    end
end)

-- Event handler to grant medic permissions
RegisterNetEvent('medic:GrantMedicPermissions')
AddEventHandler('medic:GrantMedicPermissions', function()
    local player = source

    -- Add your logic here to grant medic permissions to the player
    -- For example, you can set a variable or add them to a group

    -- Example: Set a variable to indicate medic status
    TriggerEvent('medic:SetMedicStatus', player, true)
end)

-- Event handler to revoke medic permissions
RegisterNetEvent('medic:RevokeMedicPermissions')
AddEventHandler('medic:RevokeMedicPermissions', function()
    local player = source

    -- Add your logic here to revoke medic permissions from the player
    -- For example, you can reset a variable or remove them from a group

    -- Example: Reset the variable indicating medic status
    TriggerEvent('medic:SetMedicStatus', player, false)
end)

-- Event handler to set medic status
RegisterNetEvent('medic:SetMedicStatus')
AddEventHandler('medic:SetMedicStatus', function(player, status)
    -- Add your logic here to handle the player's medic status
    -- For example, you can update a variable or database entry

    -- Example: Display a message to the player indicating their medic status
    if status then
        TriggerEvent('chat:addMessage', { args = { '^2Medic:', 'You are now a medic!' } })
    else
        TriggerEvent('chat:addMessage', { args = { '^2Medic:', 'You are no longer a medic.' } })
    end
end)

-- Command to open the medic menu
RegisterCommand('MedicMenu', function(source)
    local player = source

    -- Check if the player has medic permissions
    if IsPlayerMedic(player) then
        -- Open the medic menu
        TriggerClientEvent('medic:OpenMedicMenu', player)
    else
        -- Display an error message if the player is not a medic
        TriggerEvent('chat:addMessage', { args = { '^1Error:', 'You do not have permission to use this command.' } })
    end
end)

-- Function to check if a player is a medic
function IsPlayerMedic(player)
    -- Add your logic here to check if the player is a medic
    -- Replace the placeholder code with your medic permission check

    -- Example: Check if the player has a specific variable indicating medic status
    local isMedic = GetPlayerVariable(player, 'isMedic') -- Replace 'GetPlayerVariable' with your own implementation

    return isMedic
end

-- Command to revive a player
RegisterCommand('revive', function(source, args)
    local player = source

    -- Check if the player has medic permissions
    if IsPlayerMedic(player) then
        -- Check if a target player ID is provided
        local targetId = tonumber(args[1])
        if not targetId then
            TriggerEvent('chat:addMessage', { args = { '^1Error:', 'Invalid player ID.' } })
            return
        end

        -- Get the target player's server ID
        local target = GetPlayerByServerId(targetId)
        if not target then
            TriggerEvent('chat:addMessage', { args = { '^1Error:', 'Player not found.' } })
            return
        end

        -- Trigger the revive event on the target player
        TriggerClientEvent('medic:RevivePlayer', target)
        TriggerEvent('chat:addMessage', { args = { '^2Medic:', 'You have revived the player.' } })
    else
        TriggerEvent('chat:addMessage', { args = { '^1Error:', 'You do not have permission to use this command.' } })
    end
end)

-- Event handler to revive a player
RegisterNetEvent('medic:RevivePlayer')
AddEventHandler('medic:RevivePlayer', function()
    local player = source

    -- Add your logic here to revive the player
    -- For example, you can use native GTA V functions to revive the player

    -- Example: Revive the player by setting their health and position
    SetEntityHealth(player, 200) -- Set the player's health to 200 or any desired value
    local spawnCoords = vector3(0, 0, 0) -- Set the desired spawn position
    TriggerClientEvent('esx:teleport', player, spawnCoords) -- Teleport the player to the spawn position
end)
