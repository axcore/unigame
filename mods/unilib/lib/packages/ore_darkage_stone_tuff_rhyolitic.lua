---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_darkage_stone_tuff_rhyolitic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_darkage_stone_tuff_rhyolitic.init()

    return {
        description = "Rhyolitic tuff as ore",
        depends = "stone_tuff_rhyolitic",
        at_least_one = {
            "dirt_ordinary",
            "gravel_ordinary",
            "stone_ordinary",
            "stone_ordinary_with_coal",
        },
    }

end

function unilib.pkg.ore_darkage_stone_tuff_rhyolitic.post()

    unilib.register_ore({
        -- From darkage/mapgen.lua
        ore_type                = "sheet",
        ore                     = "unilib:stone_tuff_rhyolitic",
        wherein                 = {
            "unilib:dirt_ordinary",
            "unilib:gravel_ordinary",
            "unilib:stone_ordinary",
            "unilib:stone_ordinary_with_coal",
        },

        column_height_max       = 20,
        column_height_min       = 15,
        noise_params            = {
            octaves = 1,
            offset = 0.35,
            persistence = 0.6,
            scale = 0.2,
            seed = unilib.utils.get_mod_attribute("storage_random_seed_offset") + 13,
            spread = {x = 100, y = 100, z = 100},
        },
        noise_threshold         = 0.53,
        y_max                   = 200,
        y_min                   = -2000,
    })

end
