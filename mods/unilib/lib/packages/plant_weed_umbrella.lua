---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_weed_umbrella = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_weed_umbrella.init()

    return {
        description = "Umbrella weed",
    }

end

function unilib.pkg.plant_weed_umbrella.exec()

    unilib.register_node("unilib:plant_weed_umbrella", "moreplants:umbrella", mode, {
        -- From moreplants:umbrella
        description = unilib.annotate(S("Umbrella Weed"), "Cyperus alternifolius"),
        tiles = {"unilib_plant_weed_umbrella.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_weed_umbrella.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.3, -0.5, -0.3, 0.3, 3, 0.3},
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = true,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_weed_umbrella", "moreplants:umbrella")

    unilib.register_decoration("moreplants_plant_weed_umbrella", {
        -- From moreplants:umbrella
        deco_type = "simple",
        decoration = "unilib:plant_weed_umbrella",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
