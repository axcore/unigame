---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    more_coral
-- Code:    MIT
-- Media:   CC BY-SA
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_more_coral_coral_growing = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.more_coral.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_more_coral_coral_growing.init()

    return {
        description = "Growing coral as decoration",
        depends = {"coral_growing_basic", "sand_ordinary"},
        at_least_one = {
            "biome_default_desert",
            "biome_default_rainforest",
            "biome_default_savanna",
        },
    }

end

function unilib.pkg.deco_more_coral_coral_growing.exec()

    unilib.register_decoration_now("more_coral_coral_growing_basic", nil, {
        -- From more_coral/init.lua
        -- Completes decoration in package "coral_growing_basic"
        biomes = {
            "default_desert_ocean",
            "default_rainforest_ocean",
            "default_savanna_ocean",
        },
        place_on = "unilib:sand_ordinary",
        y_max = -2,
        y_min = -12,
    })

end
