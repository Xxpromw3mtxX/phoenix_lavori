Config = {}

-- Language
Config.Locale = 'it'

Config.Delays = {
    SlaughtererPickUp = 1500,
    SlaughtererProcessing = 35000
}

-- Map blips
Config.SetMapBlips = true

-- Configs
Config.DrawDistance = 100

-- Marker Settings
Config.MarkerType = 20
Config.MarkerSize = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor = {r = 50, g = 50, b = 204}

-- Job Clothes
Config.MaleSkin = {
    ["tshirt_1"] = 59,["tshirt_2"] = 0,
    ["torso_1"] = 56,["torso_2"] = 0,
    ["arms"] = 0,
    ["pants_1"] = 36, ["pants_2"] = 0,
    ["shoes_1"] = 27,["shoes_2"] = 0,
    ["helmet_1"] = 0,["helmet_2"] = 5,
    ["glasses_1"] = 15, ["glasses_2"] = 6
}

-- Job Settings
Config.Jobs = {
   -- Slaughterer
    Slaughterer = {
        workCoords = vector3(2379.3, 5053.7, 46.4),
        blipCoords = vector3(2415.5, 5004.9, 46.7),
        cloakrooms = {
            {x = 2415.5, y = 5004.9, z = 46.7}
        },
        name = _U('blip_slaughterer'),
        sprite = 78, 
        color = 35, 
        radius = 0.0,
        job = 'slaughterer',
        Blip = true
    },
    SlaughtererProcess = {
        workCoords = vector3(-97.1, 6207.1, 31),
        blipCoords = vector3(-97.1, 6207.1, 31),
        cloakrooms = {},
        name = _U('blip_slaughtererprocess'),
        sprite = 467, 
        color = 35, 
        radius = 0.0,
        Blip = false
    },
}