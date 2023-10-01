---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_crystal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_crystal.init()

    return {
        description = "Crystal grass shrub",
    }

end

function unilib.pkg.plant_shrub_crystal.exec()

    unilib.register_node("unilib:plant_shrub_crystal", "ethereal:crystalgrass", mode, {
        -- From ethereal:crystalgrass
        description = S("Crystal Grass Shrub"),
        tiles = {"unilib_plant_shrub_crystal.png"},
        groups = {attached_node = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_shrub_crystal.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 5 / 16, 5 / 16}
        },
        sunlight_propagates = true,
        visual_scale = 0.9,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_shrub_crystal.png",
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_crystal", "ethereal:crystalgrass")

end
