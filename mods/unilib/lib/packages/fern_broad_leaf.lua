---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_broad_leaf = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_broad_leaf.init()

    return {
        description = "Broad leaf fern",
    }

end

function unilib.pkg.fern_broad_leaf.exec()

    unilib.register_node("unilib:fern_broad_leaf", "mapgen:fern2", mode, {
        -- From farlands, mapgen:fern2
        description = S("Broad Leaf Fern"),
        tiles = {"unilib_fern_broad_leaf.png"},
        groups = {flammable = 1, flora = 1, oddly_breakable_by_hand = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "mesh",
        mesh = "unilib_fern_lady.b3d",
        paramtype = "light",
        paramtype2 = "degrotate",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3},
        },
        use_texture_alpha = "clip",
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("farlands_fern_broad_leaf", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:fern_broad_leaf",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end
