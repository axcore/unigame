---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_broad_leaf_young = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_broad_leaf_young.init()

    return {
        description = "Young broad leaf fern",
    }

end

function unilib.pkg.fern_broad_leaf_young.exec()

    unilib.register_node("unilib:fern_broad_leaf_young", "lib_ecology:fern_broadleaf_fern2", mode, {
        -- From GLEMr4, lib_ecology:fern_broadleaf_fern2
        description = S("Young Broad Leaf Fern"),
        tiles = {"unilib_fern_broad_leaf.png"},
        groups = {flammable = 1, flora = 1, oddly_breakable_by_hand = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_fern_broad_leaf.png",
        paramtype = "light",
        paramtype2 = "degrotate",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
    })
    unilib.register_plant_in_pot("unilib:fern_broad_leaf_young", "lib_ecology:fern_broadleaf_fern2")

end
