---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_lily_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_lily_white.init()

    return {
        description = "White lily",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_lily_white.exec()

    unilib.register_node("unilib:flower_lily_white", "cropocalypse:white_lily", mode, {
        -- From cropocalypse:white_lily
        description = unilib.annotate(S("White Lily"), "Lilium"),
        tiles = {"unilib_flower_lily_white.png"},
        -- N.B. Replaced original groups with standard flower groups
--      groups = {attached_node = 1, decorative_plants = 1, flammable = 1, snappy = 3},
        groups = {
            attached_node = 1, color_white = 1, flammable = 1, flora = 1, flower = 1, snappy = 3,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_lily_white.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_lily_white.png",
    })
    if unilib.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From cropocalypse:white_lily
            output = "unilib:dye_white 2",
            recipe = {
                {"unilib:flower_lily_white"},
            },
        })

    end
    unilib.register_flower_in_pot("unilib:flower_lily_white", "cropocalypse:white_lily")

    unilib.register_decoration("cropocalypse_flower_lily_white", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_lily_white",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 7156,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
