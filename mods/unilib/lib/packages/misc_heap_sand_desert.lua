---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    forest
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_heap_sand_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.forest.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_heap_sand_desert.init()

    return {
        description = "When placed on the ground, forms a simple path",
        depends = "sand_desert",
    }

end

function unilib.pkg.misc_heap_sand_desert.exec()

    unilib.register_node("unilib:misc_heap_sand_desert", "forest:desert_sand_way", mode, {
        -- From forest:desert_sand_way
        description = S("Desert Sand Heap"),
        tiles = {
            "unilib_misc_heap_sand_desert.png",
            "unilib_misc_heap_sand_desert_curve.png",
            "unilib_misc_heap_sand_desert_junction.png",
            "unilib_misc_heap_sand_desert_crossing.png",
        },
        -- N.B. way = 1 in original code, omitted here
        groups = {dig_immediate = 3},
        sounds = unilib.node_sound_dirt_defaults({
            footstep = {name = "unilib_gravel_footstep", gain = 0.5},
            dug = {name = "unilib_gravel_footstep", gain = 1.0},
        }),

        drawtype = "raillike",
        inventory_image = "unilib_misc_heap_sand_desert_inv.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
        },
        walkable = false,
        wield_image = "unilib_misc_heap_sand_desert_inv.png",
    })
    unilib.register_craft_3x3({
        -- From forest:sand_way
        output = "unilib:sand_desert",
        ingredient = "unilib:misc_heap_sand_desert",
    })
    unilib.register_craft({
        -- From forest:sand_way
        output = "unilib:misc_heap_sand_desert 9",
        recipe = {
            {"unilib:sand_desert"},
        }
    })

end
