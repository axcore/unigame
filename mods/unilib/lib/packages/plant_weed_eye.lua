---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_weed_eye = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_weed_eye.init()

    return {
        description = "Eye weed",
    }

end

function unilib.pkg.plant_weed_eye.exec()

    unilib.register_node("unilib:plant_weed_eye", "moreplants:eyeweed", mode, {
        -- From moreplants:eyeweed
        description = S("Eye Weed"),
        tiles = {"unilib_plant_weed_eye.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:plant_weed_eye_ball",
        inventory_image = "unilib_plant_weed_eye.png",
        is_ground_content = false,
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
    -- (not compatible with flowerpots)

    unilib.register_craftitem("unilib:plant_weed_eye_ball", "moreplants:eye", mode, {
        -- From moreplants:eye
        description = S("Eyeball"),
        inventory_image = "unilib_plant_weed_eye_ball.png"
    })

    unilib.register_decoration("moreplants_plant_weed_eye", {
        -- From moreplants:eyeweed
        deco_type = "simple",
        decoration = "unilib:plant_weed_eye",

        fill_ratio = 0.005,
        height = 1,
        sidelen = 26,
    })

end
