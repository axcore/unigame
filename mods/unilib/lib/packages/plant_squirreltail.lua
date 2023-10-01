---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_squirreltail = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_squirreltail.init()

    return {
        description = "Squirreltail",
    }

end

function unilib.pkg.plant_squirreltail.exec()

    unilib.register_node("unilib:plant_squirreltail", "cropocalypse:squirrel_tail", mode, {
        -- From cropocalypse:squirrel_tail
        description = unilib.annotate(S("Squirreltail"), "Elymus elymoides"),
        tiles = {"unilib_plant_squirreltail.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, decorative_plants = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_squirreltail.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_squirreltail.png",
    })
    unilib.register_plant_in_pot("unilib:plant_squirreltail", "cropocalypse:squirrel_tail")

    unilib.register_decoration("cropocalypse_plant_squirreltail", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_squirreltail",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.35,
            seed = 8505,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
