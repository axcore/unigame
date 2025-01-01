---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreplants
-- Code:    LGPL 2.1+
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.fern_spike = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moreplants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.fern_spike.init()

    return {
        description = "Spike fern",
    }

end

function unilib.pkg.fern_spike.exec()

    unilib.register_node("unilib:fern_spike", "moreplants:spikefern", mode, {
        -- From moreplants:spikefern
        description = S("Spike Fern"),
        tiles = {"unilib_fern_spike.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_fern_spike.png",
        -- N.B. removed is_ground_content = false to match other ferns
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
    unilib.register_plant_in_pot("unilib:fern_spike", "moreplants:spikefern")

    unilib.register_decoration_generic("moreplants_fern_spike", {
        -- From moreplants:spikefern
        deco_type = "simple",
        decoration = "unilib:fern_spike",

        fill_ratio = 0.02,
        height = 1,
        sidelen = 16,
    })

end
