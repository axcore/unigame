---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lazarus_bell = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lazarus_bell.init()

    return {
        description = "Lazarus bell flower",
    }

end

function unilib.pkg.flower_lazarus_bell.exec()

    unilib.register_flower({
        -- From bakedclay:lazarus. Creates unilib:flower_lazarus_bell
        part_name = "lazarus_bell",
        orig_name = "bakedclay:lazarus",
        select_table = {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15},

        replace_mode = mode,
        deco_part_name = "bakedclay",
        description = S("Lazarus Bell"),
        -- N.B. flammable = 1 not in original code
        group_table = {color_pink = 1, flammable = 1},
        no_deco_flag = true,
        sci_name = "Fritillaria meleagris",
    })

    unilib.register_decoration("bakedclay_flower_lazarus_bell", {
        -- From bakedclay:lazarus
        deco_type = "simple",
        decoration = "unilib:flower_lazarus_bell",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.01,
            seed = 7135,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
