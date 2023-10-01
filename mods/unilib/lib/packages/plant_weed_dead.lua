---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_weed_dead = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_weed_dead.init()

    return {
        description = "Dead weed",
    }

end

function unilib.pkg.plant_weed_dead.exec()

    unilib.register_node("unilib:plant_weed_dead", "moreplants:deadweed", mode, {
        -- From moreplants:deadweed
        description = S("Dead Weed"),
        tiles = {"unilib_plant_weed_dead.png"},
        -- N.B. removed flora = 1 to prevent spread
--      groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        groups = {attached_node = 1, flammable = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_weed_dead.png",
        is_ground_content = false,
        light_source = 2,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_weed_dead", "moreplants:deadweed")

    unilib.register_decoration("moreplants_plant_weed_dead", {
        -- From moreplants:deadweed
        deco_type = "simple",
        decoration = "unilib:plant_weed_dead",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 26,
    })

end
