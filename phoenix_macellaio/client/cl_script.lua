ESX = nil
local HasAlreadyEnteredMarker = false
local SlaughtererBlips = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

-- Cloakroom menu
function OpenCloakroomMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		elements = {
			{label = _U('citizen_wear'), value = 'citizen_wear'},
			{label = _U('work_clothes'), value = 'job_wear'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
			deleteBlips()
		elseif data.current.value == 'job_wear' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, Config.MaleSkin)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
			CreateBlip(Config.Jobs.SlaughtererProcess.blipCoords, Config.Jobs.SlaughtererProcess.name, Config.Jobs.SlaughtererProcess.radius, Config.Jobs.SlaughtererProcess.color, Config.Jobs.SlaughtererProcess.sprite)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function deleteBlips()
	if SlaughtererBlips[1] ~= nil then
		for i=2, #SlaughtererBlips, 1 do
			RemoveBlip(SlaughtererBlips[i])
			SlaughtererBlips[i] = nil
		end
	end
end

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
		table.insert(SlaughtererBlips, blip)
	end
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

-- Display markers
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = GetPlayerPed(-1)
	    local pCoords = GetEntityCoords(playerPed)

        for k,zone in pairs(Config.Jobs) do
            for i=1, #zone.cloakrooms, 1 do
                if GetDistanceBetweenCoords(pCoords,  zone.cloakrooms[i].x, zone.cloakrooms[i].y,  zone.cloakrooms[i].z,  true) < Config.DrawDistance then
                    DrawMarker(Config.MarkerType, zone.cloakrooms[i].x, zone.cloakrooms[i].y, zone.cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 75, false, true, 2, false, false, false, false)   
                end
            end
		end
    end
end)

-- Enter / Exit marker events
AddEventHandler('phoenix_macellaio:hasExitedMarker', function(station, part, partNum)
	CurrentAction = nil
end)

AddEventHandler('phoenix_macellaio:hasEnteredMarker', function(station, part, partNum)

	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloakroom')
		CurrentActionData = {}
	end

	--[[if part == 'VehicleSpawner' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end

	if part == 'VehicleDeleter' then

		local playerPed = GetPlayerPed(-1)

		if IsPedInAnyVehicle(playerPed,  false) then

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
				TriggerEvent('phoenix_macellaio:hasExitedMarker', LastStation, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastStation = currentStation
			LastPart = currentPart
			LastPartNum  = currentPartNum
				
			TriggerEvent('phoenix_macellaio:hasEnteredMarker', currentStation, currentPart, currentPartNum)
		end
		
		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			
			TriggerEvent('phoenix_macellaio:hasExitedMarker', LastStation, LastPart, LastPartNum)
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

				--[[if CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
				end

				if CurrentAction == 'delete_vehicle' then

					if
						GetEntityModel(vehicle) == GetHashKey('police')  or
						GetEntityModel(vehicle) == GetHashKey('police2') or
						GetEntityModel(vehicle) == GetHashKey('police3') or
						GetEntityModel(vehicle) == GetHashKey('police4') or
						GetEntityModel(vehicle) == GetHashKey('policeb') or
						GetEntityModel(vehicle) == GetHashKey('policet')
					then
						TriggerServerEvent('esx_service:disableService', 'police')
					end
					
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				if CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end]]

				CurrentAction = nil
			end
		end
	end
end)

