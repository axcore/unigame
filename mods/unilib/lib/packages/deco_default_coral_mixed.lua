---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_default_coral_mixed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_default_coral_mixed.init()

    return {
        description = "Mixed coral as decoration",
        depends = "sand_ordinary",
        at_least_one = {
            {
                "coral_block_brown",
                "coral_block_orange",
                "coral_block_skeleton",
                "coral_rooted_cyan",
                "coral_rooted_green",
                "coral_rooted_pink",
            },
            {
                "biome_default_desert",
                "biome_default_rainforest",
                "biome_default_savanna",
            },
        },
    }

end

function unilib.pkg.deco_default_coral_mixed.exec()

    unilib.register_mixed_coral_as_decoration("default_coral_mixed")

end

function unilib.pkg.deco_default_coral_mixed.post()

    if unilib.pkg_executed_table["biome_default_desert"] ~= nil or
            unilib.pkg_executed_table["biome_default_rainforest"] ~= nil or
            unilib.pkg_executed_table["biome_default_savanna"] ~= nil then

        unilib.register_decoration_now("default_coral_mixed", nil, {
            -- From default/mapgen.lua
            biomes = {
                "default_desert_ocean",
                "default_rainforest_ocean",
                "default_savanna_ocean",
            },
            place_on = "unilib:sand_ordinary",
            y_max = -2,
            y_min = -8,
        })

    end

end
