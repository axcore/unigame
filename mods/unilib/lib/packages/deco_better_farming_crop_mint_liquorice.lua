---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_better_farming_crop_mint_liquorice = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_better_farming_crop_mint_liquorice.init()

    return {
        description = "Liquorice mint as decoration",
        depends = {"biome_default_grassland", "crop_mint_liquorice", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_better_farming_crop_mint_liquorice.post()

    unilib.register_decoration_complete("better_farming_crop_mint_liquorice", nil, {
        -- From better_farming, mint.lua
        -- Completes decoration in package "crop_mint_liquorice"
        biomes = "default_grassland",
        place_on = "unilib:dirt_ordinary_with_turf",
        y_max = unilib.constant.y_max,
        y_min = 1,
    })

end
