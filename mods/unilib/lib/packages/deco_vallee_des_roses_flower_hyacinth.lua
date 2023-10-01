---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    vallee_des_roses
-- Code:    Unlicense
-- Media:   Unlicense
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_vallee_des_roses_flower_hyacinth = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.vallee_des_roses.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_vallee_des_roses_flower_hyacinth.init()

    return {
        description = "Hyacinth as decoration",
        depends = {"dirt_ordinary", "flower_hyacinth"},
        at_least_one = {
            "biome_default_grassland",
            "biome_default_grassland_snowy",
            "biome_default_taiga",
        },
    }

end

function unilib.pkg.deco_vallee_des_roses_flower_hyacinth.post()

    unilib.register_decoration_now("vallee_des_roses_flower_hyacinth", nil, {
        -- From vallee_des_roses/init.lua
        -- Completes decoration in package "flower_hyacinth"
        biomes = {"default_grassland", "default_grassland_snowy", "default_taiga"},
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_cover_snow",
            "unilib:dirt_ordinary_with_turf",
        },
        y_max = 200,
        y_min = 1,
    })

end
