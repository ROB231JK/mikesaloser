ESX = nil
PlayersData = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pixel_drugsystemV2:RequestAction')
AddEventHandler('pixel_drugsystemV2:RequestAction', function(currentZone)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.UseCoordsFromServer then
        if Zones[currentZone] == nil then
            DropPlayer(source, 'Well, not this time bro ;D')
        end
        ItemLimit = Zones[currentZone].ItemLimit
        ItemToAdd = Zones[currentZone].ItemToAdd
        ItemToRemove = Zones[currentZone].ItemToRemove
    else
        if Config.Zones[currentZone] == nil then
            DropPlayer(source, 'Well, not this time bro ;D')
        end
        ItemLimit = Config.Zones[currentZone].ItemLimit
        ItemToAdd = Config.Zones[currentZone].ItemToAdd
        ItemToRemove = Config.Zones[currentZone].ItemToRemove
    end
    if ItemLimit <= xPlayer.getInventoryItem(ItemToAdd.name).count then
        xPlayer.showNotification(Config.Text["ErrorItemLimit"])
        return
    end
    if ItemToRemove ~= nil then
        if xPlayer.getInventoryItem(ItemToRemove.name).count >= ItemToRemove.count then
            xPlayer.removeInventoryItem(ItemToRemove.name, ItemToRemove.count)
        else
            xPlayer.showNotification(Config.Text["ErrorNoItem"])
            return
        end
    end
    TriggerClientEvent('pixel_drugsystemV2:StartAction', source)
    xPlayer.addInventoryItem(ItemToAdd.name, ItemToAdd.count)
end)

RegisterServerEvent('pixel_drugsystemV2:EndAction')
AddEventHandler('pixel_drugsystemV2:EndAction', function(currentZone)
   print("dafuq")
end)

Zones = {
    ["weed1"] = {
        ["ItemToAdd"] = {
            ["name"] = "coke",
            ["count"] = 1,
        },
        ["ItemToRemove"] = nil,
        ["ItemLimit"] = 50,
        ["Coords"] = {x = -1164.82, y = -1312.88, z = 5.08},
        ["Heading"] = 61.74,
        ["TaskTime"] = 10,
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        }
    },
    
    ["weed2"] = {
        ["ItemToAdd"] = {
            ["name"] = "weed_pooch",
            ["count"] = 1
        },
        ["ItemToRemove"] = {
            ["name"] = "weed",
            ["count"] = 3
        },
        ["ItemLimit"] = 50,
        ["Coords"] = {x = 27.61, y = -1079.88, z = 38.15},
        ["Heading"] = 160.29,
        ["TaskTime"] = 10,
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        }
    },

    ["coke1"] = {
        ["ItemToAdd"] = {
            ["name"] = "coke",
            ["count"] = 1
        },
        ["ItemToRemove"] = nil,
        ["ItemLimit"] = 50,
        ["Coords"] = {x = 27.61, y = -1064.88, z = 38.15},
        ["Heading"] = 160.0,
        ["TaskTime"] = 10,
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        }
    },

    ["coke2"] = {
        ["ItemToAdd"] = {
            ["name"] = "coke_pooch",
            ["count"] = 1
        },
        ["ItemToRemove"] = {
            ["name"] = "coke",
            ["count"] = 3
        },
        ["ItemLimit"] = 50,
        ["Coords"] = {x = 25.18, y = -1071.49, z = 38.15},
        ["Heading"] = 158.0,
        ["TaskTime"] = 10,
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        }
    }
}

RegisterServerEvent('pixel_drugsystemV2:RequestZones')
AddEventHandler('pixel_drugsystemV2:RequestZones', function()
    local identifier = GetPlayerIdentifier(source, 0)
    if PlayersData[identifier] == nil then
        if Config.UseCoordsFromServer then
            PlayersData[identifier] = true
            TriggerClientEvent('pixel_drugsystemV2:GetZones', source, Zones)
        end
    else
        DropPlayer(source, "Well, not this time bro ;D")
    end
end)

AddEventHandler('playerDropped', function(reas)
    local identifier = GetPlayerIdentifier(source, 0)
    PlayersData[identifier] = nil
end)
