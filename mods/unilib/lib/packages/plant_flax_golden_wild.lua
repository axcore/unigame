---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_flax_golden_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_flax_golden_wild.init()

    return {
        description = "Wild golden flax plant",
        depends = "crop_flax_golden",
    }

end

function unilib.pkg.plant_flax_golden_wild.exec()

    unilib.register_node("unilib:plant_flax_golden_wild", "cucina_vegana:wild_flax", mode, {
        -- From cucina_vegana:wild_flax
        description = unilib.annotate(S("Wild Golden Flax Plant"), "Linum usitatissimum"),
        tiles = {"unilib_crop_flax_golden_grow_6.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, dig_immediate = 1, flammable = 2, flora = 1,
            not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:crop_flax_golden_seed 4"}},
                {items = {"unilib:crop_flax_golden_harvest 2"}},
            },
        },
        -- N.B. Not in original code
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.35, 0.5},
            },
        },
        sunlight_propagates = true,
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("cucina_vegana_plant_flax_golden_wild", {
        -- From cucina_vegana, flax.lua
        deco_type = "simple",
        decoration = "unilib:plant_flax_golden_wild",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.0006,
            seed = 6357,
            spread = {x = 70, y = 70, z = 70},
        },
        sidelen = 16,
    })

end
