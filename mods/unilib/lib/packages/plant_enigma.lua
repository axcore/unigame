---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_enigma = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_enigma.init()

    return {
        description = "Enigma plant",
    }

end

function unilib.pkg.plant_enigma.exec()

    unilib.register_node("unilib:plant_enigma", "moreplants:aliengrass", mode, {
        -- From moreplants:aliengrass
        description = S("Enigma Plant"),
        tiles = {"unilib_plant_enigma.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_enigma.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.54,
        walkable = false,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_enigma", "moreplants:aliengrass")

    unilib.register_decoration("moreplants_plant_enigma", {
        -- From moreplants:aliengrass
        deco_type = "simple",
        decoration = "unilib:plant_enigma",

        fill_ratio = 0.005,
        height = 1,
        place_offset_y = 1,
        sidelen = 16,
    })

end
