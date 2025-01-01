---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_snow_flower_frozen = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_snow_flower_frozen.init()

    return {
        description = "Frozen flowers as decorations",
        depends = "flower_frozen",
        at_least_one = {"biome_snow_lush", "biome_snow_normal"},
    }

end

function unilib.pkg.deco_snow_flower_frozen.post()

    for _, pkg_name in pairs({
        "flower_chrysanthemum_green",
        "flower_dandelion_white",
        "flower_dandelion_yellow",
        "flower_geranium_blue",
        "flower_rose_red",
        "flower_tulip_black",
        "flower_tulip_orange",
        "flower_viola_purple",
    }) do

        unilib.register_decoration_complete("snow_" .. pkg_name, nil, {
            -- Original to unilib
            -- Completes the decoration in "flower_frozen"
            biomes = {"snow_lush", "snow_normal"},
            place_on = "unilib:dirt_ordinary_with_cover_snow",
        })

    end

end
