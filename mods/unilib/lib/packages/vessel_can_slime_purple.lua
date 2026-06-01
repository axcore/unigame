---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    slime_cans
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_can_slime_purple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.slime_cans.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_can_slime_purple.init()

    return {
        description = "Purple slime can",
        mod_depends = "technic",
        depends = {"metal_steel_stainless", "metal_zinc", "stone_slimestone_purple_extra"},
    }

end

function unilib.pkg.vessel_can_slime_purple.exec()

    local S = technic.getter

    local c_steel = "unilib:metal_steel_stainless_ingot"
    local c_zinc = "unilib:metal_zinc_ingot"

    technic.register_can({
        -- From slime_cans:purple_slime_can
        can_name = "unilib:vessel_can_slime_purple",
        can_description = S("Purple Slime Can"),
        can_inventory_image = "unilib_vessel_can_slime_purple.png",
        can_capacity = 8,
        liquid_source_name = "unilib:liquid_slime_purple_source",
        liquid_flowing_name = "unilib:liquid_slime_purple_flowing",
    })
    unilib.register_craft({
        -- From slime_cans:purple_slime_can
        output = "unilib:vessel_can_slime_purple",
        recipe = {
            {c_zinc, c_steel, c_zinc},
            {c_steel, "unilib:stone_slimestone_purple_eye", c_steel},
            {c_zinc, c_steel, c_zinc},
        },
    })

end
