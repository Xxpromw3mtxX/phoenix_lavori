local isPickingUp, isProcessing = false, false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

        if GetDistanceBetweenCoords(coords, Config.Jobs.Miner.workCoords, true) < 20 then
            if not isPickingUp then
				ESX.ShowHelpNotification(_U('stone_pickupprompt'))
			end
			if IsControlPressed(0, 38) and not isPickingUp then
                PickUpStone()
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function PickUpStone()
	isPickingUp = true

    TriggerServerEvent('phoenix_lavori:pickedUpStone')

	Citizen.Wait(Config.Delays.StonePickUp)
	--[[local timeLeft = Config.Delays.StonePickUp / 1500

    while timeLeft > 0 do
		Citizen.Wait(1500)
		timeLeft = timeLeft - 1
	end]]

	isPickingUp = false
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.Jobs.MinerProcess.workCoords, true) < 2 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('stone_processprompt'))
			end

			if IsControlJustPressed(0, 38) and not isProcessing then
                ProcessStone()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessStone()
	isProcessing = true

	TriggerServerEvent('phoenix_lavori:lavaggioPietre')
	--local timeLeft = Config.Delays.StoneProcessing / 1000
	exports['progressBars']:startUI(Config.Delays.StoneProcessing, _U('processing'))
	Citizen.Wait(Config.Delays.StoneProcessing)
	--[[while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1
	end]]

	isProcessing = false
end
