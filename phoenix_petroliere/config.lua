Config = {}

-- Language
Config.Locale = 'it'

Config.Delays = {
    OilPickUp = 15000,
    OilProcessing = 35000
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
    ["tshirt_1"] = 23,["tshirt_2"] = 0,
    ["torso_1"] = 12,["torso_2"] = 0,
    ["arms"] = 0,
    ["pants_1"] = 36, ["pants_2"] = 0,
    ["shoes_1"] = 27,["shoes_2"] = 0,
    ["helmet_1"] = 0,["helmet_2"] = 5,
    ["glasses_1"] = 15, ["glasses_2"] = 6
}

-- Job Settings
Config.Jobs = {
    -- Fueler
    Fueler = {
        workCoords = vector3(583.4, 2931, 40.9),
        blipCoords = vector3(597.4, 2929, 40.9),
        cloakrooms = {
            {x = 597.2, y = 2928.8, z = 40.9}
        },
        name = _U('blip_fueler'),
        sprite = 436, 
        color = 5, 
        radius = 0.0,
        job = 'fueler',
        Blip = true
    },
    FuelerProcess = {
        workCoords = vector3(2793.4, 1709.9, 24.6),
        blipCoords = vector3(2793.4, 1709.9, 24.6),
        cloakrooms = {},
        name = _U('blip_fuelerprocess'),
        sprite = 467, 
        color = 5, 
        radius = 0.0,
        Blip = false
    }
}