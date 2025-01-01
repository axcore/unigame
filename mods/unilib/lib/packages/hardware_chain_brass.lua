---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hardware_chain_brass = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hardware_chain_brass.init()

    return {
        description = "Brass chain",
        depends = "hardware_chainlink_brass",
    }

end

function unilib.pkg.hardware_chain_brass.exec()

    unilib.register_node(
        -- From basic_materials:chain_brass
        "unilib:hardware_chain_brass",
        {"basic_materials:chain_brass", "chains:chain_brass"},
        mode,
        {
            description = S("Hanging Brass Chain"),
            tiles = {"unilib_hardware_chain_brass.png"},
            groups = {cracky = 3},
            -- (no sounds)

            climbable = true,
            drawtype = "mesh",
            inventory_image = "unilib_hardware_chain_brass_inv.png",
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
        -- From basic_materials:chain_brass
        output = "unilib:hardware_chain_brass 2",
        recipe = {
            {"unilib:hardware_chainlink_brass"},
            {"unilib:hardware_chainlink_brass"},
            {"unilib:hardware_chainlink_brass"},
        },
    })

end
