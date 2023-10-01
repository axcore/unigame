---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_horsetail_broad_leaf = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_horsetail_broad_leaf.init()

    return {
        description = "Broad leaf horsetail fern",
    }

end

function unilib.pkg.fern_horsetail_broad_leaf.exec()

    unilib.register_node(
        -- From GLEMr4, lib_ecology:fern_horsetail_02
        "unilib:fern_horsetail_broad_leaf",
        "lib_ecology:fern_horsetail_02",
        mode,
        {
            description = unilib.annotate(S("Broad Leaf Horsetail Fern"), "Equisetum arvense"),
            tiles = {"unilib_fern_horsetail_large.png"},
            groups = {flammable = 1, flora = 1, oddly_breakable_by_hand = 1, snappy = 3},
            sounds = unilib.sound_table.leaves,

            buildable_to = true,
            drawtype = "mesh",
            -- N.B. floodable no longer required, because of unilib's flooding effects
--          floodable = true,
            mesh = "unilib_plant_shrub_banana_large.b3d",
            paramtype = "light",
            paramtype2 = "degrotate",
            selection_box = {
                type = "fixed",
                fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
            },
            use_texture_alpha = "clip",
            walkable = false,
            waving = 1,
        }
    )
    -- (not compatible with flowerpots)

end
