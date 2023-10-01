---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_canna = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_canna.init()

    return {
        description = "Canna flower",
    }

end

function unilib.pkg.flower_canna.exec()

    unilib.register_node("unilib:flower_canna", "moreplants:bigflower", mode, {
        -- From moreplants:bigflower
        description = unilib.annotate(S("Canna Flower"), "Canna"),
        tiles = {"unilib_flower_canna.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 1, flower = 1, snappy = 3},
        groups = {
            attached_node = 1, color_magenta = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_canna.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        visual_scale = 1.2,
        walkable = false,
        waving = 1,
        wield_scale = {x = 0.5, y = 0.5, z = 0.5},
    })
    unilib.register_flower_in_pot("unilib:flower_canna", "moreplants:bigflower")

    unilib.register_decoration("moreplants_flower_canna", {
        -- From moreplants:bigflower
        deco_type = "simple",
        decoration = "unilib:flower_canna",

        fill_ratio = 0.01,
        height = 1,
        sidelen = 16,
    })

end
