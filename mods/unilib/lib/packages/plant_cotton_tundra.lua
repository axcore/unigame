---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cotton_tundra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cotton_tundra.init()

    return {
        description = "Tundra cotton plant",
        optional = "crop_cotton",
    }

end

function unilib.pkg.plant_cotton_tundra.exec()

    unilib.register_node("unilib:plant_cotton_tundra", "cropocalypse:tundra_cotton", mode, {
        -- From cropocalypse:tundra_cotton
        -- N.B. No scientifica name, as it appears to be fictional
        description = S("Tundra Cotton"),
        tiles = {"unilib_plant_cotton_tundra.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, decorative_plants = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_cotton_tundra.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_cotton_tundra.png",
    })
    if unilib.pkg_executed_table["crop_cotton"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:tundra_cotton
            type = "shapeless",
            output = "unilib:crop_cotton_harvest",
            recipe = {"unilib:plant_cotton_tundra", "unilib:plant_cotton_tundra"}
        })

    end
    unilib.register_plant_in_pot("unilib:plant_cotton_tundra", "cropocalypse:tundra_cotton")

    unilib.register_decoration("cropocalypse_plant_cotton_tundra", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_cotton_tundra",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.35,
            seed = 3944,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
