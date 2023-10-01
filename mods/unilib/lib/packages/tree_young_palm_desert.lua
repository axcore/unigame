---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_young_palm_desert = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_young_palm_desert.init()

    return {
        description = "Young desert palm tree",
    }

end

function unilib.pkg.tree_young_palm_desert.exec()

    unilib.register_node("unilib:tree_young_palm_desert", "lib_ecology:tree_desert_palm", mode, {
        -- From GLEMr4, lib_ecology:tree_desert_palm
        description = S("Young Desert Palm Tree"),
        tiles = {"unilib_tree_young_palm_desert.png"},
        groups = {attatched_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        -- N.B. floodable no longer required, because of unilib's flooding effects
--        floodable = true,
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 1, 0.2}
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })

end
