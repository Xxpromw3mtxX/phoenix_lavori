local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

        if GetDistanceBetweenCoords(coords, Config.Jobs.Slaughterer.workCoords, true) < 15 then
            if not isPickingUp then
				ESX.ShowHelpNotification(_U('slaughterer_pickupprompt'))
			end

            if IsControlJustPressed(0, 38) and not isPickingUp then
                PickUpPojo()
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function PickUpPojo()
	isPickingUp = true

	TriggerServerEvent('phoenix_lavori:pickedUpPojo')

	local timeLeft = Config.Delays.SlaughtererPickUp / 1000
	
    while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
	end
	
	isPickingUp = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.Jobs.SlaughtererProcess.workCoords, true) < 2 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('slaughterer_processprompt'))
			end

			if IsControlJustPressed(0, 38) and not isProcessing then
                ProcessPojo()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessPojo()
	isProcessing = true

	TriggerServerEvent('phoenix_lavori:ProcessPojo')
	local timeLeft = Config.Delays.SlaughtererProcessing / 1000
	exports['progressBars']:startUI(Config.Delays.SlaughtererProcessing, _U('processing'))
	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
	end

	isProcessing = false
end

-- Disable some ped action
Citizen.CreateThread(function()
    while true do
        if isProcessing then
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