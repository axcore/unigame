---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chain_steel = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chain_steel.init()

    return {
        description = "Steel chain",
        depends = "metal_steel",
    }

end

function unilib.pkg.chain_steel.exec()

    unilib.register_craftitem(
        -- From basic_materials:chainlink_steel
        "unilib:chain_steel_link",
        {"basic_materials:chainlink_steel", "glooptest:chainlink"},
        mode,
        {
            description = S("Steel Chainlinks"),
            inventory_image = "unilib_chain_steel_link.png",
            groups = {chainlinks = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:chainlink_steel
        output = "unilib:chain_steel_link 12",
        recipe = {
            {"", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", ""},
        },
    })

    unilib.register_node("unilib:chain_steel", "basic_materials:chain_steel", mode, {
        -- From basic_materials:chain_steel
        description = S("Hanging Steel Chain"),
        tiles = {"unilib_chain_steel.png"},
        groups = {cracky = 3},
        -- (no sounds)

        climbable = true,
        drawtype = "mesh",
        inventory_image = "unilib_chain_steel_inv.png",
        mesh = "unilib_chain_metal_basic.obj",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_craft({
        -- From basic_materials:chain_steel
        output = "unilib:chain_steel 2",
        recipe = {
            {"unilib:chain_steel_link"},
            {"unilib:chain_steel_link"},
            {"unilib:chain_steel_link"},
        }
    })

end
