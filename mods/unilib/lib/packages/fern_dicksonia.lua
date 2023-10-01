---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_dicksonia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_dicksonia.init()

    return {
        description = "Dicksonia",
    }

end

function unilib.pkg.fern_dicksonia.exec()

    unilib.register_node("unilib:fern_dicksonia", "mapgen:dicksonia", mode, {
        -- From farlands, mapgen:dicksonia
        description = unilib.annotate(S("Dicksonia"), "Dicksonia"),
        tiles = {"unilib_fern_dicksonia.png"},
        -- N.B. attached_node = 1, flora = 1 not in original code
        groups = {attached_node = 1, choppy = 1, flora = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.sound_table.wood,

        collision_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
        },
        drawtype = "mesh",
        mesh = "unilib_fern_dicksonia.b3d",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
        },
        use_texture_alpha = "clip",
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("farlands_fern_dicksonia", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:fern_dicksonia",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
