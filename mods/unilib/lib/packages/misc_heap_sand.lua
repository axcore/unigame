---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    forest
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_heap_sand = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.forest.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_heap_sand.init()

    return {
        description = "When placed on the ground, forms a simple path",
        depends = "sand_ordinary",
    }

end

function unilib.pkg.misc_heap_sand.exec()

    unilib.register_node("unilib:misc_heap_sand", "forest:sand_way", mode, {
        -- From forest:sand_way
        description = S("Sand Heap"),
        tiles = {
            "unilib_misc_heap_sand.png",
            "unilib_misc_heap_sand_curve.png",
            "unilib_misc_heap_sand_junction.png",
            "unilib_misc_heap_sand_crossing.png",
        },
        -- N.B. way = 1 in original code, omitted here
        groups = {dig_immediate = 3},
        sounds = unilib.sound_table.sand,

        drawtype = "raillike",
        inventory_image = "unilib_misc_heap_sand_inv.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
        },
        walkable = false,
        wield_image = "unilib_misc_heap_sand_inv.png",
    })
    unilib.register_craft_3x3({
        -- From forest:sand_way
        output = "unilib:sand_ordinary",
        ingredient = "unilib:misc_heap_sand",
    })
    unilib.register_craft({
        -- From forest:sand_way
        output = "unilib:misc_heap_sand 9",
        recipe = {
            {"unilib:sand_ordinary"},
        }
    })

end
