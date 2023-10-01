---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_chrysanthemum_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_chrysanthemum_green.init()

    return {
        description = "Green chrysanthemum flower",
    }

end

function unilib.pkg.flower_chrysanthemum_green.exec()

    unilib.register_flower({
        -- From flowers:chrysanthemum_green. Creates unilib:flower_chrysanthemum_green
        part_name = "chrysanthemum_green",
        orig_name = "flowers:chrysanthemum_green",
        select_table = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},

        replace_mode = mode,
        deco_part_name = "flowers",
        description = S("Green Chrysanthemum"),
        group_table = {color_green = 1, flammable = 1},
        sci_name = "Chrysanthemum",
        seed = 800081,
    })

end
