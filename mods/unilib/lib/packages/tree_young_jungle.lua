---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_young_jungle = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_young_jungle.init()

    return {
        description = "Young jungle tree",
    }

end

function unilib.pkg.tree_young_jungle.exec()

    unilib.register_node("unilib:tree_young_jungle", "mapgen:jungletree", mode, {
        -- From farlands, mapgen:jungletree
        description = S("Young Jungle Tree"),
        tiles = {"unilib_tree_young_jungle.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_tree_young_jungle.png",
        -- N.B. removed .is_ground_content to match other young tree packages
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 1, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })

    unilib.register_decoration_generic("farlands_tree_young_jungle", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:tree_young_jungle",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end
