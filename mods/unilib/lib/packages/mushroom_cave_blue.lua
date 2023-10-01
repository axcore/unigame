---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.mushroom_cave_blue = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mushroom_cave_blue.init()

    return {
        description = "Blue cave mushroom",
    }

end

function unilib.pkg.mushroom_cave_blue.exec()

    unilib.register_node("unilib:mushroom_cave_blue", "moreplants:bluemush", mode, {
        -- From moreplants:bluemush
        description = S("Blue Cave Mushroom"),
        tiles = {"unilib_mushroom_cave_blue.png"},
        -- N.B. food_mushroom = 1, mushroom = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, food_mushroom = 1, mushroom = 1,
            snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_mushroom_cave_blue.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},

        on_use = unilib.cuisine_eat_on_use("unilib:mushroom_cave_blue", 1),
    })
    unilib.register_mushroom_in_pot("unilib:mushroom_cave_blue", "moreplants:bluemush")

    unilib.register_decoration("moreplants_mushroom_cave_blue", {
        -- Original to unilib (but the "meta_moreplants_underground" package also spanws this item)
        deco_type = "simple",
        decoration = "unilib:mushroom_cave_blue",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
