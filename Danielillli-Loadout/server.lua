-- Easily add more loadouts below:
local loadouts = {
    ["Cadet"] = {
        "weapon_nightstick",
        "weapon_stungun",
        "weapon_flashlight"
    },
    ["Officer"] = {
        "weapon_pistol",
        "weapon_nightstick",
        "weapon_stungun",
        "weapon_flashlight",
        "weapon_flare"
    },
    ["Sergeant"] = {
        "weapon_pistol_mk2",
        "weapon_carbinerifle",
        "weapon_nightstick",
        "weapon_stungun",
        "weapon_flashlight",
        "weapon_flare"
    },
    ["Chief"] = {
        "weapon_combatpistol",
        "weapon_carbinerifle_mk2",
        "weapon_nightstick",
        "weapon_stungun",
        "weapon_flashlight",
        "weapon_flaregun"
    },
    ["ambulance"] = {
        "weapon_fireextinguisher",
        "weapon_flashlight"
    }
    -- Add additional loadouts below
}

RegisterCommand("loadout", function(source, args)
    local player = source
    local loadoutName = args[1]

    if loadouts[loadoutName] then
        RemoveAllPedWeapons(GetPlayerPed(player), true)

        for _, weaponHash in ipairs(loadouts[loadoutName]) do
            GiveWeaponToPed(GetPlayerPed(player), GetHashKey(weaponHash), 250, false, true)
        end

        TriggerClientEvent('loadout:DisplayNotification', player, "Loadout: " .. loadoutName .. " has been given.")
    else
        TriggerClientEvent('loadout:DisplayNotification', player, "Invalid loadout name!")
    end
end, false)

RegisterCommand("clearloadout", function(source)
    local player = source
    RemoveAllPedWeapons(GetPlayerPed(player), true)
    TriggerClientEvent('loadout:DisplayNotification', player, "All weapons have been removed.")
end, false)
