VORP = exports.vorp_core:vorpAPI()

RegisterServerEvent('vorp_loot')
AddEventHandler('vorp_loot', function(price,xp)
    local _source = source
    local _price = tonumber(price)
	local _xp = tonumber(xp)
    TriggerEvent("vorp:getCharacter",source,function(user)
        VORP.addMoney(_source, 0, _price)
        VORP.addXp(_source, _xp)
    end)
end)