---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    slime_cans
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_can_slime_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.slime_cans.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_can_slime_black.init()

    return {
        description = "Black slime can",
        mod_depends = "technic",
        depends = {"metal_steel_stainless", "metal_zinc", "stone_slimestone_black_extra"},
    }

end

function unilib.pkg.vessel_can_slime_black.exec()

    local S = technic.getter

    local c_steel = "unilib:metal_steel_stainless_ingot"
    local c_zinc = "unilib:metal_zinc_ingot"

    technic.register_can({
        -- From slime_cans:black_slime_can
        can_name = "unilib:vessel_can_slime_black",
        can_description = S("Black Slime Can"),
        can_inventory_image = "unilib_vessel_can_slime_black.png",
        can_capacity = 8,
        liquid_source_name = "unilib:liquid_slime_black_source",
        liquid_flowing_name = "unilib:liquid_slime_black_flowing",
    })
    unilib.register_craft({
        -- From slime_cans:black_slime_can
        output = "unilib:vessel_can_slime_black",
        recipe = {
            {c_zinc, c_steel, c_zinc},
            {c_steel, "unilib:stone_slimestone_black_eye", c_steel},
            {c_zinc, c_steel, c_zinc},
        },
    })

end
