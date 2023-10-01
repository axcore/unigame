---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bakedclay
-- Code:    MIT
-- Media:   CC
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_reed_mannagrass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bakedclay.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_reed_mannagrass.init()

    return {
        description = "Reed mannagrass",
        notes = "Classified as a flower, not a plant, in order to keep code from bakedclay" ..
                " consistent",
    }

end

function unilib.pkg.flower_reed_mannagrass.exec()

    unilib.register_flower({
        -- From bakedclay:mannagrass. Creates unilib:flower_reed_mannagrass
        part_name = "reed_mannagrass",
        orig_name = "bakedclay:mannagrass",
        select_table = {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15},

        replace_mode = mode,
        deco_part_name = "bakedclay",
        description = S("Reed Mannagrass"),
        -- N.B. Omitted flammable = 1 (as in original code) because it's a water-based flower
        group_table = {color_green_dark = 1},
        no_deco_flag = true,
        sci_name = "Glyceria maxima",
    })

    unilib.register_decoration("bakedclay_flower_reed_mannagrass", {
        -- From bakedclay:mannagrass
        deco_type = "simple",
        decoration = "unilib:flower_reed_mannagrass",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.009,
            seed = 7136,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
