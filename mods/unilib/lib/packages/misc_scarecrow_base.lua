---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_scarecrow_base = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_scarecrow_base.init()

    return {
        description = "Scarecrow base",
        notes = "Matches the dimensions of the items in the \"misc_scarecrow_pumpkin\" package",
    }

end

function unilib.pkg.misc_scarecrow_base.exec()

    unilib.register_node("unilib:misc_scarecrow_base", "farming:scarecrow_bottom", mode, {
        -- From farming:scarecrow_bottom
        description = S("Scarecrow Base"),
        tiles = {"unilib_tree_apple_wood.png"},
        groups = {flammable = 2, snappy = 3},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
                {-12/16, 4/16, -1/16, 12/16, 2/16, 1/16},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })
    unilib.register_craft({
        -- From farming:scarecrow_bottom
        output = "unilib:misc_scarecrow_base",
        recipe = {
            {"", "group:stick", ""},
            {"group:stick", "group:stick", "group:stick"},
            {"", "group:stick", ""},
        },
    })

end
