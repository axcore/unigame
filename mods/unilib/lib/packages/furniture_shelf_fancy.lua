---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_shelf_fancy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_shelf_fancy.init()

    return {
        description = "Fancy wooden shelves",
        depends = "container_box_simple",
    }

end

function unilib.pkg.furniture_shelf_fancy.exec()

    unilib.register_node("unilib:furniture_shelf_fancy", "darkage:wood_shelves", mode, {
        -- From darkage:wood_shelves
        description = S("Fancy Wooden Shelves"),
        tiles = {
            "unilib_furniture_shelf_fancy.png",
            "unilib_furniture_shelf_fancy.png",
            "unilib_furniture_shelf_fancy.png",
            "unilib_furniture_shelf_fancy.png",
            "unilib_furniture_shelf_fancy.png",
            "unilib_furniture_shelf_fancy_front.png",
        },
        groups = {snappy = 3},
        sounds = unilib.global.sound_table.wood,

        -- N.B. is_ground_content = false not in original code; added to match other furniture
        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From darkage:wood_shelves
        output = "unilib:furniture_shelf_fancy",
        recipe = {
            {"unilib:container_box_simple"},
            {"unilib:container_box_simple"},
        },
    })

    -- N.B. Original code had an inventory of 32; the inventory is now 16, to match standard
    --      bookshelves/itemshelves
    unilib.furniture.convert_to_container(
        "unilib:furniture_shelf_fancy",
        2,
        S("Fancy Wooden Shelves"),
        "fancy shelf"
    )

end
