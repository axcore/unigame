---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_devils_club = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_devils_club.init()

    return {
        description = "Devil's club",
    }

end

function unilib.pkg.plant_devils_club.exec()

    unilib.register_node("unilib:plant_devils_club", "cropocalypse:devils_club", mode, {
        -- From cropocalypse:devils_club
        description = unilib.utils.annotate(S("Devil's Club"), "Oplopanax horridus"),
        tiles = {"unilib_plant_devils_club.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 1, flora = 1, grave_plants = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_devils_club.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_devils_club.png",
    })
    unilib.register_plant_in_pot("unilib:plant_devils_club", "cropocalypse:devils_club")

    unilib.register_decoration_generic("cropocalypse_plant_devils_club", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_devils_club",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.2,
            seed = 6412,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
