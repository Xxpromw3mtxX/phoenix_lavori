Config = {}

-- Language
Config.Locale = 'it'

Config.Delays = {
    StonePickUp = 1500,
    StoneProcessing = 35000
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
    -- Miner
    Miner = {
        workCoords = vector3(2953.3, 2789.3, 41.5),
        blipCoords = vector3(2707.4, 2776.8, 37.9),
        cloakrooms = {
            {x = 2707.4, y = 2776.8, z = 37.9}
        },
        processmarker = {},
        name = _U('blip_mine'),
        sprite = 318, 
        color = 47, 
        radius = 0.0,
        job = 'miner',
        Blip = true
    },

    MinerProcess = {
        workCoords = vector3(286.8, 2844.0, 44.7),
        blipCoords = vector3(286.8, 2844.0, 44.7),
        cloakrooms = {},
        processmarker = {
            {x = 286.8, y = 2844.0, z = 44.7}
        },
        name = _U('blip_mineprocess'),
        sprite = 467, 
        color = 47, 
        radius = 0.0,
        Blip = false
    }
}