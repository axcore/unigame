---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.utensil_board_cutting = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.utensil_board_cutting.init()

    return {
        description = "Cutting board",
        notes = "Used for cutting items like pumpkins into slices",
        depends = "metal_steel",
    }

end

function unilib.pkg.utensil_board_cutting.exec()

    unilib.register_craftitem("unilib:utensil_board_cutting", "farming:cutting_board", mode, {
        -- From farming:cutting_board
        description = S("Cutting Board"),
        inventory_image = "unilib_utensil_board_cutting.png",
        groups = {flammable = 2, food_cutting_board = 1}
    })
    unilib.register_craft({
        -- From farming:cutting_board
        output = "unilib:utensil_board_cutting",
        recipe = {
            {"unilib:metal_steel_ingot", "", ""},
            {"", "group:stick", ""},
            {"", "", "group:wood"}
        }
    })

end
