---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_geranium_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_geranium_blue.init()

    return {
        description = "Blue geranium flower",
    }

end

function unilib.pkg.flower_geranium_blue.exec()

    unilib.register_flower({
        -- From flowers:geranium. Creates unilib:flower_geranium_blue
        part_name = "geranium_blue",
        orig_name = "flowers:geranium",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},

        replace_mode = mode,
        deco_part_name = "flowers",
        description = S("Blue Geranium"),
        group_table = {color_blue = 1, colour_blue = 1, flammable = 1},
        sci_name = "Geranium",
        seed = 36662,
    })

end
