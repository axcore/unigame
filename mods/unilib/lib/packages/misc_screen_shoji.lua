---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_screen_shoji = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_screen_shoji.init()

    return {
        description = "Shoji screen",
        notes = "Japanese paper screen",
        depends = "item_paper_ordinary",
    }

end

function unilib.pkg.misc_screen_shoji.exec()

    unilib.register_node("unilib:misc_screen_shoji", "ethereal:paper_wall", mode, {
        -- From ethereal:paper_wall
        description = S("Shoji Screen"),
        tiles = {"unilib_misc_screen_shoji.png"},
        groups = {snappy = 3},
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        inventory_image = "unilib_misc_screen_shoji.png",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 5/11, 0.5, 0.5, 8/16}
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, 5/11, 0.5, 0.5, 8/16}
        },
        sunlight_propagates = true,
        walkable = true,
        wield_image = "unilib_misc_screen_shoji.png",
    })
    unilib.register_craft({
        -- From ethereal:paper_wall
        output = "unilib:misc_screen_shoji",
        recipe = {
            {"group:stick", "unilib:item_paper_ordinary", "group:stick"},
            {"group:stick", "unilib:item_paper_ordinary", "group:stick"},
            {"group:stick", "unilib:item_paper_ordinary", "group:stick"},
        },
    })

end
