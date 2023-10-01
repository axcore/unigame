---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_ethereal_crop_mint_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_ethereal_crop_mint_normal.init()

    return {
        description = "Normal mint as decoration",
        depends = "crop_mint_normal",
        at_least_one = {"dirt_ordinary_with_turf_bamboo", "dirt_ordinary"},
    }

end

function unilib.pkg.deco_ethereal_crop_mint_normal.exec()

    unilib.register_decoration("ethereal_crop_mint_normal", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:crop_mint_normal_grow_4",

        fill_ratio = 0.003,
        sidelen = 80,
    })

end

function unilib.pkg.deco_ethereal_crop_mint_normal.post()

    unilib.register_decoration_now("ethereal_crop_mint_normal", nil, {
        -- From ethereal-ng/decor.lua
        num_spawn_by = 1,
        place_on = {
            "unilib:dirt_ordinary_with_litter_coniferous",
            "unilib:dirt_ordinary_with_turf_bamboo",
            "unilib:dirt_ordinary_with_turf",
        },
        spawn_by = "group:water",
        y_max = 75,
        y_min = 1,
    })

end
