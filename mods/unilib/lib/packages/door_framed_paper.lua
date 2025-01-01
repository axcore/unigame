---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_framed_paper = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_framed_paper.init()

    return {
        description = "Wood-framed paper door",
        depends = "item_paper_ordinary",
    }

end

function unilib.pkg.door_framed_paper.exec()

    unilib.register_door({
        -- From xdecor, doors:slide_door. Creates unilib:door_framed_paper_closed_left, etc
        part_name = "framed_paper",
        orig_name_list = {
            "doors:slide_door_a",
            "doors:slide_door_b",
            "doors:slide_door_c",
            "doors:slide_door_d",
        },
        def_table = {
            description = S("Wood-Framed Paper Door"),
            tiles = {{name = "unilib_door_framed_paper.png", backface_culling = true}},
            -- N.B. node = 1 missing from original code
            groups = {choppy = 2, cracky = 2, door = 1, node = 1, oddly_breakable_by_hand = 1},
            -- (no sounds)

            inventory_image = "unilib_door_framed_paper_inv.png",
            protected_flag = false,
            recipe = {
                {"unilib:item_paper_ordinary", "unilib:item_paper_ordinary"},
                {"unilib:item_paper_ordinary", "unilib:item_paper_ordinary"},
                {"group:wood", "group:wood"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:slide_door",
    })

end
