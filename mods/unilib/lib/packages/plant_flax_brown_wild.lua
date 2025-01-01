---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_flax_brown_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_flax_brown_wild.init()

    return {
        description = "Wild brown flax plant",
        depends = "crop_flax_brown",
    }

end

function unilib.pkg.plant_flax_brown_wild.exec()

    unilib.register_node("unilib:plant_flax_brown_wild", "cropocalypse:flax_wild", mode, {
        -- From cropocalypse:flax_wild
        description = unilib.utils.annotate(S("Wild Brown Flax Plant"), "Linum usitatissimum"),
        tiles = {"unilib_plant_flax_brown_wild.png"},
        -- N.B. flora = 1, not_in_creative_inventory = 1 not in original code
        groups = {
            attached_node = 1, flammable = 4, flora = 1, not_in_creative_inventory = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = "unilib:crop_flax_brown_seed",
        inventory_image = "unilib_plant_flax_brown_wild.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_flax_brown_wild.png",
    })
    -- (not compatible with flowerpots)

    unilib.register_decoration_generic("cropocalypse_plant_flax_brown_wild", {
        -- From cropocalypse/plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_flax_brown_wild",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.2,
            seed = 7408,
            spread = {x = 50, y = 50, z = 50},
        },
        sidelen = 16,
    })

end
