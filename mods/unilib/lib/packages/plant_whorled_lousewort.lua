---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_whorled_lousewort = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_whorled_lousewort.init()

    return {
        description = "Whorled lousewort",
        optional = "dye_basic",
    }

end

function unilib.pkg.plant_whorled_lousewort.exec()

    unilib.register_node("unilib:plant_whorled_lousewort", "cropocalypse:whorled_lousewort", mode, {
        -- From cropocalypse:whorled_lousewort
        description = unilib.annotate(S("Whorled Lousewort"), "Pedicularis verticillata"),
        tiles = {"unilib_plant_whorled_lousewort.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, decorative_plants = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_whorled_lousewort.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_whorled_lousewort.png",
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:whorled_lousewort
            output = "unilib:dye_pink 2",
            recipe = {
                {"unilib:plant_whorled_lousewort"},
            },
        })

    end
    unilib.register_plant_in_pot("unilib:plant_whorled_lousewort", "cropocalypse:whorled_lousewort")

    unilib.register_decoration("cropocalypse_plant_whorled_lousewort", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_whorled_lousewort",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 6758,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
