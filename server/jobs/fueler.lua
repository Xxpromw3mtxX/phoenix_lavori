local playersProcessingOil = {}

RegisterServerEvent('phoenix_lavori:pickedUpOil')
AddEventHandler('phoenix_lavori:pickedUpOil', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	ESX.SetTimeout(Config.Delays.OilPickUp, function()
		if xPlayer.canCarryItem('petrol', 10) then
			xPlayer.addInventoryItem('petrol', 10)
		end
	end)
end)

RegisterServerEvent('phoenix_lavori:ProcessOil')
AddEventHandler('phoenix_lavori:ProcessOil', function()
	if not playersProcessingOil[source] then
		local _source = source

		playersProcessingOil[_source] = ESX.SetTimeout(Config.Delays.OilProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xPetrol = xPlayer.getInventoryItem('petrol')

			if xPetrol.count >= 10 then
				if xPlayer.canSwapItem('petrol', 10, 'essence', 10) then
					xPlayer.removeInventoryItem('petrol', 10)
					xPlayer.addInventoryItem('essence', 10)    
				else
					xPlayer.showNotification(_U('processingfull'))
				end
			else
				xPlayer.showNotification(_U('processingenough'))
			end

			playersProcessingOil[_source] = nil
		end)
	else
		print(('phoenix_lavori: %s attempted to exploit Oil processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingOil[playerID] then
		ESX.ClearTimeout(playersProcessingOil[playerID])
		playersProcessingOil[playerID] = nil
	end
end

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)