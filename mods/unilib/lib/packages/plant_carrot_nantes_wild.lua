---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_carrot_nantes_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_carrot_nantes_wild.init()

    return {
        description = "Wild nantes carrot plant",
        depends = "crop_carrot_nantes",
    }

end

function unilib.pkg.plant_carrot_nantes_wild.exec()

    unilib.register_node("unilib:plant_carrot_nantes_wild", "cucina_vegana:wild_carrot", mode, {
        -- From cucina_vegana:wild_carrot
        description = unilib.annotate(S("Wild Nantes Carrot Plant"), "Daucus carota sativus"),
        tiles = {"unilib_crop_carrot_nantes_grow_6.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, dig_immediate = 1, flammable = 2, flora = 1,
            not_in_creative_inventory = 1, plant = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        drop = {
            items = {
                {items = {"unilib:crop_carrot_nantes_seed 4"}},
                {items = {"unilib:crop_carrot_nantes_harvest 3"}},
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

    unilib.register_decoration("cucina_vegana_plant_carrot_nantes_wild", {
        -- From cucina_vegana, carrot.lua
        deco_type = "simple",
        decoration = "unilib:plant_carrot_nantes_wild",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.0005,
            seed = 16387,
            spread = {x = 70, y = 70, z = 70},
        },
        sidelen = 16,
    })

end
