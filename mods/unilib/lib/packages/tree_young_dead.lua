---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.tree_young_dead = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.tree_young_dead.init()

    return {
        description = "Dead young tree",
    }

end

function unilib.pkg.tree_young_dead.exec()

    unilib.register_node("unilib:tree_young_dead", "cropocalypse:dead_tree", mode, {
        -- From cropocalypse:dead_tree
        description = S("Dead Young Tree"),
        tiles = {"unilib_tree_young_dead.png"},
        groups = {attached_node = 1, flammable = 4, grave_plants = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_tree_young_dead.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        visual_scale = 3,
        walkable = false,
        waving = 1,
        wield_image = "unilib_tree_young_dead.png",
    })

    unilib.register_decoration("cropocalypse_tree_young_dead", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:tree_young_dead",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.2,
            seed = 6310,
            spread = {x = 50, y = 50, z = 50},
        },
        sidelen = 16,
    })

end
