---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.door_japanese = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_japanese.init()

    return {
        description = "Japanese door",
        depends = "item_paper_ordinary",
    }

end

function unilib.pkg.door_japanese.exec()

    unilib.register_door({
        -- From xdecor, doors:japanese_door. Creates unilib:door_japanese_closed_left, etc
        part_name = "japanese",
        orig_name_list = {
            "doors:japanese_door_a",
            "doors:japanese_door_b",
            "doors:japanese_door_c",
            "doors:japanese_door_d",
        },
        def_table = {
            description = S("Japanese Door"),
            tiles = {{name = "unilib_door_japanese.png", backface_culling = true}},
            -- N.B. node = 1 missing from original code
            groups = {choppy = 2, cracky = 2, door = 1, node = 1, oddly_breakable_by_hand = 1},
            -- (no sounds)

            inventory_image = "unilib_door_japanese_inv.png",
            protected_flag = false,
            recipe = {
                {"group:wood", "unilib:item_paper_ordinary"},
                {"unilib:item_paper_ordinary", "group:wood"},
                {"group:wood", "unilib:item_paper_ordinary"},
            },
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:japanese_door",
    })

end
