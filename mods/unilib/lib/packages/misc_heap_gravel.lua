---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    forest
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_heap_gravel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.forest.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_heap_gravel.init()

    return {
        description = "When placed on the ground, forms a simple path",
        depends = "gravel_ordinary",
    }

end

function unilib.pkg.misc_heap_gravel.exec()

    unilib.register_node("unilib:misc_heap_gravel", "forest:gravel_way", mode, {
        -- From forest:gravel_way
        description = S("Gravel Heap"),
        tiles = {
            "unilib_misc_heap_gravel.png",
            "unilib_misc_heap_gravel_curve.png",
            "unilib_misc_heap_gravel_junction.png",
            "unilib_misc_heap_gravel_crossing.png",
        },
        -- N.B. way = 1 in original code, omitted here
        groups = {dig_immediate = 3},
        sounds = unilib.global.sound_table.sand,

        drawtype = "raillike",
        inventory_image = "unilib_misc_heap_gravel_inv.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
        },
        wield_image = "unilib_misc_heap_gravel_inv.png",
        walkable = false,
    })
    unilib.register_craft_3x3({
        -- From forest:sand_way
        output = "unilib:gravel_ordinary",
        ingredient = "unilib:misc_heap_gravel",
    })
    unilib.register_craft({
        -- From forest:sand_way
        output = "unilib:misc_heap_gravel 9",
        recipe = {
            {"unilib:gravel_ordinary"},
        },
    })

end
