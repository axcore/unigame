---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bulrush_small = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bulrush_small.init()

    return {
        description = "Small bulrush",
    }

end

function unilib.pkg.plant_bulrush_small.exec()

    unilib.register_node("unilib:plant_bulrush_small", "moreplants:bulrush", mode, {
        -- From moreplants:bulrush
        description = unilib.utils.annotate(S("Small Bulrush"), "Typha"),
        tiles = {"unilib_plant_bulrush_small.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_bulrush_small.png",
        -- N.B. removed is_ground_content = false to match other plants
--      is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.3,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_plant_in_pot("unilib:plant_bulrush_small", "moreplants:bulrush")

    unilib.register_decoration_generic("moreplants_plant_bulrush_small", {
        -- From moreplants:bulrush
        deco_type = "simple",
        decoration = "unilib:plant_bulrush_small",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
