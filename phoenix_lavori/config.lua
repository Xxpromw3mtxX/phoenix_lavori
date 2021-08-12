Config = {}

-- Language
Config.Locale = 'it'

Config.Delays = {
    StonePickUp = 1500,
    StoneProcessing = 35000,
    SlaughtererPickUp = 1500,
    SlaughtererProcessing = 35000,
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
Config.JobClothes = {
    -- Miner
    Miner = {
        MaleSkin = {
            ["tshirt_1"] = 59,["tshirt_2"] = 0,
            ["torso_1"] = 56,["torso_2"] = 0,
            ["arms"] = 0,
            ["pants_1"] = 36, ["pants_2"] = 0,
            ["shoes_1"] = 27,["shoes_2"] = 0,
            ["helmet_1"] = 0,["helmet_2"] = 5,
            ["glasses_1"] = 15, ["glasses_2"] = 6
        },
        FemaleSkin = {
            ["tshirt_1"] = 36,["tshirt_2"] = 0,
            ["torso_1"] = 73,["torso_2"] = 0,
            ["arms"] = 14,
            ["pants_1"] = 35, ["pants_2"] = 0,
            ["shoes_1"] = 26,["shoes_2"] = 0,
            ["helmet_1"] = 0,["helmet_2"] = 5,
            ["glasses_1"] = 15, ["glasses_2"] = 6
        }
    },

    --Slaughterer
    Slaughterer = {
        MaleSkin = {
            ["tshirt_1"] = 59,["tshirt_2"] = 0,
            ["torso_1"] = 56,["torso_2"] = 0,
            ["arms"] = 0,
            ["pants_1"] = 36, ["pants_2"] = 0,
            ["shoes_1"] = 27,["shoes_2"] = 0,
            ["helmet_1"] = 0,["helmet_2"] = 5,
            ["glasses_1"] = 15, ["glasses_2"] = 6
        },
        FemaleSkin = {
            ["tshirt_1"] = 59,["tshirt_2"] = 0,
            ["torso_1"] = 56,["torso_2"] = 0,
            ["arms"] = 0,
            ["pants_1"] = 36, ["pants_2"] = 0,
            ["shoes_1"] = 27,["shoes_2"] = 0,
            ["helmet_1"] = 0,["helmet_2"] = 5,
            ["glasses_1"] = 15, ["glasses_2"] = 6            
        }
    },

    -- Fueler
    Fueler = {
        MaleSkin = {
            ["tshirt_1"] = 23,["tshirt_2"] = 0,
            ["torso_1"] = 12,["torso_2"] = 0,
            ["arms"] = 0,
            ["pants_1"] = 36, ["pants_2"] = 0,
            ["shoes_1"] = 27,["shoes_2"] = 0,
            ["helmet_1"] = 0,["helmet_2"] = 5,
            ["glasses_1"] = 15, ["glasses_2"] = 6
        },
        FemaleSkin = {
            ["tshirt_1"] = 23,["tshirt_2"] = 0,
            ["torso_1"] = 12,["torso_2"] = 0,
            ["arms"] = 0,
            ["pants_1"] = 36, ["pants_2"] = 0,
            ["shoes_1"] = 27,["shoes_2"] = 0,
            ["helmet_1"] = 0,["helmet_2"] = 5,
            ["glasses_1"] = 15, ["glasses_2"] = 6
        }
    }
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
        blipCoords = vector3(2793.4, 1709.9, 24.6),
        cloakrooms = {},
        processmarker = {},
        name = _U('blip_fuelerprocess'),
        sprite = 467, 
        color = 5, 
        radius = 0.0,
        Blip = false
    }
}

Config.JobVehicles = {
    -- Miner
    Miner = {
        model = {
            [0] = 'TipTruck',
            [1] = 'TipTruck2',
        },
        coords = vector3(2689, 2763, 37.9),
        heading = 197.19
    },

    -- Slaughterer
    Slaughterer = {
        model = {
            [0] = 'Mule',
            [1] = 'Mule2',
            [2] = 'Mule3',
        },
        coords = vector3(2412.5, 4990.2, 46.3),
        heading = 142.77
    },

    -- Fueler
    Fueler = {
        model = 'Mixer',
        coords = vector3(603.7, 2937.5, 40.9),
        heading = 297.69
    }
}