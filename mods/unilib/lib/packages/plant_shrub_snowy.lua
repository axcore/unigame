---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_snowy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_snowy.init()

    return {
        description = "Showy grass shrub",
    }

end

function unilib.pkg.plant_shrub_snowy.exec()

    unilib.register_node("unilib:plant_shrub_snowy", "ethereal:snowygrass", mode, {
        -- From ethereal:snowygrass
        description = S("Snowy Grass Shrub"),
        tiles = {"unilib_plant_shrub_snowy.png"},
        groups = {attached_node = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_shrub_snowy.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 5 / 16, 5 / 16}
        },
        sunlight_propagates = true,
        visual_scale = 0.9,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_shrub_snowy.png",
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_snowy", "ethereal:snowygrass")

    unilib.register_decoration("ethereal_plant_shrub_snowy", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_snowy",

        fill_ratio = 0.05,
        sidelen = 80,
    })

end
