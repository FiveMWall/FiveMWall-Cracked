-- Esto os lo dejamos desencriptadito para que veais la mierda de paste del LR

Citizen.CreateThread(function()
	TriggerServerEvent("HOSTETE-ANTICHEAT")
	TriggerServerEvent("HSTETE:cachearPlayers")
end)

Citizen.CreateThread(function()
    TriggerServerEvent("HSTETE:cachearPlayers")
end)
local titulo = "~w~Five~r~MW~w~all Menu"
local showblip =false nameabove = false esp = false Enabled = true Noclip = false GodModes = false Vanish = false
TriggerServerEvent('Hostete-AC:adminmenuenable')
RegisterNetEvent("Hostete-AC:adminmenuenabley")
AddEventHandler("Hostete-AC:adminmenuenabley", function()
    Enabled = false showblip = false nameabove = false esp = false
end)
local HSTETE = {}
local menus = {}
local keys = {up = 172, down = 173, left = 174, right = 175, select = 176, back = 177}
local optionCount = 0
local currentKey = nil
local currentMenu = nil
local welcome = "~w~Five~r~MW~w~all".._U('welcomev2')
local soundsd = "HUD_FRONTEND_DEFAULT_SOUNDSET"
local function setMenuProperty(id, property, value)
    if id and menus[id] then
            menus[id][property] = value
    end
end
local function isMenuVisible(id)
    if id and menus[id] then
            return menus[id].visible
    else
            return false
    end
end
local function setMenuVisible(id, visible, holdCurrent)
    if id and menus[id] then
            setMenuProperty(id, "visible", visible)
            if not holdCurrent and menus[id] then
                    setMenuProperty(id, "currentOption", 1)
            end
            if visible then
                    if id ~= currentMenu and isMenuVisible(currentMenu) then
                            setMenuVisible(currentMenu, false)
                    end
                    currentMenu = id
            end
    end
end
local function drawText(text, x, y, font, color, scale, center, shadow, alignRight)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    if shadow then
            SetTextDropShadow(2, 2, 0, 0, 0)
    end
    if menus[currentMenu] then
            if center then
                    SetTextCentre(center)
            elseif alignRight then
                    SetTextWrap(menus[currentMenu].x, menus[currentMenu].x + 0.21 - 0.005)
                    SetTextRightJustify(true)
            end
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
local function drawRect(x, y, width, height, color)
    DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
end
local function drawTitle()
    if menus[currentMenu] then
            local x = menus[currentMenu].x + 0.21 / 2
            local y = menus[currentMenu].y + 0.10 / 2
            if menus[currentMenu].titleBackgroundSprite then
                    DrawSprite(menus[currentMenu].titleBackgroundSprite.dict,menus[currentMenu].titleBackgroundSprite.name,x,y,0.21,0.10,0.,255,255,255,255)
            else
                    drawRect(x, y, 0.21, 0.10, menus[currentMenu].titleBackgroundColor)
            end
            drawText(menus[currentMenu].title,x,y - 0.10 / 2 + 0.03,menus[currentMenu].titleFont,menus[currentMenu].titleColor,0.9,true)
    end
end
local function drawSubTitle()
    if menus[currentMenu] then
            local x = menus[currentMenu].x + 0.21 / 2
            local y = menus[currentMenu].y + 0.10 + 0.040 / 2
            local subTitleColor = {
                    r = menus[currentMenu].titleBackgroundColor.r,
                    g = menus[currentMenu].titleBackgroundColor.g,
                    b = menus[currentMenu].titleBackgroundColor.b,
                    a = 255
            }
            drawRect(x, y, 0.21, 0.040, menus[currentMenu].subTitleBackgroundColor)
            drawText(menus[currentMenu].subTitle,menus[currentMenu].x + 0.005,y - 0.040 / 2 + 0.005,6,subTitleColor,0.470,false)
            if optionCount > menus[currentMenu].maxOptionCount then
                    drawText(tostring(menus[currentMenu].currentOption) .. " / " .. tostring(optionCount),menus[currentMenu].x + 0.21,y - 0.040 / 2 + 0.005,6,subTitleColor,0.470,false,false,true)
            end
    end
end
local function drawButton(text, subText)
    local x = menus[currentMenu].x + 0.21 / 2
    local multiplier = nil
    if menus[currentMenu].currentOption <= menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].maxOptionCount then
            multiplier = optionCount
    elseif optionCount > menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount and optionCount <= menus[currentMenu].currentOption then
            multiplier = optionCount - (menus[currentMenu].currentOption - menus[currentMenu].maxOptionCount)
    end
    if multiplier then
            local y = menus[currentMenu].y + 0.10 + 0.040 + (0.040 * multiplier) - 0.040 / 2
            local backgroundColor = nil
            local textColor = nil
            local subTextColor = nil
            local shadow = false
            if menus[currentMenu].currentOption == optionCount then
                    backgroundColor = menus[currentMenu].menuFocusBackgroundColor
                    textColor = menus[currentMenu].menuFocusTextColor
                    subTextColor = menus[currentMenu].menuFocusTextColor
            else
                    backgroundColor = menus[currentMenu].menuBackgroundColor
                    textColor = menus[currentMenu].menuTextColor
                    subTextColor = menus[currentMenu].menuSubTextColor
                    shadow = true
            end
            drawRect(x, y, 0.21, 0.040, backgroundColor)
            drawText(text,menus[currentMenu].x + 0.005,y - (0.040 / 2) + 0.005,6,textColor,0.470,false,shadow)
            if subText then
                    drawText(subText,menus[currentMenu].x + 0.005,y - 0.040 / 2 + 0.005,6,subTextColor,0.470,false,shadow,true)
            end
    end
end
local function k(l)
local m = {}
local n = GetGameTimer() / 200
m.r = math.floor(math.sin(n * l + 3) * 127 + 128)
m.g = math.floor(math.sin(n * l + 0) * 127 + 128)
m.b = math.floor(math.sin(n * l + 3) * 127 + 128)
return m
end    
function HSTETE.CreateMenu(id, title)
    menus[id] = {}
    menus[id].title = title
    menus[id].subTitle = welcome
    menus[id].visible = false
    menus[id].previousMenu = nil
    menus[id].aboutToBeClosed = false
    menus[id].x = 0.75
    menus[id].y = 0.35
    menus[id].currentOption = 1
    menus[id].maxOptionCount = 10
    menus[id].titleFont = 6
    menus[id].titleColor = {r = 255, g = 87, b = 51, a = 255}
    Citizen.CreateThread(function()
            while true do
                    Citizen.Wait(0)
                    local a8 = k(0.2)
                    menus[id].titleBackgroundColor = {r = a8.r, g = a8.g, b = a8.b, a = 105}
                    menus[id].menuFocusBackgroundColor = {r = 255, g = 255, b = 255, a = 100}
            end
    end)
    menus[id].titleBackgroundSprite = nil
    menus[id].menuTextColor = {r = 255, g = 255, b = 255, a = 255}
    menus[id].menuSubTextColor = {r = 189, g = 189, b = 189, a = 255}
    menus[id].menuFocusTextColor = {r = 255, g = 255, b = 255, a = 255}
    menus[id].menuBackgroundColor = {r = 0, g =  0, b = 0, a = 100}
    menus[id].subTitleBackgroundColor = {r = menus[id].menuBackgroundColor.r,g = menus[id].menuBackgroundColor.g,b = menus[id].menuBackgroundColor.b,a = 255}
    menus[id].buttonPressedSound = {name = "~h~~r~> ~s~SELECT", set = soundsd}
end
function HSTETE.CreateSubMenu(id, parent, subTitle)
    if menus[parent] then
            HSTETE.CreateMenu(id, menus[parent].title)
            if subTitle then
                    setMenuProperty(id, "subTitle", (subTitle))
            else
                    setMenuProperty(id, "subTitle", (menus[parent].subTitle))
            end
            setMenuProperty(id, "previousMenu", parent)
            setMenuProperty(id, "x", menus[parent].x)
            setMenuProperty(id, "y", menus[parent].y)
            setMenuProperty(id, "maxOptionCount", menus[parent].maxOptionCount)
            setMenuProperty(id, "titleFont", menus[parent].titleFont)
            setMenuProperty(id, "titleColor", menus[parent].titleColor)
            setMenuProperty(id, "titleBackgroundColor", menus[parent].titleBackgroundColor)
            setMenuProperty(id, "titleBackgroundSprite", menus[parent].titleBackgroundSprite)
            setMenuProperty(id, "menuTextColor", menus[parent].menuTextColor)
            setMenuProperty(id, "menuSubTextColor", menus[parent].menuSubTextColor)
            setMenuProperty(id, "menuFocusTextColor", menus[parent].menuFocusTextColor)
            setMenuProperty(id, "menuFocusBackgroundColor", menus[parent].menuFocusBackgroundColor)
            setMenuProperty(id, "menuBackgroundColor", menus[parent].menuBackgroundColor)
            setMenuProperty(id, "subTitleBackgroundColor", menus[parent].subTitleBackgroundColor)
    end
end
function HSTETE.CurrentMenu()
    return currentMenu
end
function HSTETE.OpenMenu(id)
    if id and menus[id] then
            PlaySoundFrontend(-1, "SELECT", soundsd, true)
            setMenuVisible(id, true)
            if menus[id].titleBackgroundSprite then
                    RequestStreamedTextureDict(menus[id].titleBackgroundSprite.dict, false)
                    while not HasStreamedTextureDictLoaded(menus[id].titleBackgroundSprite.dict) do
                            Citizen.Wait(0)
                    end
            end
    end
end
function HSTETE.IsMenuOpened(id)
    return isMenuVisible(id)
end
function HSTETE.CloseMenu()
    if menus[currentMenu] then
            if menus[currentMenu].aboutToBeClosed then
                    menus[currentMenu].aboutToBeClosed = false
                    setMenuVisible(currentMenu, false)
                    PlaySoundFrontend(-1, "QUIT", soundsd, true)
                    optionCount = 0
                    currentMenu = nil
                    currentKey = nil
            else
                    menus[currentMenu].aboutToBeClosed = true
            end
    end
end
function HSTETE.Button(text, subText)
    local buttonText = text
    if subText then
            buttonText = "{ " .. tostring(buttonText) .. ", " .. tostring(subText) .. " }"
    end
    if menus[currentMenu] then
            optionCount = optionCount + 1
            local isCurrent = menus[currentMenu].currentOption == optionCount
            drawButton(text, subText)
            if isCurrent then
                    if currentKey == keys.select then
                            PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name, menus[currentMenu].buttonPressedSound.set, true)
                            return true
                    elseif currentKey == keys.left or currentKey == keys.right then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", soundsd, true)
                    end
            end
            return false
    else
            return false
    end
end
function HSTETE.MenuButton(text, id)
    if menus[id] then
            if HSTETE.Button(text) then
                    setMenuVisible(currentMenu, false)
                    setMenuVisible(id, true, true)
                    return true
            end
    end
    return false
end
function HSTETE.CheckBox(text, bool, callback)
    local checked = "✔️/❌"
    if bool then
            checked = "❌/✔️"
    end
    if HSTETE.Button(text, checked) then
            bool = not bool
            callback(bool)
            return true
    end
    return false
end
function TSE(a,b,c,d,e,f,g,h,i,m)
    TriggerServerEvent(a,b,c,d,e,f,g,h,i,m)
end
function HSTETE.Display()
    if isMenuVisible(currentMenu) then
            if menus[currentMenu].aboutToBeClosed then
                    HSTETE.CloseMenu()
            else
                    ClearAllHelpMessages()
                    drawTitle()
                    drawSubTitle()
                    currentKey = nil
                    if IsDisabledControlJustPressed(0, keys.down) then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", soundsd, true)
                            if menus[currentMenu].currentOption < optionCount then
                                    menus[currentMenu].currentOption = menus[currentMenu].currentOption + 1
                            else
                                    menus[currentMenu].currentOption = 1
                            end
                    elseif IsDisabledControlJustPressed(0, keys.up) then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", soundsd, true)
                            if menus[currentMenu].currentOption > 1 then
                                    menus[currentMenu].currentOption = menus[currentMenu].currentOption - 1
                            else
                                    menus[currentMenu].currentOption = optionCount
                            end
                    elseif IsDisabledControlJustPressed(0, keys.left) then
                            currentKey = keys.left
                    elseif IsDisabledControlJustPressed(0, keys.right) then
                            currentKey = keys.right
                    elseif IsDisabledControlJustPressed(0, keys.select) then
                            currentKey = keys.select
                    elseif IsDisabledControlJustPressed(0, keys.back) then
                            if menus[menus[currentMenu].previousMenu] then
                                    PlaySoundFrontend(-1, "BACK", soundsd, true)
                                    setMenuVisible(menus[currentMenu].previousMenu, true)
                            else
                                    HSTETE.CloseMenu()
                            end
                    end
                    optionCount = 0
            end
    end
end
function HSTETE.SetMenuWidth(id, width)
    setMenuProperty(id, "width", width)
end
function HSTETE.SetMenuX(id, x)
    setMenuProperty(id, "x", x)
end
function HSTETE.SetMenuY(id, y)
    setMenuProperty(id, "y", y)
end
function HSTETE.SetMenuMaxOptionCountOnScreen(id, count)
    setMenuProperty(id, "maxOptionCount", count)
end
function HSTETE.SetTitleColor(id, r, g, b, a)
    setMenuProperty(id, "titleColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleColor.a})
end
function HSTETE.SetTitleBackgroundColor(id, r, g, b, a)
    setMenuProperty(
            id,
            "titleBackgroundColor",
            {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].titleBackgroundColor.a}
    )
end
function HSTETE.SetTitleBackgroundSprite(id, textureDict, textureName)
    setMenuProperty(id, "titleBackgroundSprite", {dict = textureDict, name = textureName})
end
function HSTETE.SetSubTitle(id, text)
    setMenuProperty(id, "subTitle", (text))
end
function HSTETE.SetMenuBackgroundColor(id, r, g, b, a)
    setMenuProperty(id,"menuBackgroundColor",{["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuBackgroundColor.a})
end
function HSTETE.SetMenuTextColor(id, r, g, b, a)
    setMenuProperty(id, "menuTextColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuTextColor.a})
end
function HSTETE.SetMenuSubTextColor(id, r, g, b, a)
    setMenuProperty(id, "menuSubTextColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuSubTextColor.a})
end
function HSTETE.SetMenuFocusColor(id, r, g, b, a)
    setMenuProperty(id, "menuFocusColor", {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a or menus[id].menuFocusColor.a})
end
function HSTETE.SetMenuButtonPressedSound(id, name, set)
    setMenuProperty(id, "buttonPressedSound", {["name"] = name, ["set"] = set})
end
Citizen.CreateThread(function()
    while true do
            Citizen.Wait(math.random(20000,30000))
            collectgarbage()
    end
end)
local function RespawnPed(ped, coords, heading)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    SetPlayerInvincible(ped, false)
    ClearPedBloodDamage(ped)
end
local function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
            Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
            AddTextEntry("FMMC_KEY_TIP1", "")
            local result = GetOnscreenKeyboardResult()
            Citizen.Wait(500)
            blockinput = false
            return result
    else
            AddTextEntry("FMMC_KEY_TIP1", "")
            Citizen.Wait(500)
            blockinput = false
            return nil
    end
end
local function DrawText3D(x, y, z, text, r, g, b)
    SetDrawOrigin(x, y, z, 0)
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(0.0, 0.35)
    SetTextColour(r, g, b, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
local function notify(text, param)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(param, false)
end
local HSTETEs = "FiveMWall"
local sMX = "SelfMenu"
local TRPM = "TeleportMenu"
local advm = "AdvM"
local VMS = "VehicleMenu"
local OPMS = "OnlinePlayerMenu"
local poms = "PlayerOptionsMenu"
local crds = "Credits"
local espa = "ESPMenu"
local function DrawTxt(text, x, y)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.4)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
local function teleporttocoords()
    local pizdax = KeyboardInput(_U('xpos'), "", 100)
    local pizday = KeyboardInput(_U('ypos'), "", 100)
    local pizdaz = KeyboardInput(_U('zpos'), "", 100)
    if pizdax ~= "" and pizday ~= "" and pizdaz ~= "" then
            local vari = {pizdax,pizday,pizdaz}
            local das = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','├▒','z','x','c','v','b','n','m','!','"','@','┬À','#','$','%','&','/','(',')','=','?','┬í','┬┐','``','^','[',']','+','*','├º',"'",":",";",".",",","-","_","┬║","┬¬",'\n',"|","┬¼"}
            nohaynada = true
            for a,s in pairs(vari) do
                    for k,v in pairs(das) do
                            if s:find(v, 1, true) then
                                    notify(_U('coorno'), true)
                                    nohaynada = false
                            end
                    end
            end
            if nohaynada then
                    if IsPedInAnyVehicle(PlayerPedId(), 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), 0), -1) == PlayerPedId()) then
                            entity = GetVehiclePedIsIn(PlayerPedId(), 0)
                    else
                                    entity = PlayerPedId()
                    end
                    if entity then
                            SetEntityCoords(entity, pizdax + 0.5, pizday + 0.5, pizdaz + 0.5, 1, 0, 0, 1)
                            notify(_U('tpnotify'), false)
                    end
            end
    else
    notify(_U('coorno'), true)
    end
end
local function TeleportToWaypoint()
    if DoesBlipExist(GetFirstBlipInfoId(8)) then
            local blipIterator = GetBlipInfoIdIterator(8)
            local blip = GetFirstBlipInfoId(8, blipIterator)
            WaypointCoords = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector())
            wp = true
    else
            notify(_U('notp'), true)
    end
    local zHeigt = 0.0
    height = 1000.0
    while wp do
            Citizen.Wait(0)
            if wp then
                    local player = PlayerPedId()
                    if IsPedInAnyVehicle(player, 0) and (GetPedInVehicleSeat(GetVehiclePedIsIn(player, 0), -1) == player) then
                            entity = GetVehiclePedIsIn(player, 0)
                    else
                            entity = player
                    end
                    SetEntityCoords(entity, WaypointCoords.x, WaypointCoords.y, height)
                    FreezeEntityPosition(entity, true)
                    local Pos = GetEntityCoords(entity, true)
                    if zHeigt == 0.0 then
                            height = height - 25.0
                            SetEntityCoords(entity, Pos.x, Pos.y, height)
                            bool, zHeigt = GetGroundZFor_3dCoord(Pos.x, Pos.y, Pos.z, 0)
                    else
                            SetEntityCoords(entity, Pos.x, Pos.y, zHeigt)
                            FreezeEntityPosition(entity, false)
                            wp = false
                            height = 1000.0
                            zHeigt = 0.0
                            notify(_U('tpnotify'), false)
                            break
                    end
            end
    end
end
local function spawnvehicle()
    local player = PlayerPedId()
    local ModelName = KeyboardInput(_U('carname'), "", 100)
    if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
            RequestModel(ModelName)
            while not HasModelLoaded(ModelName) do
                    Citizen.Wait(0)
            end
            local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(player), GetEntityHeading(player), true, true)
            SetPedIntoVehicle(player, veh, -1)
    else
            notify(_U('nomodel'), true)
    end
end
local function repairvehicle()
    local player = PlayerPedId()
    SetVehicleFixed(GetVehiclePedIsIn(player, false))
    SetVehicleDirtLevel(GetVehiclePedIsIn(player, false), 0.0)
    SetVehicleLights(GetVehiclePedIsIn(player, false), 0)
    SetVehicleBurnout(GetVehiclePedIsIn(player, false), false)
    Citizen.InvokeNative(0x1FD09E7390A74D54, GetVehiclePedIsIn(player, false), 0)
    SetVehicleUndriveable(vehicle,false)
end
local function NetWorkDelete(entity)
    local intento = 0
    while not NetworkHasControlOfEntity(entity) and intento < 50 and DoesEntityExist(entity) do
            NetworkRequestControlOfEntity(entity)
            intento = intento + 1
    end
    if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
            SetEntityAsMissionEntity(entity, false, true)
            DeleteEntity(entity)
    end
end
local bn = {
    "WEAPON_KNIFE", "WEAPON_BAT", "WEAPON_PISTOL",
    "WEAPON_APPISTOL", "WEAPON_PISTOL50", "WEAPON_HEAVYPISTOL",
    "WEAPON_VINTAGEPISTOL", 
    "WEAPON_SMG",  "WEAPON_COMBATPDW"
}

Citizen.CreateThread(function()
            while Enabled do
                    Citizen.Wait(0)
                    if DeleteGun then
                            local player = PlayerPedId()
                            if IsPedInAnyVehicle(player, true) == false then
                                    notify(_U('guantelete'))
                                    GiveWeaponToPed(player, GetHashKey('WEAPON_PISTOL'), 999999, false, true)
                                    SetPedAmmo(player, GetHashKey('WEAPON_PISTOL'), 999999)
                                    if GetSelectedPedWeapon(player) == GetHashKey('WEAPON_PISTOL') then
                                            if IsPlayerFreeAiming(PlayerId()) then
                                                    local bool, cB = GetEntityPlayerIsFreeAimingAt(PlayerId())
                                                    if bool then
                                                            if IsEntityAPed(cB) then
                                                                    if IsPedInAnyVehicle(cB, true) then
                                                                            if IsControlJustReleased(1, 142) then
                                                                                    if NetworkGetEntityIsNetworked(cB) then
                                                                                            SetEntityAsMissionEntity(GetVehiclePedIsIn(cB, true), 1, 1)
                                                                                            NetWorkDelete(GetVehiclePedIsIn(cB, true))
                                                                                            SetEntityAsMissionEntity(cB, 1, 1)
                                                                                            NetWorkDelete(cB)
                                                                                            notify(_U('Borrado'))
                                                                                    else
                                                                                            SetEntityAsMissionEntity(GetVehiclePedIsIn(cB, true), 1, 1)
                                                                                            DeleteEntity(GetVehiclePedIsIn(cB, true))
                                                                                            SetEntityAsMissionEntity(cB, 1, 1)
                                                                                            DeleteEntity(cB)
                                                                                            notify(_U('Borrado'))
                                                                                    end
                                                                            end
                                                                    else
                                                                            if IsControlJustReleased(1, 142) then
                                                                                    if NetworkGetEntityIsNetworked(cB) then
                                                                                            SetEntityAsMissionEntity(cB, 1, 1)
                                                                                            NetWorkDelete(cB)
                                                                                            notify(_U('Borrado'))
                                                                                    else
                                                                                            SetEntityAsMissionEntity(cB, 1, 1)
                                                                                            DeleteEntity(cB)
                                                                                            notify(_U('Borrado'))
                                                                                    end
                                                                            end
                                                                    end
                                                            else
                                                                    if IsControlJustReleased(1, 142) then
                                                                            if NetworkGetEntityIsNetworked(cB) then
                                                                                    SetEntityAsMissionEntity(cB, 1, 1)
                                                                                    NetWorkDelete(cB)
                                                                                    notify(_U('Borrado'))
                                                                            else
                                                                                    SetEntityAsMissionEntity(cB, 1, 1)
                                                                                    DeleteEntity(cB)
                                                                                    notify(_U('Borrado'))
                                                                            end
                                                                    end
                                                            end
                                                    end
                                            end
                                    end
                            end
                    end
            if esp then
                    for _, player in ipairs(GetActivePlayers()) do
                            local ra = {r = 255, g = 0, b = 255, a = 255}
                            local pPed = GetPlayerPed(player)
                            local cx, cy, cz = table.unpack(GetEntityCoords(PlayerPedId()))
                            local x, y, z = table.unpack(GetEntityCoords(pPed))
                            local disPlayerNames = 130
                            local disPlayerNamesz = 999999
                            distance = math.floor(#(vector3(cx, cy, cz) - vector3(x,  y, z)))
                                    if nameabove then
                                            if ((distance < disPlayerNames)) then
                                            if NetworkIsPlayerTalking(player) then
                                                    DrawText3D(x, y, z+1.2, GetPlayerServerId(player).."  |  "..GetPlayerName(player), ra.r,ra.g,ra.b)
                                            else
                                                    DrawText3D(x, y, z+1.2, GetPlayerServerId(player).."  |  "..GetPlayerName(player), 255,255,255)
                                            end
                                            end
                                    end
                            local message = _U('name') ..
                            GetPlayerName(player) .._U('serverid') ..
                            GetPlayerServerId(player) .._U('playerid') .. player .. _U('distance') .. math.round(#(vector3(cx, cy, cz) - vector3(x, y, z)), 1)
                            if IsPedInAnyVehicle(pPed, true) then
                                                    local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(pPed))))
                                    message = message .. _U('car') .. VehName
                            end
                            if ((distance < disPlayerNamesz)) then
                            if espinfo and esp then
                                    DrawText3D(x, y, z - 1.0, message, ra.r, ra.g, ra.b)
                            end
                            if espbox and esp then
                                    LineOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)
                                    LineOneEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)
                                    LineTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)
                                    LineTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
                                    LineThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
                                    LineThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, -0.9)
                                    LineFourBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)

                                    TLineOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)
                                    TLineOneEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
                                    TLineTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
                                    TLineTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
                                    TLineThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
                                    TLineThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, 0.8)
                                    TLineFourBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)

                                    ConnectorOneBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, 0.8)
                                    ConnectorOneEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, 0.3, -0.9)
                                    ConnectorTwoBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, 0.8)
                                    ConnectorTwoEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, 0.3, -0.9)
                                    ConnectorThreeBegin = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, 0.8)
                                    ConnectorThreeEnd = GetOffsetFromEntityInWorldCoords(pPed, -0.3, -0.3, -0.9)
                                    ConnectorFourBegin = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, 0.8)
                                    ConnectorFourEnd = GetOffsetFromEntityInWorldCoords(pPed, 0.3, -0.3, -0.9)

                                    DrawLine(LineOneBegin.x,LineOneBegin.y,LineOneBegin.z,LineOneEnd.x,LineOneEnd.y,LineOneEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(LineTwoBegin.x,LineTwoBegin.y,LineTwoBegin.z,LineTwoEnd.x,LineTwoEnd.y,LineTwoEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(LineThreeBegin.x,LineThreeBegin.y,LineThreeBegin.z,LineThreeEnd.x,LineThreeEnd.y,LineThreeEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(LineThreeEnd.x,LineThreeEnd.y,LineThreeEnd.z,LineFourBegin.x,LineFourBegin.y,LineFourBegin.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(TLineOneBegin.x,TLineOneBegin.y,TLineOneBegin.z,TLineOneEnd.x,TLineOneEnd.y,TLineOneEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(TLineTwoBegin.x,TLineTwoBegin.y,TLineTwoBegin.z,TLineTwoEnd.x,TLineTwoEnd.y,TLineTwoEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(TLineThreeBegin.x,TLineThreeBegin.y,TLineThreeBegin.z,TLineThreeEnd.x,TLineThreeEnd.y,TLineThreeEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(TLineThreeEnd.x,TLineThreeEnd.y,TLineThreeEnd.z,TLineFourBegin.x,TLineFourBegin.y,TLineFourBegin.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(ConnectorOneBegin.x,ConnectorOneBegin.y,ConnectorOneBegin.z,ConnectorOneEnd.x,ConnectorOneEnd.y,ConnectorOneEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(ConnectorTwoBegin.x,ConnectorTwoBegin.y,ConnectorTwoBegin.z,ConnectorTwoEnd.x,ConnectorTwoEnd.y,ConnectorTwoEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(ConnectorThreeBegin.x,ConnectorThreeBegin.y,ConnectorThreeBegin.z,ConnectorThreeEnd.x,ConnectorThreeEnd.y,ConnectorThreeEnd.z,ra.r,ra.g,ra.b,255)
                                    DrawLine(ConnectorFourBegin.x,ConnectorFourBegin.y,ConnectorFourBegin.z,ConnectorFourEnd.x,ConnectorFourEnd.y,ConnectorFourEnd.z,ra.r,ra.g,ra.b,255)
                            end
                            if esplines and esp then
                                    DrawLine(cx, cy, cz, x, y, z, ra.r, ra.g, ra.b, 255)
                            end
                    end
                    end
                    end
            if showCoords then
                    x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
                    roundx = tonumber(string.format("%.2f", x))
                    roundy = tonumber(string.format("%.2f", y))
                    roundz = tonumber(string.format("%.2f", z))
                    DrawTxt("~r~X:~s~ "..roundx, 0.05, 0.00)
                    DrawTxt("~r~Y:~s~ "..roundy, 0.11, 0.00)
                    DrawTxt("~r~Z:~s~ "..roundz, 0.17, 0.00)
            end
            if Noclip then
                    local ped = PlayerPedId()
                    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
                    local dx,dy,dz = getCamDirection()
                    local speed = 3
                    SetEntityVisible(PlayerPedId(), false, false)
                    SetEntityInvincible(PlayerPedId(), true)
                    SetEntityVisible(ped, false)
                    SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
                    if IsControlPressed(0,32) then
                            x = x+speed*dx
                            y = y+speed*dy
                            z = z+speed*dz
                    end
                    if IsControlPressed(0,269) then
                            x = x-speed*dx
                            y = y-speed*dy
                            z = z-speed*dz
                    end
                    SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
            end
            if Vanish then
                    SetEntityVisible(PlayerPedId(), false, false)
                    SetEntityInvincible(PlayerPedId(), true)
                    SetEntityVisible(ped, false)
            end
            if VehGod and IsPedInAnyVehicle(PlayerPedId(), true) then
                    SetEntityInvincible(GetVehiclePedIsUsing(PlayerPedId()), true)
            end
            if GodModes then
                    local player = PlayerPedId()
                    SetEntityInvincible(player, true)
                    SetPlayerInvincible(PlayerId(), true)
                    SetPedCanRagdoll(player, false)
                    ClearPedBloodDamage(player)
                    ResetPedVisibleDamage(player)
                    ClearPedLastWeaponDamage(player)
                    SetEntityProofs(player, true, true, true, true, true, true, true, true)
                    SetEntityOnlyDamagedByPlayer(player, false)
                    SetEntityCanBeDamaged(player, false)
            else
                    local player = PlayerPedId()
                    SetEntityInvincible(player, false)
                    SetPlayerInvincible(PlayerId(), false)
                    SetPedCanRagdoll(player, true)
                    ClearPedBloodDamage(player)
                    ResetPedVisibleDamage(player)
                    ClearPedLastWeaponDamage(player)
                    SetEntityProofs(player, false, false, false, false, false, false, false, false)
                    SetEntityOnlyDamagedByPlayer(player, false)
                    SetEntityCanBeDamaged(player, true)
            end
    end
end)
RegisterNetEvent('Hostete-AC:nocliped')
AddEventHandler('Hostete-AC:nocliped',function()
    local ped = PlayerPedId()
    noclip = not noclip
    if noclip then
            SetEntityInvincible(ped, true)
            SetEntityVisible(ped, false, false)
            notify(_U('acnoclip'), true)
    else
            SetEntityInvincible(ped, false)
            SetEntityVisible(ped, true, false)
            notify(_U('ofnoclip'), true)
    end
end)
RegisterNetEvent('Hostete-AC:vanished')
AddEventHandler('Hostete-AC:vanished',function()
    local ped = PlayerPedId()
    vanish = not vanish
    SetEntityVisible(ped, not vanish, false)
    if vanish then
            notify(_U('acvanish'), true)
    else
            notify(_U('ofvanish'), true)
    end
end)
function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)
    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
            x = x/len
            y = y/len
            z = z/len
    end
    return x,y,z
end
local SelectedName = ""
local SelectedPlayerSid = 0
local lastEnabled = false
RegisterNetEvent("HSTETE:listadoPlayersC")
AddEventHandler("HSTETE:listadoPlayersC", function(players)
    playerlist = players
end)
local _cgpc = 0
local _getCoords = {}
RegisterNetEvent("_SendPos")
AddEventHandler("_SendPos", function(d, n)
            _getCoords[tostring(n)] = {recv = true, coords = d}
end)
local function GetPlayerCoords(psid, cb)
    _cgpc = _cgpc + 1
    local me = _cgpc
    TriggerServerEvent("_GetCoords", psid, me)
    while _getCoords[tostring(me)] == nil do
                    Wait(10)
    end
    local c = _getCoords[tostring(me)].coords
    _getCoords[tostring(me)] = nill
    cb(c)
end
local Spectating = false
local cam = nil
local polarAngleDeg = 0
local azimuthAngleDeg = 90
local radius = -3.5
local LastPosition = nil
local function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
    local polarAngleRad = polarAngleDeg * math.pi / 180.0
    local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0
    local pos = {
            x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
            y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
            z = entityPosition.z - radius * math.cos(azimuthAngleRad)
    }
    return pos
end
local function ResetNormalCamera()
    local playerPed = PlayerPedId()
    SetCamActive(cam, false)
    RenderScriptCams(false, false, 0, true, true)
    SetEntityCollision(playerPed, true, true)
    SetEntityVisible(playerPed, true)
    SetEntityCoords(playerPed, LastPosition.x, LastPosition.y, LastPosition.z)
end
local function SpectatePlayer(serverId)
    local playerPed = PlayerPedId()
    Spectating = not Spectating
    if Spectating then
            LastPosition = GetEntityCoords(playerPed)
            if not DoesCamExist(cam) then cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true) end
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, true)
            Citizen.CreateThread(function()
                    GetPlayerCoords(serverId, function(coords)
                            if coords ~= nil then
                                    SetEntityCollision(playerPed, false, false)
                                    SetEntityVisible(playerPed, false)
                                    SetEntityCoords(playerPed, coords.x, coords.y, coords.z + 10)
                                    SetCamCoord(cam, coords.x, coords.y, coords.z)
                                    local targetPed = nil
                                    while Spectating do
                                            Wait(0)
                                            playerPed = PlayerPedId()
                                            targetPed = GetPlayerPed(GetPlayerFromServerId(serverId))
                                            local coords = GetEntityCoords(targetPed)
                                            local dist = #(coords - GetEntityCoords(playerPed))
                                            if dist <= 5 then
                                                    Wait(500)
                                                    GetPlayerCoords(serverId, function(c)
                                                            coords = c
                                                    end)
                                            else
                                                    NetworkSetInSpectatorMode(true, targetPed)
                                            end
                                            for _, player in ipairs(GetActivePlayers()) do if player ~= PlayerId() then SetEntityNoCollisionEntity(playerPed, GetPlayerPed(player), true) SetEntityVisible(playerPed, false) end end
                                            if IsControlPressed(2, 241) then radius = radius + 2.0 end
                                            if IsControlPressed(2, 242) then radius = radius - 2.0 end
                                            if radius > -1 then radius = -1 end
                                            local xMagnitude = GetDisabledControlNormal(0, 1)
                                            local yMagnitude = GetDisabledControlNormal(0, 2)
                                            polarAngleDeg = polarAngleDeg + xMagnitude * 10
                                            if polarAngleDeg >= 360 then polarAngleDeg = 0 end
                                            azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10
                                            if azimuthAngleDeg >= 360 then azimuthAngleDeg = 0 end
                                            local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)
                                            SetCamCoord(cam, nextCamLocation.x, nextCamLocation.y, nextCamLocation.z)
                                            PointCamAtEntity(cam, targetPed)
                                            SetEntityCoords(playerPed, coords.x, coords.y, coords.z + 10)
                                    end
                                    NetworkSetInSpectatorMode(false, targetPed)
                                    ResetNormalCamera()
                            end
                    end)
            end)
    end
end
Citizen.CreateThread(function()
    local lastPos = nil
    while true do
                    Wait(2000)
                    local pos = GetEntityCoords(PlayerPedId(), true)
                    if lastPos == nil or (#(lastPos - pos) > 2) then
                                    lastPos = pos
                                    TriggerServerEvent("_UpdatePos", pos)
                    end
    end
end)

if Config.AntiPedAttack then
    Citizen.CreateThread(function()
            local lastPos = nill
            while true do
                    Wait(1000)
                    local handle, ped = FindFirstPed()
                    local finished = false
                    repeat
                            Citizen.Wait(20)
                            if not IsPedAPlayer(ped) then
                                    if (IsPedArmed(ped) or IsPedInMeleeCombat(ped) or IsPedInCombat(ped)) then
                                            if NetworkGetEntityIsNetworked(ped) then
                                                    NetworkRequestControlOfEntity(ped)
                                                    RemoveAllPedWeapons(ped, true)
                                                    ClearPedTasks(ped)
                                                    SetEntityInvincible(ped, false)
                                                    SetPedMaxHealth(ped, 200)
                                                    ApplyDamageToPed(ped, 10000, false)
                                                    NetWorkDelete(ped)
                                            else
                                                    RemoveAllPedWeapons(ped, true)
                                                    ClearPedTasks(ped)
                                                    SetEntityInvincible(ped, false)
                                                    SetPedMaxHealth(ped, 200)
                                                    ApplyDamageToPed(ped, 10000, false)
                                                    SetEntityAsMissionEntity(ped, false, false)
                                                    DeleteEntity(ped)
                                            end
                                    end
                            end
                            finished, ped = FindNextPed(handle)
                    until not finished
                    EndFindPed(handle)
            end
    end)
end

if Config.PlayerProtection then
    Citizen.CreateThread(function()
            local lastGoodHealth = 200
            while true do
                    local Player = PlayerPedId()
                    SetExplosiveAmmoThisFrame(Player, 0)
                    SetExplosiveMeleeThisFrame(Player, 0)
                    SetFireAmmoThisFrame(Player, 0)
                    SetEntityProofs(Player, false, true, true, false, false, false, false, false)
                    SetPedInfiniteAmmoClip(PlayerPedId(), false)
                    Citizen.Wait(0)
                    if IsEntityOnFire(PlayerPedId()) then
                            StopEntityFire(PlayerPedId())
                            SetEntityHealth(PlayerPedId(), lastGoodHealth)
                    else
                                    lastGoodHealth = GetEntityHealth(PlayerPedId())
                    end
            end
    end)
end

Citizen.CreateThread(function()
while true do
Citizen.Wait(6)
local ped = PlayerPedId()
local handle,entity = FindFirstObject()
local finished = false
repeat
    Citizen.Wait(1)
                if GetEntityPopulationType(entity) ~= 0 then
                        if IsEntityAttached(entity) and DoesEntityExist(entity) then
                                ReqAndDelete(entity,true)
                        end
                end
    finished,entity = FindNextObject(handle)
until not finished
EndFindObject(handle)
end
end)

function ReqAndDelete(entity,detach)
if DoesEntityExist(entity) then
NetworkRequestControlOfEntity(entity)
while not NetworkHasControlOfEntity(entity) do
    Citizen.Wait(10)
end

if detach then
    DetachEntity(entity,0,false)
end

SetEntityCollision(entity,false,false)
SetEntityAlpha(entity,0.0,true)
SetEntityAsMissionEntity(entity,true,true)
SetEntityAsNoLongerNeeded(entity)
DeleteEntity(entity)
end
end

if Config.AntiACBypass then
    Citizen.CreateThread(function()
            while true do
                    Citizen.Wait(1000)
                    if _G == nil or _G == {} or _G == "" then
                            TriggerServerEvent('HSTETE:ban', 'Anti-Bypass! ')
                            return
                    else
                            Wait(800)
                    end
            end
    end)
end
if Config.DeleteBrokenCars then
    AddEventHandler("gameEventTriggered", function(name, args)
            if name == "CEventNetworkVehicleUndrivable" then
                            local entity, destoyer, weapon = table.unpack(args)
                            if not IsPedAPlayer(GetPedInVehicleSeat(entity, -1)) then
                            if NetworkGetEntityIsNetworked(entity) then
                                    NetWorkDelete(entity)
                            else
                                    SetEntityAsMissionEntity(entity, false, false)
                                    DeleteEntity(entity)
                            end
                    end
            end
    end)
end
if Config.AntiTeleport then
Citizen.CreateThread(function()
    Citizen.Wait(60000)
    while true do
        Citizen.Wait(830)
        local ped = PlayerPedId()
        local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
        local still = IsPedStill(ped)
        local vel = GetEntitySpeed(ped)
        local ped = PlayerPedId()
        local veh = IsPedInAnyVehicle(ped, true)
        local speed = GetEntitySpeed(ped)
        local para = GetPedParachuteState(ped)
        local flyveh = IsPedInFlyingVehicle(ped)
        local jumping = IsPedJumping(ped)   
        local rag = IsPedRagdoll(ped)
        local fall = IsPedFalling(ped)
        local parafall = IsPedInParachuteFreeFall(ped)
        SetEntityVisible(PlayerPedId(), true)
        Wait(830)
        local more = speed - 8.0
        local rounds = tonumber(string.format("%.2f", speed))
        local roundm = tonumber(string.format("%.2f", more))
        if not IsEntityVisible(PlayerPedId()) then
            SetEntityHealth(PlayerPedId(), -100)
        end
        newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
        newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
        if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 1 and not rag and not fall and not jumping and not parafall and not veh and not flyveh and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
            TriggerServerEvent('HSTETE:ban', 'Anti Teleport or Noclip! ')
        end
    end
end)
end
local checkmenyo = false
AddEventHandler("playerSpawned", function()
    checkmenyo = true
end)
Citizen.CreateThread(function()
while true do
        if Config.AntiMenyoo and checkmenyo == true then
                Citizen.Wait(900)
                if IsPlayerCamControlDisabled() ~= false then
                        TriggerServerEvent('HSTETE:ban', 'Anti Menyoo! ')
                end
        end
        if Config.AntiSpectate then
                Citizen.Wait(800)
                if NetworkIsInSpectatorMode() then
                        TriggerServerEvent('HSTETE:ban', 'Anti Spectate! ')
                end
        end
        if Config.AntiSpeed then
                Citizen.Wait(800)
                local ped = PlayerPedId()
                local speed = GetEntitySpeed(ped)
                local still = IsPedStill(ped)
                local runing = IsPedRunning(ped)   
                local jumping = IsPedJumping(PlayerPedId())   
                local falling = IsPedFalling(ped)   
                local parafall = IsPedInParachuteFreeFall(ped)
                local rag = IsPedRagdoll(ped)
                newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
                if runing then 
                        if still == IsPedStill(ped) and ped == newPed and not jumping and not falling and not parafall and not rag and runing and speed > 7 then
                        TriggerServerEvent('HSTETE:ban', 'Anti SpeedHack! ')
                        end
                end
        end    
        if Config.AntiCheatEngine then
                Citizen.Wait(1000)
                local _veh = GetVehiclePedIsUsing(_ped)
                local _model = GetEntityModel(_veh)
                    if IsPedSittingInAnyVehicle(_ped) then
                        if _veh == model1 and _model ~= model2 and model2 ~= nil and model2 ~= 0 then
                            DeleteVehicle(_veh)
                            TriggerServerEvent('HSTETE:ban', 'Cheat Engine Vehicle Hash Changer ') -- BAN (CHEAT ENGINE)
                            return
                        end
                    end
                model1 = _veh
                model2 = _model
         end
end
end)

if Config.AntiBlips then
    Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1000)
            local xYVhjptuuo = 0
            local zz6LpCacIYeVdF = GetActivePlayers()
            for i = 1, #zz6LpCacIYeVdF do
                    if i ~= PlayerId() then
                            if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
                                            xYVhjptuuo = xYVhjptuuo + 1
                                    end
                            end
                            if xYVhjptuuo > 0 then
                                    TriggerServerEvent('HSTETE:ban', 'AntiBlips')
                            end
                    end
            end
    end)
end

if Config.AntiPedCrasher then
if Config.AntiProjectile then
        Citizen.CreateThread(function ()
                while true do
                        Citizen.Wait(0)
                        local xpos = 0.0
                        local ypos = 0.0
                        local zpos = 0.0
                        local radio = 5000000000000.0
                        RemoveParticleFxInRange(xpos, ypos, zpos, radio)
                end
        end)
end

Citizen.CreateThread(function()
        while true do
                Citizen.Wait(1000)
                local juga = PlayerPedId()
                local TKgk2NP = GetVehiclePedIsUsing(juga)
                if TKgk2NP ~= 0 then
                        RemovePedHelmet(juga, true)
                end
        end
end)
end   

if Config.AntiSuperJump then
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(810)
            if IsPedJumping(PlayerPedId()) then
            local firstCoord = GetEntityCoords(PlayerPedId())
            while IsPedJumping(PlayerPedId()) do
                Citizen.Wait(810)
            end
            local secondCoord = GetEntityCoords(PlayerPedId())
            local jumplength = GetDistanceBetweenCoords(firstCoord, secondCoord, false)
            if jumplength > 25 then
                TriggerServerEvent("HSTETE:ban", "SuperJump Detected")

            end
        end
    end
end)
end    

if Config.AntiWeaponDMGModifier then

Citizen.CreateThread(function()
        while true do
        Citizen.Wait(2000)
                local weaponHash = GetSelectedPedWeapon(PlayerPedId())
                local IdPlayer = PlayerId()
                local weaponDamageModifier = GetPlayerWeaponDamageModifier(IdPlayer)
                if weaponDamageModifier ~= 0.0 and weaponDamageModifier > 1.0 then
                        TriggerServerEvent("HSTETE:ban", "Tried to change weapon damage modifier")
                end

                local WeaponDefenceModifier = GetPlayerWeaponDefenseModifier(IdPlayer)
                if WeaponDefenceModifier ~= 0.0 and WeaponDefenceModifier > 1.0 then
                        TriggerServerEvent("HSTETE:ban", "Tried to change weapon defence modifier")
                end

                local WeaponDefenceModifier2 = GetPlayerWeaponDefenseModifier_2(IdPlayer)
                if WeaponDefenceModifier2 ~= 0.0 and WeaponDefenceModifier2 > 1.0 then
                        TriggerServerEvent("HSTETE:ban", "Tried to change weapon defence modifier2")
                end

                local VehicleDamageModifier = GetPlayerVehicleDamageModifier(IdPlayer)
                if VehicleDamageModifier ~= 0.0 and VehicleDamageModifier > 1.0 then
                        TriggerServerEvent("HSTETE:ban", "Tried to change vehicle damage modifier")
                end

                local VehicleDefenceModifier = GetPlayerVehicleDefenseModifier(IdPlayer)
                if VehicleDefenceModifier ~= 0.0 and VehicleDefenceModifier > 1.0 then
                        TriggerServerEvent("HSTETE:ban", "Tried to change vehicle defence modifier")

                end

                local MeleeDefenceModifier = GetPlayerMeleeWeaponDefenseModifier(IdPlayer)
                if VehicleDefenceModifier ~= 0.0 and MeleeDefenceModifier > 1.0 then
                        TriggerServerEvent("HSTETE:ban", "Tried to change melee defence modifier")
                end

                local wgroup = GetWeapontypeGroup(weaponHash)
                local dmgt = GetWeaponDamageType(weaponHash)
                if wgroup == -1609580060 or wgroup == -728555052 or weaponHash == -1569615261 then
                        if dmgt ~= 2 then
                                TriggerServerEvent("HSTETE:ban", "Tried to use explosive melee")
                        end
                elseif wgroup == 416676503 or wgroup == -957766203 or wgroup == 860033945 or wgroup == 970310034 or wgroup == -1212426201 then
                        if dmgt ~= 3 then
                                TriggerServerEvent("HSTETE:ban", "Tried to use explosive weapon")
                        end
                end
        end
end)

end    
Citizen.CreateThread(function()
            local showblip = false
            HSTETE.CreateMenu(HSTETEs, titulo)
            HSTETE.CreateSubMenu(sMX, HSTETEs, welcome)
            HSTETE.CreateSubMenu(TRPM, HSTETEs, welcome)
            HSTETE.CreateSubMenu(advm, HSTETEs, welcome)
            HSTETE.CreateSubMenu(VMS, HSTETEs, welcome)
            HSTETE.CreateSubMenu(OPMS, HSTETEs, welcome)
            HSTETE.CreateSubMenu(poms, OPMS, welcome)
            HSTETE.CreateSubMenu(crds, HSTETEs, welcome)
            HSTETE.CreateSubMenu(espa, sMX, welcome)
            while Enabled do
                    local IsEnabled = HSTETE.IsMenuOpened(OPMS)
                    if IsEnabled ~= lastEnabled then
                            lastEnabled = IsEnabled
                            if IsEnabled then
                                    playerlist = nil
                                    TriggerServerEvent("HSTETE:listadoPlayers")
                                    repeat
                                            Wait(100)
                                    until playerlist
                            end
                    end
                    if HSTETE.IsMenuOpened(HSTETEs) then
                            notify(welcome, false)
                            if HSTETE.MenuButton(_U('onplayers'), OPMS) then
                            elseif HSTETE.MenuButton(_U('opveh'), VMS) then
                            elseif HSTETE.MenuButton(_U('optp'), TRPM) then
                            elseif HSTETE.MenuButton(_U('opadmin'), sMX) then
                        end
                            HSTETE.Display()
                    elseif HSTETE.IsMenuOpened(sMX) then
                            if HSTETE.MenuButton("> ESP Menu", espa) then
                            elseif HSTETE.MenuButton(_U('srvertool'), advm) then
                            elseif HSTETE.CheckBox("👻 | Noclip",Noclip,function(enabled)Noclip = enabled end) then
                                    TriggerEvent('Hostete-AC:nocliped','noclip')
                            elseif HSTETE.Button(_U('sendads')) then
                                    local msg2 = KeyboardInput(_U('intromsg'), "", 100)
                                    TriggerServerEvent('Hostete-AC:Anuncios', msg2)
                            elseif HSTETE.Button(_U('revive')) then
                                local target = GetPlayerServerId(selectedplayer)
                                TriggerEvent('esx_ambulancejob:revive', target)                              
                            elseif HSTETE.CheckBox(_U('guante'),DeleteGun, function(enabled)DeleteGun = enabled end)  then
                            elseif HSTETE.CheckBox(_U('vanished'),Vanish,function(enabled)Vanish = enabled end) then
                                    TriggerEvent('Hostete-AC:vanished','vanish')
                            elseif HSTETE.CheckBox(_U('god'),GodModes,function(enabled)GodModes = enabled end) then
                            elseif HSTETE.Button(_U('givear')) then
                                    for i = 1, #bn do
                                    GiveWeaponToPed(PlayerPedId(), GetHashKey(bn[i]), 1000, false, false)
                                    end
                            elseif HSTETE.Button(_U('rear')) then
                                            RemoveAllPedWeapons(PlayerPedId(), true)
                            end
                            HSTETE.Display()
                    elseif HSTETE.IsMenuOpened(OPMS) then
                            players = {}
                            local localplayers = playerlist
                            local temp = {}
                            for i,thePlayer in pairs(localplayers) do
                                    table.insert(temp, thePlayer.id)
                            end
                            table.sort(temp)
                            for i, thePlayerId in pairs(temp) do
                                    for _, thePlayer in pairs(localplayers) do
                                            if thePlayerId == thePlayer.id then
                                                    players[i] = thePlayer
                                            end
                                    end
                            end
                            temp = nil
                            for i, thePlayer in pairs(players) do
                                    if HSTETE.MenuButton("ID: ~y~["..thePlayer.id.."] ~s~"..thePlayer.name, 'PlayerOptionsMenu') then
                                            SelectedPlayerSid = thePlayer.id
                                            SelectedName = thePlayer.name
                                    end
                            end
                            HSTETE.Display()
                    elseif HSTETE.IsMenuOpened(poms) then
                            HSTETE.SetSubTitle(poms, _U('opplayer').."[" .. SelectedName .. "]")
                            if HSTETE.Button(_U('spectate'), (Spectating and _U('spectating'))) then
                                    SpectatePlayer(SelectedPlayerSid)
                            elseif HSTETE.Button(_U('tpplayer')) then
                                    GetPlayerCoords(SelectedPlayerSid, function(coords)
                                            if coords ~= nil then
                                                    local Entity = IsPedInAnyVehicle(PlayerPedId(), false) and GetVehiclePedIsUsing(PlayerPedId()) or PlayerPedId()
                                                    SetEntityCoords(Entity, coords.x,coords.y,coords.z, 0.0, 0.0, 0.0, false)
                                            end
                                    end)
                            elseif HSTETE.Button(_U('tpmeplayer')) then
                                    local ped = PlayerPedId()
                                    local x,y,z = table.unpack(GetEntityCoords(ped))
                                    TriggerServerEvent('tpmePlayerS', SelectedPlayerSid, x, y, z)
                            elseif HSTETE.Button(_U('frezzeplayer')) then
                                    TriggerServerEvent('congelarPlayerS', SelectedPlayerSid)
                            elseif HSTETE.Button("👋 | Kick") then
                                    local msg = KeyboardInput("Introduzca el motivo del KICK", "", 100)
                                    DropPlayer(SelectedPlayerSid, msg)
                            elseif HSTETE.Button(_U('banbyac').."~w~Five~r~MW~w~all") then
                                TriggerServerEvent('HSTETE:ban2', _U('banmenu'), SelectedPlayerSid)
                        elseif HSTETE.Button(_U('givecar')) then
                                    local ModelName = KeyboardInput(_U('intrcarname'), "", 100)
                                    if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                                            RequestModel(ModelName)
                                            while not HasModelLoaded(ModelName) do
                                                    Citizen.Wait(0)
                                            end
                                            GetPlayerCoords(SelectedPlayerSid, function(coords)
                                                    if coords ~= nil then
                                                            local ped = PlayerPedId()
                                                            local original = GetEntityCoords(ped)
                                                            SetEntityCoords(ped, coords.x,coords.y,coords.z + 50, 0.0, 0.0, 0.0, false)
                                                            Wait(400)
                                                            CreateVehicle(GetHashKey(ModelName), coords.x,coords.y,coords.z, 0, true, true)
                                                            Wait(200)
                                                            SetEntityCoords(ped, original, 0.0, 0.0, 0.0, false)
                                                    end
                                            end)
                                            else
                                            notify(_U('novalidname'), true)
                            end
                    end
                            HSTETE.Display()
                    elseif IsDisabledControlPressed(0, 244)  then
                            TSE('Hostete-AC:openmenu')
                            HSTETE.Display()
                    elseif HSTETE.IsMenuOpened(TRPM) then
                            if HSTETE.Button(_U('tppoint')) then
                                    TeleportToWaypoint()
                            elseif HSTETE.Button(_U('tpcoords')) then
                                    teleporttocoords()
                            elseif HSTETE.CheckBox(_U('viewcoords'), showCoords, function (enabled) showCoords = enabled end) then
                    end
                            HSTETE.Display()
                    elseif HSTETE.IsMenuOpened(VMS) then
                            if HSTETE.Button(_U('cargive')) then
                                    spawnvehicle()
                            elseif HSTETE.Button(_U('dvcar')) then
                                    local coche = GetVehiclePedIsIn(PlayerPedId(), false)
                                    if NetworkGetEntityIsNetworked(coche) then

                                            NetWorkDelete(coche)
                                    else
                                            SetEntityAsMissionEntity(coche, true, true )
                                            DeleteEntity(coche)
                                    end
                            elseif HSTETE.Button(_U('fixcar')) then
                                    repairvehicle()
                            elseif HSTETE.CheckBox(_U('godcar'), VehGod, function(enabled) VehGod = enabled end)then
                    end
            HSTETE.Display()
            elseif HSTETE.IsMenuOpened(advm) then
                    if HSTETE.Button(_U('eliminar'),_U('elimicar')) then
                            TSE("Hostete-AC:cleanareaveh")
                    elseif HSTETE.Button(_U('eliminar'),_U('eliminobj')) then
                            TSE("Hostete-AC:cleanareaentity")
                    elseif HSTETE.Button(_U('eliminar'),_U('elmimiped')) then
                            TSE("Hostete-AC:cleanareapeds")
                    elseif HSTETE.Button(_U('eliminar'),_U('netelimiobj')) then
                            TSE("Hostete-AC:networkingobjetos")

            end
            HSTETE.Display()
    elseif HSTETE.IsMenuOpened(espa) then
    if HSTETE.CheckBox("- ESP ~s~MasterSwitch", esp, function(enabled) esp = enabled end) then
    elseif HSTETE.CheckBox(_U('espname'), nameabove, function(enabled) nameabove = enabled end) then
    elseif HSTETE.CheckBox(_U('espcaja'), espbox, function(enabled) espbox = enabled end) then
    elseif HSTETE.CheckBox(_U('espinfo'), espinfo, function(enabled) espinfo = enabled end) then
    elseif HSTETE.CheckBox(_U('esplineas'), esplines, function(enabled) esplines = enabled end) then
    end
    HSTETE.Display()
            end
            Citizen.Wait(0)
    end
end)
announcestring = false
lastfor = 5
RegisterNetEvent('announce')
announcestring = false
AddEventHandler('announce', function(msg)
    announcestring = msg
    PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
    Citizen.Wait(lastfor * 1000)
    announcestring = false
end)
function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
            PushScaleformMovieFunctionParameterString(_U('anuncioimp'))
    PushScaleformMovieFunctionParameterString(announcestring)
    PopScaleformMovieFunctionVoid()
    return scaleform
end
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
            if announcestring then
                    scaleform = Initialize("mp_big_message_freemode")
                    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            end
    end
end)
RegisterNetEvent("Hostete-AC:cleanareavehy")
AddEventHandler("Hostete-AC:cleanareavehy", function()
    local vehs = GetGamePool('CVehicle')
    for _, vehicle in ipairs(vehs) do
            if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                    if NetworkGetEntityIsNetworked(vehicle) then
                            NetWorkDelete(vehicle)
                    else
                            SetVehicleHasBeenOwnedByPlayer(vehicle, false)
                            SetEntityAsMissionEntity(vehicle, true, true)
                            DeleteEntity(vehicle)
                    end
            end
    end
end)
RegisterNetEvent("Hostete-AC:cleanareapedsy")
AddEventHandler("Hostete-AC:cleanareapedsy", function()
    local peds = GetGamePool('CPed')
    for _, ped in ipairs(peds) do
            if not (IsPedAPlayer(ped)) then
                    RemoveAllPedWeapons(ped, true)
                    if NetworkGetEntityIsNetworked(ped) then
                            NetWorkDelete(ped)
                    else
                            DeleteEntity(ped)
                    end
            end
    end
end)
RegisterNetEvent("Hostete-AC:networkingobjetos2")
AddEventHandler("Hostete-AC:networkingobjetos2", function()
    local objs = GetGamePool('CObject')
    for _, obj in ipairs(objs) do
            NetWorkDelete(obj)
    end
end)
RegisterNetEvent("Hostete-AC:cleanareaentityy")
AddEventHandler("Hostete-AC:cleanareaentityy", function()
    local objs = GetGamePool('CObject')
    for _, obj in ipairs(objs) do
            if NetworkGetEntityIsNetworked(obj) then
                    NetWorkDelete(obj)
            else
                    DeleteEntity(obj)
            end
    end
end)
RegisterNetEvent("congelarPlayerC")
AddEventHandler("congelarPlayerC", function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
            local coche = GetVehiclePedIsIn(ped, false)
            congeladoCoche = not congeladoCoche
            if congeladoCoche then
                    FreezeEntityPosition(coche, true)
            else
                    FreezeEntityPosition(coche, false)
            end
    else
            congelado = not congelado
            if congelado then
                    FreezeEntityPosition(ped, true)
            else
                    FreezeEntityPosition(ped, false)
            end
    end
end)
RegisterNetEvent("tpmePlayerC")
AddEventHandler("tpmePlayerC", function(x, y, z)
    local ped = PlayerPedId()
    SetPedCoordsKeepVehicle(ped, x+0.0001, y+0.0001, z+0.0001)
end)
RegisterNetEvent("Hostete-AC:openmenu")
AddEventHandler("Hostete-AC:openmenu", function()
    HSTETE.OpenMenu(HSTETEs)
end)
