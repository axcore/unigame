---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_delphinium_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_delphinium_blue.init()

    return {
        description = "Blue delphinium flower",
    }

end

function unilib.pkg.flower_delphinium_blue.exec()

    unilib.register_flower({
        -- From bakedclay:delphinium. Creates unilib:flower_delphinium_blue
        part_name = "delphinium_blue",
        orig_name = "bakedclay:delphinium",
        select_table = {-0.15, -0.5, -0.15, 0.15, 0.3, 0.15},

        replace_mode = mode,
        deco_part_name = "bakedclay",
        description = S("Blue Delphinium"),
        -- N.B. No flammable = 1 in original code
        group_table = {color_cyan = 1, flammable = 1},
        no_deco_flag = true,
        sci_name = "Delphinium",
    })

    unilib.register_decoration("bakedclay_flower_delphinium_blue", {
        -- From bakedclay:delphinium
        deco_type = "simple",
        decoration = "unilib:flower_delphinium_blue",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.004,
            seed = 7133,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
