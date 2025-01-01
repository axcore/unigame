---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_rose_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_rose_black.init()

    return {
        description = "Black rose",
    }

end

function unilib.pkg.flower_rose_black.exec()

    unilib.register_node("unilib:flower_rose_black", "cropocalypse:black_rose", mode, {
        -- From cropocalypse:black_rose
        description = unilib.utils.annotate(S("Black Rose"), "Rosa"),
        tiles = {"unilib_flower_rose_black.png"},
        -- N.B. Replaced original groups with standard flower groups, but preserved the
        --      grave_plants = 1 group
--      groups = {attached_node = 1, flammable = 1, grave_plants = 1, snappy = 3},
        groups = {
            attached_node = 1, color_black = 1, colour_black = 1, flammable = 1, flora = 1,
            flower = 1, grave_plants = 1, snappy = 3,
        },
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_flower_rose_black.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_flower_rose_black.png",
    })
    unilib.register_flower_in_pot("unilib:flower_rose_black", "cropocalypse:black_rose")

    unilib.register_decoration_generic("cropocalypse_flower_rose_black", {
        -- From cropocalypse/decorative_plants.lua
        deco_type = "simple",
        decoration = "unilib:flower_rose_black",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.2,
            seed = 8082,
            spread = {x = 10, y = 10, z = 10},
        },
        sidelen = 16,
    })

end
