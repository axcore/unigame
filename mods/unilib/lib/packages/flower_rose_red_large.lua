---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_rose_red_large = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_rose_red_large.init()

    return {
        description = "Large red rose",
    }

end

function unilib.pkg.flower_rose_red_large.exec()

    unilib.register_flower({
        -- Texture from cropocalypse, original code. Creates unilib:flower_rose_red_large
        part_name = "rose_red_large",
        orig_name = nil,
        select_table = {-6 / 16, -0.5, -6 / 16, 6 / 16, 8 / 16, 6 / 16},

        replace_mode = mode,
        deco_part_name = "cropocalypse",
        description = S("Large Red Rose"),
        group_table = {color_red = 1, flammable = 1},
        sci_name = "Rosa",
        seed = 437,
    })

end
