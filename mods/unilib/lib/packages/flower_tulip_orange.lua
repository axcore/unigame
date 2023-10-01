---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_tulip_orange = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_tulip_orange.init()

    return {
        description = "Orange tulip flower",
    }

end

function unilib.pkg.flower_tulip_orange.exec()

    unilib.register_flower({
        -- From flowers:tulip. Creates unilib:flower_tulip_orange
        part_name = "tulip_orange",
        orig_name = "flowers:tulip",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},

        replace_mode = mode,
        deco_part_name = "flowers",
        description = S("Orange Tulip"),
        group_table = {color_orange = 1, flammable = 1},
        sci_name = "Tulipa",
        seed = 19822,
    })

end
