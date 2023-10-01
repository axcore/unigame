---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_long = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_long.init()

    return {
        description = "Long grass",
    }

end

function unilib.pkg.grass_long.exec()

    unilib.register_node("unilib:grass_long", "moreplants:tallgrass", mode, {
        -- From moreplants:tallgrass
        description = S("Long Grass"),
        tiles = {"unilib_grass_long.png"},
        -- N.B. grass = 1, long_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, long_grass = 1, snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_grass_long.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.4,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:grass_long", "moreplants:tallgrass")

    unilib.register_decoration("moreplants_grass_long", {
        -- From moreplants:tallgrass
        deco_type = "simple",
        decoration = "unilib:grass_long",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
