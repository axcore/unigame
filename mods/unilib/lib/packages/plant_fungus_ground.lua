---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_fungus_ground = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_fungus_ground.init()

    return {
        description = "Ground fungus",
    }

end

function unilib.pkg.plant_fungus_ground.exec()

    unilib.register_node("unilib:plant_fungus_ground", "moreplants:groundfung", mode, {
        -- From moreplants:groundfung
        description = S("Ground Fungus"),
        tiles = {
            "unilib_plant_fungus_ground.png",
            "blank.png",
            "unilib_plant_fungus_ground.png",
            "unilib_plant_fungus_ground.png",
            "unilib_plant_fungus_ground.png",
            "unilib_plant_fungus_ground.png"
        },
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "firelike",
        inventory_image = "unilib_plant_fungus_ground.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("moreplants_plant_fungus_ground", {
        -- From moreplants:groundfung
        deco_type = "simple",
        decoration = "unilib:plant_fungus_ground",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end
