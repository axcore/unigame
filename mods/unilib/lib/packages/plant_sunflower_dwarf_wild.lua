---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_sunflower_dwarf_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_sunflower_dwarf_wild.init()

    return {
        description = "Wild dwarf sunflower plant",
        depends = "crop_sunflower_dwarf",
    }

end

function unilib.pkg.plant_sunflower_dwarf_wild.exec()

    unilib.register_node(
        -- From cucina_vegana:wild_sunflower
        "unilib:plant_sunflower_dwarf_wild",
        "cucina_vegana:wild_sunflower",
        mode,
        {
            description = unilib.utils.annotate(S("Wild Dwarf Sunflower Plant"), "Helianthus"),
            tiles = {"unilib_crop_sunflower_dwarf_grow_5.png"},
            -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
            groups = {
                attached_node = 1, dig_immediate = 1, flammable = 2, flora = 1,
                not_in_creative_inventory = 1, plant = 1, snappy = 3,
            },
            sounds = unilib.global.sound_table.leaves,

            drawtype = "plantlike",
            drop = {
                items = {
                    {items = {"unilib:crop_sunflower_dwarf_seed 2"}},
                    {items = {"unilib:crop_sunflower_dwarf_harvest"}},
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

    unilib.register_decoration_generic("cucina_vegana_plant_sunflower_dwarf_wild", {
        -- From cucina_vegana, sunflower.lua
        deco_type = "simple",
        decoration = "unilib:plant_sunflower_dwarf_wild",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.0007,
            seed = 8756,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
