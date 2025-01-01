---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_dandelion_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_dandelion_yellow.init()

    return {
        description = "Yellow dandelion flower",
    }

end

function unilib.pkg.flower_dandelion_yellow.exec()

    unilib.register_flower({
        -- From flowers:dandelion_yellow. Creates unilib:flower_dandelion_yellow
        part_name = "dandelion_yellow",
        orig_name = "flowers:dandelion_yellow",
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, -2 / 16, 4 / 16},

        replace_mode = mode,
        deco_part_name = "flowers",
        description = S("Yellow Dandelion"),
        group_table = {color_yellow = 1, colour_yellow = 1, flammable = 1},
        sci_name = "Taraxacum",
        seed = 1220999,
    })

end
