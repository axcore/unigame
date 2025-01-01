---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_shelf_rustic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cottages.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_shelf_rustic.init()

    return {
        description = "Rustic wooden shelves",
    }

end

function unilib.pkg.furniture_shelf_rustic.exec()

    unilib.register_node("unilib:furniture_shelf_rustic", "cottages:shelf", mode, {
        -- From cottages:shelf
        description = S("Rustic Wooden Shelves"),
        tiles = {"unilib_misc_wood_rustic.png"},
        groups = {choppy = 2, oddly_breakable_by_hand = 2, snappy = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.3, -0.4, 0.5, 0.5},
                {0.4, -0.5, -0.3, 0.5, 0.5, 0.5},
                {-0.5, -0.2, -0.3, 0.5, -0.1, 0.5},
                {-0.5, 0.3, -0.3, 0.5, 0.4, 0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },
    })
    unilib.register_craft({
        -- From cottages:shelf
        output = "unilib:furniture_shelf_rustic",
        recipe = {
            {"group:stick", "group:wood", "group:stick"},
            {"group:stick", "group:wood", "group:stick"},
            {"group:stick", "", "group:stick"},
        },
    })

    -- N.B. Original code had an inventory of 24; the inventory is now 16, to match standard
    --      bookshelves/itemshelves
    unilib.furniture.convert_to_container(
        "unilib:furniture_shelf_rustic",
        2,
        S("Rustic Wooden Shelves"),
        "rustic shelf"
    )

end
