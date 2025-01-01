---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_spike_blue = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_spike_blue.init()

    return {
        description = "Blue spikeflower",
    }

end

function unilib.pkg.flower_spike_blue.exec()

    unilib.register_node("unilib:flower_spike_blue", "moreplants:bluespike", mode, {
        -- From moreplants:bluespike
        description = S("Blue Spikeflower"),
        tiles = {"unilib_flower_spike_blue.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        groups = {
            attached_node = 1, color_blue = 1, colour_blue = 1, flammable = 1, flora = 1,
            flower = 1, snappy = 3,
        },
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_spike_blue.png",
        -- N.B. removed is_ground_content = false to match other flowers
--      is_ground_content = false,
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
    unilib.register_flower_in_pot("unilib:flower_spike_blue", "moreplants:bluespike")

    unilib.register_decoration_generic("moreplants_flower_spike_blue", {
        -- From moreplants:bluespike
        deco_type = "simple",
        decoration = "unilib:flower_spike_blue",

        fill_ratio = 0.002,
        height = 1,
        sidelen = 26,
    })

end
