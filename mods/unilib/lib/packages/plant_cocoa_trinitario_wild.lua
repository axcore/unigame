---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cocoa_trinitario_wild = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cocoa_trinitario_wild.init()

    return {
        description = "Wild trinitario cocoa plant",
        depends = "crop_cocoa_trinitario",
    }

end

function unilib.pkg.plant_cocoa_trinitario_wild.exec()

    unilib.register_node("unilib:plant_cocoa_trinitario_wild", "cropocalypse:cocao_wild", mode, {
        -- From cropocalypse:cocao_wild
        description = unilib.annotate(S("Wild Trinitario Cocoa Plant"), "Theobroma cacao"),
        tiles = {"unilib_plant_cocoa_trinitario_wild.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, flammable = 4, flora = 1, not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:crop_cocoa_trinitario_seed",
        inventory_image = "unilib_plant_cocoa_trinitario_wild.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        visual_scale = 3,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_cocoa_trinitario_wild.png",
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration("cropocalypse_plant_cocoa_trinitario_wild", {
        -- From cropocalypse/plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_cocoa_trinitario_wild",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 6820,
            spread = {x = 50, y = 50, z = 50},
        },
        sidelen = 16,
    })

end
