---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.material_wax_palm = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.material_wax_palm.init()

    return {
        description = "Palm wax",
        notes = "Used to craft candles",
        depends = "tree_palm",
    }

end

function unilib.pkg.material_wax_palm.exec()

    unilib.register_craftitem("unilib:material_wax_palm", "ethereal:palm_wax", mode, {
        -- From ethereal:palm_wax
        description = S("Palm Wax"),
        inventory_image = "unilib_material_wax_palm.png",

        wield_image = "unilib_material_wax_palm.png"
    })
    unilib.register_craft({
        -- From ethereal:palm_wax
        type = "cooking",
        output = "unilib:material_wax_palm",
        recipe = "unilib:tree_palm_leaves",
        cooktime = 10,
    })

end
