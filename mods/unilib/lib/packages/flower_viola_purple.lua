---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_viola_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_viola_purple.init()

    return {
        description = "Purple viola flower",
    }

end

function unilib.pkg.flower_viola_purple.exec()

    unilib.register_flower({
        -- From flowers:viola. Creates unilib:flower_viola_purple
        part_name = "viola_purple",
        orig_name = "flowers:viola",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "flowers",
        description = S("Viola"),
        group_table = {color_violet = 1, colour_violet = 1, flammable = 1},
        sci_name = "Viola",
        seed = 1133,
    })

end
