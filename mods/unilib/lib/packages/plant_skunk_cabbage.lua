---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_skunk_cabbage = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_skunk_cabbage.init()

    return {
        description = "Skunk cabbage (plant)",
        optional = "dye_basic",
    }

end

function unilib.pkg.plant_skunk_cabbage.exec()

    unilib.register_node("unilib:plant_skunk_cabbage", "cropocalypse:skunk_cabbage", mode, {
        -- From cropocalypse:skunk_cabbage
        description = unilib.annotate(S("Skunk Cabbage"), "Lysichiton americanus"),
        tiles = {"unilib_plant_skunk_cabbage.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, decorative_plants = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_skunk_cabbage.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_skunk_cabbage.png",
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:skunk_cabbage
            output = "unilib:dye_yellow 2",
            recipe = {
                {"unilib:plant_skunk_cabbage"},
            },
        })

    end
    unilib.register_plant_in_pot("unilib:plant_skunk_cabbage", "cropocalypse:skunk_cabbage")

    unilib.register_decoration("cropocalypse_plant_skunk_cabbage", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:plant_skunk_cabbage",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 4907,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
