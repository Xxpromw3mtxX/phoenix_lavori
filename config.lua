Config = {}

-- Language
Config.Locale = 'it'

Config.Delays = {
    StonePickUp = 1500,
    StoneProcessing = 35000,
    OilPickUp = 15000,
    OilProcessing = 35000,
    SlaughtererPickUp = 1500,
    SlaughtererProcessing = 35000,
}

-- Map blips
Config.SetMapBlips = true

-- Configs
Config.DrawDistance = 100

-- Marker Settings
Config.MarkerType = 20
Config.MarkerSize = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor = {r = 50, g = 50, b = 204}

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
    },

    -- Fueler
    Fueler = {
        workCoords = vector3(583.4, 2931, 40.9),
        blipCoords = vector3(597.4, 2929, 40.9),
        cloakrooms = {
            {x = 597.2, y = 2928.8, z = 40.9}
        },
        processmarker = {},
        name = _U('blip_fueler'),
        sprite = 436, 
        color = 5, 
        radius = 0.0,
        job = 'fueler',
        Blip = true
    },
    FuelerProcess = {
        workCoords = vector3(2793.4, 1709.9, 24.6),
        blipCoords = vector3(2731.2, 1554.9, 25),
        cloakrooms = {},
        processmarker = {},
        name = _U('blip_fuelerprocess'),
        sprite = 467, 
        color = 5, 
        radius = 0.0,
        Blip = false
    },

    -- Slaughterer
    Slaughterer = {
        workCoords = vector3(2379.3, 5053.7, 46.4),
        blipCoords = vector3(2415.5, 5004.9, 46.7),
        cloakrooms = {
            {x = 2415.5, y = 5004.9, z = 46.7}
        },
        processmarker = {},
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
        processmarker = {},
        name = _U('blip_slaughtererprocess'),
        sprite = 467, 
        color = 35, 
        radius = 0.0,
        Blip = false
    },
}