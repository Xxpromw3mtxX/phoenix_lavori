local playersProcessingStone = {}

RegisterServerEvent('phoenix_lavori:pickedUpStone')
AddEventHandler('phoenix_lavori:pickedUpStone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	ESX.SetTimeout(Config.Delays.StonePickUp, function()
		if xPlayer.canCarryItem('stone', 1) then
			xPlayer.addInventoryItem('stone', 1)
		end
	end)
end)

RegisterServerEvent('phoenix_lavori:lavaggioPietre')
AddEventHandler('phoenix_lavori:lavaggioPietre', function()
	if not playersProcessingStone[source] then
		local _source = source

		playersProcessingStone[_source] = ESX.SetTimeout(Config.Delays.StoneProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xStone = xPlayer.getInventoryItem('stone')

			if xStone.count >= 10 then
				if xPlayer.canSwapItem('stone', 10, 'washed_stone', 10) then
					xPlayer.removeInventoryItem('stone', 10)
					xPlayer.addInventoryItem('washed_stone', 10)    
				else
					xPlayer.showNotification(_U('processingfull'))
				end
			else
				xPlayer.showNotification(_U('processingenough'))
			end

			playersProcessingStone[_source] = nil
		end)
	else
		print(('phoenix_lavori: %s attempted to exploit stone processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingStone[playerID] then
		ESX.ClearTimeout(playersProcessingStone[playerID])
		playersProcessingStone[playerID] = nil
	end
end

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)