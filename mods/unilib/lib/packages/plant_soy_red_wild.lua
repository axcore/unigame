---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_soy_red_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_soy_red_wild.init()

    return {
        description = "Wild red soy plant",
        depends = "crop_soy_red",
    }

end

function unilib.pkg.plant_soy_red_wild.exec()

    unilib.register_node("unilib:plant_soy_red_wild", "cucina_vegana:wild_soy", mode, {
        -- From cucina_vegana:wild_soy
        description = unilib.annotate(S("Wild Red Soy Plant"), "Glycine max"),
        tiles = {"unilib_crop_soy_red_grow_8.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, choppy = 2, dig_immediate = 1, flammable = 2, flora = 1,
            not_in_creative_inventory = 1, oddly_breakable_by_hand = 3, plant = 1,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:crop_soy_red_seed 3"}},
                {items = {"unilib:crop_soy_red_harvest"}},
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

    unilib.register_decoration("cucina_vegana_plant_soy_red_wild", {
        -- From cucina_vegana, soy.lua
        deco_type = "simple",
        decoration = "unilib:plant_soy_red_wild",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.0007,
            seed = 32478,
            spread = {x = 100, y = 100, z = 100},
        },
        sidelen = 16,
    })

end
