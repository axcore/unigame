---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_wheat_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_wheat_wild.init()

    return {
        description = "Wild wheat plant",
        optional = "crop_wheat",
    }

end

function unilib.pkg.plant_wheat_wild.exec()

    unilib.register_node("unilib:plant_wheat_wild", "cropocalypse:wild_wheat", mode, {
        -- From cropocalypse:wild_wheat
        description = unilib.utils.annotate(S("Wild Wheat"), "Triticum aestivum"),
        tiles = {"unilib_plant_wheat_wild.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, decorative_plants = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_wheat_wild.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_wheat_wild.png",
    })
    if unilib.global.pkg_executed_table["crop_wheat"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:wild_wheat
            type = "shapeless",
            output = "unilib:crop_wheat_harvest",
            recipe = {"unilib:plant_wheat_wild", "unilib:plant_wheat_wild"},
        })

    end
    unilib.register_plant_in_pot("unilib:plant_wheat_wild", "cropocalypse:wild_wheat")

    unilib.register_decoration_generic("cropocalypse_plant_wheat_wild", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_wheat_wild",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.35,
            seed = 6035,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
