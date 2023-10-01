---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_pink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_pink.init()

    return {
        description = "Pink mushroom",
    }

end

function unilib.pkg.mushroom_pink.exec()

    unilib.register_node("unilib:mushroom_pink", "moreplants:mushroom", mode, {
        -- From moreplants:mushroom
        description = S("Pink Mushroom"),
        tiles = {
            "unilib_mushroom_pink_top.png",
            "unilib_mushroom_pink_top.png",
            "unilib_mushroom_pink_side.png",
            "unilib_mushroom_pink_side.png",
            "unilib_mushroom_pink_side.png",
            "unilib_mushroom_pink_side.png"
        },
        -- N.B. mushroom = 1 not in original code
        groups = {attached_node = 1, flammable = 1, flora = 1, mushroom = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        is_ground_content = false,
        light_source = 2,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.0625, -0.5, -0.0625, 0.0625, -0.3125, 0.0625},
                {-0.1875, -0.3125, -0.1875, 0.1875, -0.1875, 0.1875},
                {-0.125, -0.1875, -0.125, 0.125, -0.125, 0.125},
            }
        },
        paramtype = "light",
        sunlight_propagates = true,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("moreplants_mushroom_pink", {
        -- From moreplants:mushroom
        deco_type = "simple",
        decoration = "unilib:mushroom_pink",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
