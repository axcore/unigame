---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_iris_sturdy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_iris_sturdy.init()

    return {
        description = "Sturdy iris",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_iris_sturdy.exec()

    unilib.register_node("unilib:flower_iris_sturdy", "cropocalypse:iris", mode, {
        -- From cropocalypse:iris
        description = unilib.annotate(S("Sturdy Iris"), "Iris"),
        tiles = {"unilib_flower_iris_sturdy.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, decorative_plants = 1, flammable = 1, snappy = 3},
        groups = {
            attached_node = 1, color_violet = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_iris_sturdy.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_iris_sturdy.png",
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:iris
            output = "unilib:dye_violet 2",
            recipe = {
                {"unilib:flower_iris_sturdy"},
            },
        })

    end
    unilib.register_flower_in_pot("unilib:flower_iris_sturdy", "cropocalypse:iris")

    unilib.register_decoration("cropocalypse_flower_iris_sturdy", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_iris_sturdy",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 6584,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
