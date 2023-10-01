---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_table_rustic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_table_rustic.init()

    return {
        description = "Rustic wooden table",
    }

end

function unilib.pkg.furniture_table_rustic.exec()

    unilib.register_node("unilib:furniture_table_rustic", "cottages:table", mode, {
        -- From cottages:table
        description = S("Rustic Wooden Table"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.1, -0.5, -0.1, 0.1, 0.3, 0.1},
                {-0.5, 0.48, -0.5, 0.5, 0.4, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.4, 0.5},
            },
        },
    })
    unilib.register_craft({
        -- From cottages:table
        output = "unilib:furniture_table_rustic",
        recipe = {
            -- N.B. Original code used stairs:slab_wood
            {"", "group:wood_stair_slab", ""},
            {"", "group:stick", ""},
        }
    })

end
