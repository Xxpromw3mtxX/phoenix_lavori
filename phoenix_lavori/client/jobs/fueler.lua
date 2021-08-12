local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

        if GetDistanceBetweenCoords(coords, Config.Jobs.Fueler.workCoords, true) < 10 then
            if not isPickingUp then
				ESX.ShowHelpNotification(_U('oil_pickupprompt'))
			end

            if IsControlJustPressed(0, 38) and not isPickingUp then
                PickUpOil()
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function PickUpOil()
	isPickingUp = true

	TriggerServerEvent('phoenix_lavori:pickedUpOil')

	--local timeLeft = Config.Delays.OilPickUp / 1000
	exports['progressBars']:startUI(Config.Delays.OilPickUp, _U('pickinup'))
	Citizen.Wait(Config.Delays.OilPickUp)
    --[[while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
	end]]
	
	isPickingUp = false
end

-- Disable some ped action
Citizen.CreateThread(function()
    while true do
        if isPickingUp or isProcessing then
            DisableControlAction(0, 32) -- W
			DisableControlAction(0, 34) -- A
			DisableControlAction(0, 31) -- S
			DisableControlAction(0, 30) -- D
			DisableControlAction(0, 22) -- Jump
			DisableControlAction(0, 44) -- Cover
            Wait(0)
        else
            Wait(250)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.Jobs.FuelerProcess.workCoords, true) < 2 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('oil_processprompt'))
			end

			if IsControlJustPressed(0, 38) and not isProcessing then
                ProcessOil()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessOil()
	isProcessing = true

	TriggerServerEvent('phoenix_lavori:ProcessOil')
	--local timeLeft = Config.Delays.OilProcessing / 1000
	exports['progressBars']:startUI(Config.Delays.OilProcessing, _U('processing'))
	Citizen.Wait(Config.Delays.OilProcessing)
	--[[while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
	end]]

	isProcessing = false
end

