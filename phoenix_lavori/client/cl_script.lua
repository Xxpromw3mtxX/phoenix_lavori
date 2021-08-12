ESX = nil
local HasAlreadyEnteredMarker = false
local onDuty = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Cloakroom menu
function OpenCloakroomMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title = _U('cloakroom'),
		align = 'top-left',
		elements = {
			{label = _U('work_clothes'), value = 'job_wear'},
			{label = _U('citizen_wear'), value = 'citizen_wear'},
			{label = _U('work_vehicle'), value = 'work_vehicle'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
			onDuty = false
			if CurrentActionData.station == 'Miner' then
				RemoveBlip(blip1)
			elseif CurrentActionData.station == 'Slaughterer' then
				RemoveBlip(blip2)
			elseif CurrentActionData.station == 'Fueler' then
				RemoveBlip(blip3)
			end
		elseif data.current.value == 'work_vehicle' then
			if onDuty then
				if CurrentActionData.station == 'Miner' then
					spawnVeh(CurrentActionData.VehModel, CurrentActionData.VehSpawnPoint, CurrentActionData.VehHeading)
				elseif CurrentActionData.station == 'Slaughterer' then
					spawnVeh(CurrentActionData.VehModel, CurrentActionData.VehSpawnPoint, CurrentActionData.VehHeading)
				elseif CurrentActionData.station == 'Fueler' then
					spawnVeh(CurrentActionData.VehModel, CurrentActionData.VehSpawnPoint, CurrentActionData.VehHeading)
				end
			else
				TriggerEvent('mythic_notify:client:SendAlert', {type = 'inform', text = 'Prima di prendere il veicolo indossa i vestiti da lavoro!', length = 2500})
			end
		elseif data.current.value == 'job_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, CurrentActionData.MaleSkin)
				else
					TriggerEvent('skinchanger:loadClothes', skin, CurrentActionData.FemaleSkin)
				end
			end)
			onDuty = true
			workingBlip(CurrentActionData.station)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

-- Vehicle spawn function
function spawnVeh(model, coords, heading)
	local playerPed = GetPlayerPed(-1)
	ESX.Game.SpawnVehicle(model, coords, Config.heading, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	end)
end

-- Create Blip on map
Citizen.CreateThread(function()
	if Config.SetMapBlips then
		for k,zone in pairs(Config.Jobs) do
			if zone.Blip then
				CreateBlip(zone.blipCoords, zone.name, zone.radius, zone.color, zone.sprite)
			end
		end
	end
end)

-- Create Blips
function CreateBlip(coords, text, radius, color, sprite)
	if Config.SetMapBlips then
		local blip = AddBlipForRadius(coords, radius)

		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, 1)
		SetBlipAlpha (blip, 128)

		blip = AddBlipForCoord(coords)

		SetBlipHighDetail(blip, true)
		SetBlipSprite (blip, sprite)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(text)
		EndTextCommandSetBlipName(blip)
	end
end

-- Functions that handles all the secondary blip
function workingBlip(station)
	if station == 'Miner' then
		-- Miner
		local coords_mp = Config.Jobs['MinerProcess'].blipCoords
		local blip_miner_process = Config.Jobs['MinerProcess'].name
		blip1 = AddBlipForRadius(coords_mp, radius)

		SetBlipHighDetail(blip1, true)
		SetBlipColour(blip1, 1)
		SetBlipAlpha (blip1, 128)

		blip1 = AddBlipForCoord(coords_mp)
		SetBlipHighDetail(blip1, true)
		SetBlipSprite (blip1, Config.Jobs['MinerProcess'].sprite)
		SetBlipScale  (blip1, 1.0)
		SetBlipColour (blip1, Config.Jobs['MinerProcess'].color)
		SetBlipAsShortRange(blip1, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(blip_miner_process)
		EndTextCommandSetBlipName(blip1)
	elseif station == 'Slaughterer' then
		-- Slaughterer
		local coords_sp = Config.Jobs['SlaughtererProcess'].blipCoords
		local blip_Slaughterer_process = Config.Jobs['SlaughtererProcess'].name
		blip2 = AddBlipForRadius(coords_sp, radius)

		SetBlipHighDetail(blip2, true)
		SetBlipColour(blip2, 1)
		SetBlipAlpha (blip2, 128)

		blip2 = AddBlipForCoord(coords_sp)
		SetBlipHighDetail(blip2, true)
		SetBlipSprite (blip2, Config.Jobs['SlaughtererProcess'].sprite)
		SetBlipScale  (blip2, 1.0)
		SetBlipColour (blip2, Config.Jobs['SlaughtererProcess'].color)
		SetBlipAsShortRange(blip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(blip_Slaughterer_process)
		EndTextCommandSetBlipName(blip2)
	elseif station == 'Fueler' then
		-- Fueler
		local coords_fp = Config.Jobs['FuelerProcess'].blipCoords
		local blip_fueler_process = Config.Jobs['FuelerProcess'].name
		blip3 = AddBlipForRadius(coords_fp, radius)

		SetBlipHighDetail(blip3, true)
		SetBlipColour(blip3, 1)
		SetBlipAlpha (blip3, 128)

		blip3 = AddBlipForCoord(coords_fp)
		SetBlipHighDetail(blip3, true)
		SetBlipSprite (blip3, Config.Jobs['FuelerProcess'].sprite)
		SetBlipScale  (blip3, 1.0)
		SetBlipColour (blip3, Config.Jobs['FuelerProcess'].color)
		SetBlipAsShortRange(blip3, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(blip_fueler_process)
		EndTextCommandSetBlipName(blip3)		
	end
end

-- Display markers
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = GetPlayerPed(-1)
	    local pCoords = GetEntityCoords(playerPed)

        for k,zone in pairs(Config.Jobs) do
            for i=1, #zone.cloakrooms, 1 do
                if GetDistanceBetweenCoords(pCoords,  zone.cloakrooms[i].x, zone.cloakrooms[i].y,  zone.cloakrooms[i].z,  true) < Config.DrawDistance then
                    DrawMarker(Config.MarkerType, zone.cloakrooms[i].x, zone.cloakrooms[i].y, zone.cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 50, false, true, 2, false, false, false, false)   
                end
            end
			
			for i=1, #zone.processmarker, 1 do
				if GetDistanceBetweenCoords(pCoords,  zone.processmarker[i].x, zone.processmarker[i].y,  zone.processmarker[i].z,  true) < Config.DrawDistance then
					DrawMarker(Config.MarkerType, zone.processmarker[i].x, zone.processmarker[i].y, zone.processmarker[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, 255, 187, 0, 50, false, true, 2, false, false, false, false)   
				end
			end
		end
    end
end)

-- Enter / Exit marker events
AddEventHandler('phoenix_minatore:hasExitedMarker', function(station, part, partNum)
	CurrentAction = nil
end)

AddEventHandler('phoenix_minatore:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' and station == 'Miner' then
		CurrentAction = 'menu_cloakroom'
		CurrentActionMsg = _U('open_cloakroom')
		CurrentActionData = {
			MaleSkin = Config.JobClothes['Miner'].MaleSkin,
			FemaleSkin = Config.JobClothes['Miner'].FemaleSkin,
			VehModel = Config.JobVehicles['Miner'].model[math.random(1)],
			VehSpawnPoint = Config.JobVehicles['Miner'].coords,
			VehHeading = Config.JobVehicles['Miner'].heading,
			station = station
		}
	elseif part == 'Cloakroom' and station == 'Slaughterer' then
		CurrentAction = 'menu_cloakroom'
		CurrentActionMsg = _U('open_cloakroom')
		CurrentActionData = {
			MaleSkin = Config.JobClothes['Slaughterer'].MaleSkin,
			FemaleSkin = Config.JobClothes['Slaughterer'].FemaleSkin,
			VehModel = Config.JobVehicles['Slaughterer'].model[math.random(2)],
			VehSpawnPoint = Config.JobVehicles['Slaughterer'].coords,
			VehHeading = Config.JobVehicles['Slaughterer'].heading,
			station = station
		}
	elseif part == 'Cloakroom' and station == 'Fueler' then
		CurrentAction = 'menu_cloakroom'
		CurrentActionMsg = _U('open_cloakroom')
		CurrentActionData = {
			MaleSkin = Config.JobClothes['Fueler'].MaleSkin,
			FemaleSkin = Config.JobClothes['Fueler'].FemaleSkin,
			VehModel = Config.JobVehicles['Fueler'].model,
			VehSpawnPoint = Config.JobVehicles['Fueler'].coords,
			VehHeading = Config.JobVehicles['Fueler'].heading,
			station = station
		}
	end

	--[[

	if part == 'VehicleDeleter' then

		local playerPed = GetPlayerPed(-1)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle, distance = ESX.Game.GetClosestVehicle()

			if distance <= 2.0 then
				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_vehicle')
				CurrentActionData = {vehicle = vehicle}
			end
		end

	end]]
end)


Citizen.CreateThread(function()
    while true do
		Wait(0)

		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local isInMarker = false
		local currentStation = nil
		local currentPart = nil
		local currentPartNum = nil

		for k,v in pairs(Config.Jobs) do
			for i=1, #v.cloakrooms, 1 do
				if GetDistanceBetweenCoords(coords, v.cloakrooms[i].x, v.cloakrooms[i].y, v.cloakrooms[i].z, true) < Config.MarkerSize.x then
					isInMarker = true
					currentStation = k
					currentPart = 'Cloakroom'
					currentPartNum = i
				end
			end
		end

		local hasExited = false

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then
			if (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) then
				TriggerEvent('phoenix_minatore:hasExitedMarker', LastStation, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastStation = currentStation
			LastPart = currentPart
			LastPartNum  = currentPartNum
				
			TriggerEvent('phoenix_minatore:hasEnteredMarker', currentStation, currentPart, currentPartNum)
		end
		
		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			
			TriggerEvent('phoenix_minatore:hasExitedMarker', LastStation, LastPart, LastPartNum)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustPressed(0, 38) then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				end

				--[[
				if CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end
				]]

				CurrentAction = nil
			end
		end
	end
end)

