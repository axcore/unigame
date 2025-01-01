---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_taiga = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_taiga.init()

    return {
        description = "Taiga plant",
    }

end

function unilib.pkg.plant_shrub_taiga.exec()

    unilib.register_node("unilib:plant_shrub_taiga", "moreplants:taigabush", mode, {
        -- From moreplants:taigabush
        description = S("Taiga Plant"),
        tiles = {"unilib_plant_shrub_taiga.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_shrub_taiga.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        light_source = 2,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 1,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_taiga", "moreplants:taigabush")

    unilib.register_decoration_generic("moreplants_plant_shrub_taiga", {
        -- From moreplants:taigabush
        deco_type = "simple",
        decoration = "unilib:plant_shrub_taiga",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 26,
    })

end
