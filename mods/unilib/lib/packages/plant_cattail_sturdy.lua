---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cattail_sturdy = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cattail_sturdy.init()

    return {
        description = "Sturdy cattail",
        optional = "dye_basic",
    }

end

function unilib.pkg.plant_cattail_sturdy.exec()

    unilib.register_node("unilib:plant_cattail_sturdy", "cropocalypse:cattail", mode, {
        -- From cropocalypse:cattail
        description = unilib.utils.annotate(S("Sturdy Cattail"), "Typha"),
        tiles = {"unilib_plant_cattail_sturdy.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, decorative_plants = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_cattail_sturdy.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_cattail_sturdy.png",
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:cattail
            output = "unilib:dye_brown 2",
            recipe = {
                {"unilib:plant_cattail_sturdy"},
            },
        })

    end
    unilib.register_plant_in_pot("unilib:plant_cattail_sturdy", "cropocalypse:cattail")

    unilib.register_decoration_generic("cropocalypse_plant_cattail_sturdy", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_cattail_sturdy",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 3726,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
