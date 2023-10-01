---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrapdoors
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.door_wood_saloon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrapdoors.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.door_wood_saloon.init()

    return {
        description = "Saloon door",
        depends = "tree_apple",
    }

end

function unilib.pkg.door_wood_saloon.exec()

    unilib.register_door({
        -- From moretrapdoors:western_door. Creates unilib:door_wood_saloon
        part_name = "wood_saloon",
        orig_name = {
            "doors:western_door_a",
            "doors:western_door_b",
            "doors:western_door_c",
            "doors:western_door_d",
        },
        def_table = {
            description = S("Saloon Door"),
            tiles = {{name = "unilib_door_wood_saloon.png", backface_culling = false}},
            groups = {choppy = 2, flammable = 2, node = 1, oddly_breakable_by_hand = 2},
            -- (no sounds)

            gain_close = 0.13,
            gain_open = 0.06,
            inventory_image = "unilib_door_wood_saloon_inv.png",
            recipe = {
                {"unilib:tree_apple_wood", "unilib:tree_apple_wood"},
                {"unilib:tree_apple_wood", "unilib:tree_apple_wood"},
            }
        },

        replace_mode = mode,
        orig_craftitem_name = "doors:western_door",
    })

end
