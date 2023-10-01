---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_shrub_dry_fiery = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_shrub_dry_fiery.init()

    return {
        description = "Fiery dry shrub",
        notes = "Not flammable",
    }

end

function unilib.pkg.plant_shrub_dry_fiery.exec()

    unilib.register_node("unilib:plant_shrub_dry_fiery", "ethereal:dry_shrub", mode, {
        -- From ethereal:dry_shrub
        description = S("Fiery Dry Shrub"),
        tiles = {"unilib_plant_shrub_dry_fiery.png"},
        groups = {attached_node = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_shrub_dry_fiery.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 4 / 16, 5 / 16}
        },
        sunlight_propagates = true,
        walkable = false,
        waving = 1,
        wield_image = "unilib_plant_shrub_dry_fiery.png",
    })
    unilib.register_plant_in_pot("unilib:plant_shrub_dry_fiery", "ethereal:dry_shrub")

    unilib.register_decoration("ethereal_plant_shrub_dry_fiery", {
        -- From ethereal-ng/decor.lua
        deco_type = "simple",
        decoration = "unilib:plant_shrub_dry_fiery",

        fill_ratio = 0.1,
        sidelen = 80,
    })

end
