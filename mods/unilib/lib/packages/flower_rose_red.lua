---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_rose_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_rose_red.init()

    return {
        description = "Red rose flower",
    }

end

function unilib.pkg.flower_rose_red.exec()

    unilib.register_flower({
        -- From flowers:rose. Creates unilib:flower_rose_red
        part_name = "rose_red",
        orig_name = "flowers:rose",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},

        replace_mode = mode,
        deco_part_name = "flowers",
        description = S("Red Rose"),
        group_table = {color_red = 1, colour_red = 1, flammable = 1},
        sci_name = "Rosa",
        seed = 436,
    })

end
