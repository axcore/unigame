---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_onion_sweet_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_onion_sweet_wild.init()

    return {
        description = "Wild sweet onion plant",
        depends = "crop_onion_sweet",
    }

end

function unilib.pkg.plant_onion_sweet_wild.exec()

    unilib.register_node("unilib:plant_onion_sweet_wild", "cucina_vegana:wild_onion", mode, {
        -- From cucina_vegana:wild_onion
        description = unilib.utils.annotate(S("Wild Sweet Onion Plant"), "Allium cepa"),
        tiles = {"unilib_crop_onion_sweet_grow_7.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, dig_immediate = 1, flammable = 2, flora = 1,
            not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:crop_onion_sweet_seed 4"}},
                {items = {"unilib:crop_onion_sweet_harvest 2"}},
            },
        },
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

    unilib.register_decoration_generic("cucina_vegana_plant_onion_sweet_wild", {
        -- From cucina_vegana, onion.lua
        deco_type = "simple",
        decoration = "unilib:plant_onion_sweet_wild",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.0006,
            seed = 7346,
            spread = {x = 70, y = 70, z = 70},
        },
        sidelen = 16,
    })

end
