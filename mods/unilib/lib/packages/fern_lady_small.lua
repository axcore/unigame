---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_lady_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_lady_small.init()

    return {
        description = "Small lady fern",
    }

end

function unilib.pkg.fern_lady_small.exec()

    unilib.register_node("unilib:fern_lady_small", "lib_ecology:fern_ladyfern2", mode, {
        -- From GLEMr4, lib_ecology:fern_ladyfern2
        description = unilib.annotate(S("Small Lady Fern"), "Athyrium filix-femina"),
        tiles = {"unilib_fern_lady.png"},
        groups = {flammable = 1, flora = 1, oddly_breakable_by_hand = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--      floodable = true,
        -- N.B. inventory_image not in original code
        inventory_image = "unilib_fern_lady.png",
        paramtype = "light",
        paramtype2 = "degrotate",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3},
        },
        use_texture_alpha = "clip",
        visual_scale = 1.0,
        walkable = false,
        waving = 1,
    })
    unilib.register_plant_in_pot("unilib:fern_lady_small", "lib_ecology:fern_ladyfern2")

end
