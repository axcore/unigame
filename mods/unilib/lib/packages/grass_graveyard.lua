---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_graveyard = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_graveyard.init()

    return {
        description = "Graveyard grass",
    }

end

function unilib.pkg.grass_graveyard.exec()

    local full_name = "unilib:grass_graveyard"
    local drop = full_name
    if unilib.setting.disable_grass_drop_flag then
        drop = ""
    end

    unilib.register_node(full_name, "cropocalypse:undead_grass", mode, {
        -- From cropocalypse:undead_grass
        description = S("Graveyard Grass"),
        tiles = {"unilib_grass_graveyard.png"},
        -- N.B. flora = 1, grass = 1, graveyard_grass = 1 not in original code
        groups = {
            attached_node = 1, flammable = 1, flora = 1, grass = 1, grave_plants = 1,
            graveyard_grass = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        drop = drop,
        inventory_image = "unilib_grass_graveyard.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_graveyard.png",
    })
    unilib.register_plant_in_pot(full_name, "cropocalypse:undead_grass")

    unilib.register_decoration_generic("cropocalypse_grass_graveyard", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = full_name,

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.95,
            seed = 6177,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
