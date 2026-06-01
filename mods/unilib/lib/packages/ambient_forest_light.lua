---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ambient_forest_light = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function can_play(pos)

    -- (Only play during daytime)
    if core.get_timeofday() > 0.25 and core.get_timeofday() < 0.75 then
        return true
    else
        return false
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ambient_forest_light.init()

    return {
        description = "Light forest (ambient effect)",
        notes = "This package exists to demonstrate how packages can register ambient sound" ..
                " effects; unilib does not provide a complete set of ambient noises. See the" ..
                " \"machine_noisy\" package for an example of registering environment sound" ..
                " effects",
        depends = {"biome_default_forest_coniferous", "biome_default_forest_deciduous"},
    }

end

function unilib.pkg.ambient_forest_light.exec()

    unilib.atmosphere.register_ambient("unilib_forest_light", {
        biome_list = {
            "default_forest_coniferous",
            "default_forest_deciduous",
        },
        node_list = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf",
        },
        play_func = can_play,
        single_list = {
            {name = "unilib_ambient_single_crow", gain = 0.4},
        },
        single_prob = 0.05,
        repeat_list = {
            {
                name = "unilib_ambient_repeat_forest_light",
                gain = 1.0,
                fade = (1 / unilib.setting.atmosphere_transition_duration),
            },
        },
        repeat_prob = 1,
    })

end
