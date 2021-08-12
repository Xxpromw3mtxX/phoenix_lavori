local playersProcessingPojo = {}

RegisterServerEvent('phoenix_lavori:pickedUpPojo')
AddEventHandler('phoenix_lavori:pickedUpPojo', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	ESX.SetTimeout(Config.Delays.SlaughtererPickUp, function()
		if xPlayer.canCarryItem('alive_chicken', 1) then
			xPlayer.addInventoryItem('alive_chicken', 1)
		end
	end)
end)

RegisterServerEvent('phoenix_lavori:ProcessPojo')
AddEventHandler('phoenix_lavori:ProcessPojo', function()
	if not playersProcessingPojo[source] then
		local _source = source

		playersProcessingPojo[_source] = ESX.SetTimeout(Config.Delays.SlaughtererProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xPojo = xPlayer.getInventoryItem('alive_chicken')

			if xPojo.count >= 10 then
				if xPlayer.canSwapItem('alive_chicken', 10, 'packaged_chicken', 10) then
					xPlayer.removeInventoryItem('alive_chicken', 10)
					xPlayer.addInventoryItem('packaged_chicken', 10)    
				else
					xPlayer.showNotification(_U('processingfull'))
				end
			else
				xPlayer.showNotification(_U('processingenough'))
			end

			playersProcessingPojo[_source] = nil
		end)
	else
		print(('phoenix_lavori: %s attempted to exploit Pojo processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingPojo[playerID] then
		ESX.ClearTimeout(playersProcessingPojo[playerID])
		playersProcessingPojo[playerID] = nil
	end
end

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)