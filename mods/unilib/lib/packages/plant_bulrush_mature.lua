---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bulrush_mature = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bulrush_mature.init()

    return {
        description = "Mature bulrush",
    }

end

function unilib.pkg.plant_bulrush_mature.exec()

    unilib.register_node("unilib:plant_bulrush_mature", "moreplants:bulrush", mode, {
        -- From moreplants:bulrush
        description = unilib.annotate(S("Mature Bulrush"), "Typha"),
        tiles = {"unilib_plant_bulrush_mature.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_bulrush_mature.png",
        is_ground_content = false,
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
    unilib.register_plant_in_pot("unilib:plant_bulrush_mature", "moreplants:bulrush")

    unilib.register_decoration("moreplants_plant_bulrush_mature", {
        -- From moreplants:bulrush
        deco_type = "simple",
        decoration = "unilib:plant_bulrush_mature",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
