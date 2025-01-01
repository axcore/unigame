---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_kohlrabi_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_kohlrabi_wild.init()

    return {
        description = "Wild kohlrabi plant",
        depends = "crop_kohlrabi",
    }

end

function unilib.pkg.plant_kohlrabi_wild.exec()

    unilib.register_node("unilib:plant_kohlrabi_wild", "cucina_vegana:wild_kohlrabi", mode, {
        -- From cucina_vegana:wild_kohlrabi
        description = unilib.utils.annotate(S("Wild Kohlrabi Plant"), "Brassica oleracea"),
        tiles = {"unilib_crop_kohlrabi_grow_6.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, dig_immediate = 1, flammable = 2, flora = 1,
            not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:crop_kohlrabi_seed 3"}},
                {items = {"unilib:crop_kohlrabi_harvest"}},
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

    unilib.register_decoration_generic("cucina_vegana_plant_kohlrabi_wild", {
        -- From cucina_vegana, kohlrabi.lua
        deco_type = "simple",
        decoration = "unilib:plant_kohlrabi_wild",

        noise_params = {
            octaves = 4,
            offset = 0,
            persist = 0.6,
            scale = 0.0007,
            seed = 2197,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
