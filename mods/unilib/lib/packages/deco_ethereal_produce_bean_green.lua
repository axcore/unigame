---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_produce_bean_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_produce_bean_green.init()

    return {
        description = "Green beans as decoration",
        depends = {"biome_ethereal_grassy", "dirt_ordinary", "produce_bean_green"},
    }

end

function unilib.pkg.deco_ethereal_produce_bean_green.exec()

    unilib.register_decoration("ethereal_produce_bean_green", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:produce_bean_green_wild",

        fill_ratio = 0.035,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_produce_bean_green.post()

    unilib.register_decoration_now("ethereal_produce_bean_green", nil, {
        -- From ethereal-ng/decor.lua
        biomes = "ethereal_grassy",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = 100,
        y_min = 1,
    })

end

