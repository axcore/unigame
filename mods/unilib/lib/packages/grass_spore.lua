---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_spore = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_spore.init()

    return {
        description = "Spore grass",
    }

end

function unilib.pkg.grass_spore.exec()

    unilib.register_node("unilib:grass_spore", "ethereal:spore_grass", mode, {
        -- From ethereal:spore_grass
        description = S("Spore Grass"),
        tiles = {"unilib_grass_spore.png"},
        groups = {attached_node = 1, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_grass_spore.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 4 / 16, 5 / 16},
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_grass_spore.png",
    })

    unilib.register_decoration_generic("ethereal_grass_spore", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:grass_spore",

        fill_ratio = 0.1,
        sidelen = 80,
    })

end
