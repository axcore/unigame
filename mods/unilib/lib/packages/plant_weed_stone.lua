---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_weed_stone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_weed_stone.init()

    return {
        description = "Stone weed",
    }

end

function unilib.pkg.plant_weed_stone.exec()

    unilib.register_node("unilib:plant_weed_stone", "moreplants:stoneweed", mode, {
        -- From moreplants:stoneweed
        description = S("Stone Weed"),
        tiles = {"unilib_plant_weed_stone.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_weed_stone.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_weed_stone", "moreplants:stoneweed")

    unilib.register_decoration_generic("moreplants_plant_weed_stone", {
        -- From moreplants:stoneweed
        deco_type = "simple",
        decoration = "unilib:plant_weed_stone",

        fill_ratio = 0.001,
        height = 1,
        sidelen = 16,
    })

end
