---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_garlic_porcelain_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_garlic_porcelain_wild.init()

    return {
        description = "Wild porcelain garlic plant",
        depends = "crop_garlic_porcelain",
    }

end

function unilib.pkg.plant_garlic_porcelain_wild.exec()

    unilib.register_node("unilib:plant_garlic_porcelain_wild", "cropocalypse:garlic_wild", mode, {
        -- From cropocalypse:garlic_wild
        description =
            unilib.annotate(S("Wild Porcelain Garlic Plant"), "Allium sativum var. ophioscorodon"),
        tiles = {"unilib_plant_garlic_porcelain_wild.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, flammable = 4, flora = 1, not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:crop_garlic_porcelain_seed",
        inventory_image = "unilib_plant_garlic_porcelain_wild.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_garlic_porcelain_wild.png",
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("cropocalypse_plant_garlic_porcelain_wild", {
        -- From cropocalypse/plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_garlic_porcelain_wild",

        noise_params = {
            offset = -0.1,
            scale = 0.1,
            spread = {x = 50, y = 50, z = 50},
            seed = 9277,
            octaves = 3,
            persist = 0.7
        },
        sidelen = 16,
    })

end
