---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_dandelion_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_dandelion_white.init()

    return {
        description = "White dandelion flower",
    }

end

function unilib.pkg.flower_dandelion_white.exec()

    unilib.register_flower({
        -- From flowers:dandelion_white. Creates unilib:flower_dandelion_white
        part_name = "dandelion_white",
        orig_name = "flowers:dandelion_white",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -2 / 16, 5 / 16},

        replace_mode = mode,
        deco_part_name = "flowers",
        description = S("White Dandelion"),
        group_table = {color_white = 1, colour_white = 1, flammable = 1},
        sci_name = "Taraxacum",
        seed = 1220999,
    })

end
