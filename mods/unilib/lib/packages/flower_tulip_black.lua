---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_tulip_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_tulip_black.init()

    return {
        description = "Black tulip flower",
    }

end

function unilib.pkg.flower_tulip_black.exec()

    unilib.register_flower({
        -- From flowers:tulip_black. Creates unilib:flower_tulip_black
        part_name = "tulip_black",
        orig_name = "flowers:tulip_black",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},

        replace_mode = mode,
        deco_part_name = "flowers",
        description = S("Black Tulip"),
        group_table = {color_black = 1, colour_black = 1, flammable = 1},
        sci_name = "Tulipa",
        seed = 42,
    })

end
