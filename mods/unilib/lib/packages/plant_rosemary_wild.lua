---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_rosemary_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_rosemary_wild.init()

    return {
        description = "Wild rosemary plant",
        depends = "crop_rosemary",
    }

end

function unilib.pkg.plant_rosemary_wild.exec()

    unilib.register_node("unilib:plant_rosemary_wild", "cucina_vegana:wild_rosemary", mode, {
        -- From cucina_vegana:wild_rosemary
        description = unilib.utils.annotate(S("Wild Rosemary Plant"), "Salvia rosmarinus"),
        tiles = {"unilib_crop_rosemary_grow_6.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, dig_immediate = 1, flammable = 2, flora = 1,
            not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:crop_rosemary_seed 3"}},
                {items = {"unilib:crop_rosemary_harvest"}},
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

    unilib.register_decoration_generic("cucina_vegana_plant_rosemary_wild", {
        -- From cucina_vegana, rosemary.lua
        deco_type = "simple",
        decoration = "unilib:plant_rosemary_wild",

        height = 1,
        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.3,
            scale = 0.0008,
            seed = 264,
            spread = {x = 30, y = 30, z = 30},
        },
        sidelen = 16,
    })

end
