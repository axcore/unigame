---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bells_of_ireland = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bells_of_ireland.init()

    return {
        description = "Bells of Ireland",
        optional = "dye_basic",
    }

end

function unilib.pkg.plant_bells_of_ireland.exec()

    unilib.register_node("unilib:plant_bells_of_ireland", "cropocalypse:bells_of_ireland", mode, {
        -- From cropocalypse:bells_of_ireland
        description = unilib.utils.annotate(S("Bells of Ireland"), "Moluccella laevis"),
        tiles = {"unilib_plant_bells_of_ireland.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, decorative_plants = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_bells_of_ireland.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_bells_of_ireland.png",
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:bells_of_ireland
            output = "unilib:dye_green 2",
            recipe = {
                {"unilib:plant_bells_of_ireland"},
            },
        })

    end
    unilib.register_plant_in_pot("unilib:plant_bells_of_ireland", "cropocalypse:bells_of_ireland")

    unilib.register_decoration_generic("cropocalypse_plant_bells_of_ireland", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_bells_of_ireland",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 4066,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
