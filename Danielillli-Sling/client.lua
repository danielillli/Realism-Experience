local WEAPON_CARBINERIFLE = `WEAPON_CARBINERIFLE`
local WEAPON_PUMPSHOTGUN = `WEAPON_PUMPSHOTGUN`
local ANIM_DICT = "mp_player_intdrink"
local ANIM_NAME = "loop_bottle"
local BONE_FRONT = 18905
local BONE_BACK = 24816

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function attachWeapon(player, weaponObj, bone, offset)
    AttachEntityToEntity(weaponObj, player, GetPedBoneIndex(player, bone), offset.x, offset.y, offset.z, offset.rx, offset.ry, offset.rz, 1, 1, 0, 0, 2, 1)
end

local function handleWeaponSling(slingSlot, weaponHash, hasSling, slingWeapon, weaponToSling, ammoInSling, offset)
    if not hasSling then
        weaponToSling = GetSelectedPedWeapon(slingSlot)
        ammoInSling = GetAmmoInPedWeapon(slingSlot, weaponToSling)
        Wait(100)

        if not HasWeaponAssetLoaded(weaponToSling) then
            RequestWeaponAsset(weaponToSling)
            while not HasWeaponAssetLoaded(weaponToSling) do
                Wait(0)
            end
        end

        slingWeapon = CreateWeaponObject(weaponToSling, 50, 1.0, 1.0, 1.0, true, 1.0, 0)
        attachWeapon(slingSlot, slingWeapon, BONE_FRONT, {x = 0.0, y = 0.0, z = 0.0, rx = 90.0, ry = 90.0, rz = 0.0})

        if Config.ShouldAddAttach then
            GiveWeaponComponentToWeaponObject(slingWeapon, `COMPONENT_AT_AR_FLSH`)
            if weaponToSling == WEAPON_CARBINERIFLE then
                GiveWeaponComponentToWeaponObject(slingWeapon, `COMPONENT_AT_SCOPE_MEDIUM`)
            end
        end

        RemoveWeaponFromPed(slingSlot, weaponToSling)
        hasSling = true
        SetCurrentPedWeapon(slingSlot, `WEAPON_UNARMED`, true)

        loadAnimDict(ANIM_DICT)
        TaskPlayAnim(slingSlot, ANIM_DICT, ANIM_NAME, 8.0, -8.0, 200, 49, 0, 0, 0, 0)
        Wait(100)
        ClearPedTasks(slingSlot)
        RemoveAnimDict(ANIM_DICT)
        attachWeapon(slingSlot, slingWeapon, BONE_BACK, offset)
    else
        hasSling = false
        loadAnimDict(ANIM_DICT)
        TaskPlayAnim(slingSlot, ANIM_DICT, ANIM_NAME, 8.0, -8.0, 200, 49, 0, 0, 0, 0)
        Wait(50)
        attachWeapon(slingSlot, slingWeapon, BONE_FRONT, {x = 0.0, y = 0.0, z = 0.0, rx = 90.0, ry = 90.0, rz = 0.0})
        Wait(50)
        ClearPedTasks(slingSlot)
        RemoveAnimDict(ANIM_DICT)

        if DoesEntityExist(slingWeapon) then
            DeleteObject(slingWeapon)
            RemoveWeaponAsset(slingWeapon)
            SetModelAsNoLongerNeeded(slingWeapon)
        end

        GiveWeaponToPed(slingSlot, weaponToSling, ammoInSling, false)

        if Config.ShouldAddAttach then
            GiveWeaponComponentToPed(slingSlot, weaponToSling, `COMPONENT_AT_AR_FLSH`)
            if weaponToSling == WEAPON_CARBINERIFLE then
                GiveWeaponComponentToPed(slingSlot, weaponToSling, `COMPONENT_AT_SCOPE_MEDIUM`)
            end
        end

        SetCurrentPedWeapon(slingSlot, weaponToSling, true)
        SetPedAmmo(slingSlot, weaponToSling, ammoInSling)
    end
    return hasSling, slingWeapon, weaponToSling, ammoInSling
end

RegisterCommand(Config.Command, function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    local offsetFront = {x = 0.0, y = 0.27, z = -0.02, rx = 0.0, ry = 320.0, rz = 175.0}
    local offsetBack = {x = 0.05, y = -0.18, z = -0.02, rx = 0.0, ry = 165.0, rz = 0.0}

    if args[1] == "1" then
        if GetSelectedPedWeapon(player) == WEAPON_CARBINERIFLE or GetSelectedPedWeapon(player) == WEAPON_PUMPSHOTGUN then
            HasWeaponSlingOne, SlingWeaponOne, WeaponToSlingOne, AmmoInSlingOne = handleWeaponSling(player, WEAPON_CARBINERIFLE, HasWeaponSlingOne, SlingWeaponOne, WeaponToSlingOne, AmmoInSlingOne, offsetFront)
        end
    elseif args[1] == "2" then
        if GetSelectedPedWeapon(player) == WEAPON_CARBINERIFLE or GetSelectedPedWeapon(player) == WEAPON_PUMPSHOTGUN then
            HasWeaponSlingTwo, SlingWeaponTwo, WeaponToSlingTwo, AmmoInSlingTwo = handleWeaponSling(player, WEAPON_PUMPSHOTGUN, HasWeaponSlingTwo, SlingWeaponTwo, WeaponToSlingTwo, AmmoInSlingTwo, offsetBack)
        end
    end
end)
