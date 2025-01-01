---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_chives_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_chives_wild.init()

    return {
        description = "Wild chives plant",
        depends = "crop_chives",
    }

end

function unilib.pkg.plant_chives_wild.exec()

    unilib.register_node("unilib:plant_chives_wild", "cucina_vegana:wild_chives", mode, {
        -- From cucina_vegana:wild_chives
        description = unilib.utils.annotate(S("Wild Chives Plant"), "Allium schoenoprasum"),
        tiles = {"unilib_crop_chives_grow_5.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, dig_immediate = 1, flammable = 2, flora = 1,
            not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:crop_chives_seed 3"}},
                {items = {"unilib:crop_chives_harvest"}},
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

    unilib.register_decoration_generic("cucina_vegana_plant_chives_wild", {
        -- From cucina_vegana, chives.lua
        deco_type = "simple",
        decoration = "unilib:plant_chives_wild",

        height = 1,
        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.0005,
            seed = 39454,
            spread = {x = 70, y = 70, z = 70},
        },
        sidelen = 16,
    })

end
