---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_flooring_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_flooring_wood.init()

    return {
        description = "Wooden flooring",
        depends = "item_string_ordinary",
    }

end

function unilib.pkg.misc_flooring_wood.exec()

    unilib.register_node("unilib:misc_flooring_wood", "cottages:wood_flat", mode, {
        -- From cottages:wood_flat
        description = S("Wooden Flooring"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2,oddly_breakable_by_hand = 2,snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.50, 0.5, -0.5+1/16, 0.50},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.50, 0.5, -0.5+1/16, 0.50},
            },
        },

        on_place = core.rotate_node,
    })
    unilib.register_craft({
        -- From cottages:wood_flat
        output = "unilib:misc_flooring_wood 16",
        recipe = {
            {"group:stick", "unilib:item_string_ordinary", "group:stick"},
            {"group:stick", "", "group:stick"},
        },
    })

end
