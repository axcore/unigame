---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_chain_steel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_chain_steel.init()

    return {
        description = "Steel chain",
        depends = "hardware_chainlink_steel",
        optional = "material_scrap_steel",
    }

end

function unilib.pkg.hardware_chain_steel.exec()

    unilib.register_node(
        -- From basic_materials:chain_steel
        "unilib:hardware_chain_steel",
        {"basic_materials:chain_steel", "chains:chain"},
        mode,
        {
            description = S("Hanging Steel Chain"),
            tiles = {"unilib_hardware_chain_steel.png"},
            groups = {cracky = 3},
            -- (no sounds)

            climbable = true,
            drawtype = "mesh",
            inventory_image = "unilib_hardware_chain_steel_inv.png",
            -- N.B. no .is_ground_content in original code
            is_ground_content = false,
            mesh = "unilib_chain_metal_basic.obj",
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
            },
            sunlight_propagates = true,
            walkable = false,
        }
    )
    unilib.register_craft({
        -- From basic_materials:chain_steel
        output = "unilib:hardware_chain_steel 2",
        recipe = {
            {"unilib:hardware_chainlink_steel"},
            {"unilib:hardware_chainlink_steel"},
            {"unilib:hardware_chainlink_steel"},
        },
    })
    if unilib.global.pkg_executed_table["material_scrap_steel"] ~= nil then

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:material_scrap_steel",
            recipe = {
                {"unilib:hardware_chain_steel"},
            },
        })

    end

end
