---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_thistle = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_thistle.init()

    return {
        description = "Thistle flower",
    }

end

function unilib.pkg.flower_thistle.exec()

    unilib.register_flower({
        -- From bakedclay:thistle. Creates unilib:flower_thistle
        part_name = "thistle",
        orig_name = "bakedclay:thistle",
        select_table = {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15},

        replace_mode = mode,
        deco_part_name = "bakedclay",
        description = S("Thistle"),
        -- N.B. No flammable = 1 in original code
        group_table = {color_magenta = 1, flammable = 1},
        no_deco_flag = true,
        sci_name = "Silybum marianum",
    })

    unilib.register_decoration("bakedclay_flower_thistle", {
        -- From bakedclay:thistle
        deco_type = "simple",
        decoration = "unilib:flower_thistle",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.004,
            seed = 7134,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
