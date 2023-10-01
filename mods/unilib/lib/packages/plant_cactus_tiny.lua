---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_tiny = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_tiny.init()

    return {
        description = "Tiny cactus",
        optional = "plant_cactus_ordinary",
    }

end

function unilib.pkg.plant_cactus_tiny.exec()

    unilib.register_node("unilib:plant_cactus_tiny", "moreplants:cactus", mode, {
        -- From moreplants:cactus
        description = S("Tiny Cactus"),
        tiles = {"unilib_plant_cactus_tiny.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        damage_per_second = 1,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_cactus_tiny.png",
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
    })
    if unilib.pkg_executed_table["plant_cactus_ordinary"] ~= nil then

        unilib.register_craft_3x3({
            -- From moreplants:cactus
            output = "unilib:plant_cactus_ordinary",
            ingredient = "unilib:plant_cactus_tiny",
        })

    end
    unilib.register_plant_in_pot("unilib:plant_cactus_tiny", "moreplants:cactus")

    unilib.register_decoration("moreplants_plant_cactus_tiny", {
        -- From moreplants:cactus
        deco_type = "simple",
        decoration = "unilib:plant_cactus_tiny",

        fill_ratio = 0.005,
        height = 1,
        sidelen = 26,
    })

end
