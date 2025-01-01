---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_asparagus_white_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_asparagus_white_wild.init()

    return {
        description = "Wild white asparagus plant",
        depends = "crop_asparagus_white",
    }

end

function unilib.pkg.plant_asparagus_white_wild.exec()

    unilib.register_node(
        -- From cucina_vegana:wild_asparagus
        "unilib:plant_asparagus_white_wild",
        "cucina_vegana:wild_asparagus",
        mode,
        {
            description = unilib.utils.annotate(
                S("Wild White Asparagus Plant"), "Asparagus officinalis"
            ),
            tiles = {"unilib_crop_asparagus_white_grow_6.png"},
            -- N.B. flora = 1 not in original code
            groups = {
                attached_node = 1, dig_immediate = 1, flammable = 2, flora = 1,
                not_in_creative_inventory = 1, plant = 1, snappy = 3,
            },
            sounds = unilib.global.sound_table.leaves,

            drawtype = "plantlike",
            drop = {
                items = {
                    {items = {"unilib:crop_asparagus_white_seed 3"}},
                    {items = {"unilib:crop_asparagus_white_harvest"}},
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
        }
    )
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("cucina_vegana_plant_asparagus_white_wild", {
        -- From cucina_vegana, asparagus.lua
        deco_type = "simple",
        decoration = "unilib:plant_asparagus_white_wild",

        noise_params = {
            octaves = 4,
            offset = 0,
            persist = 0.6,
            scale = 0.0007,
            seed = 8164,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 32,
    })

end
