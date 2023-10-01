---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chain_brass = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.basic_materials.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chain_brass.init()

    return {
        description = "Brass chain",
        depends = "metal_brass",
    }

end

function unilib.pkg.chain_brass.exec()

    unilib.register_craftitem(
        -- From basic_materials:chainlink_brass
        "unilib:chain_brass_link",
        "basic_materials:chainlink_brass",
        mode,
        {
            description = S("Brass Chainlinks"),
            inventory_image = "unilib_chain_brass_link.png",
            groups = {chainlinks = 1},
        }
    )
    unilib.register_craft({
        -- From basic_materials:chainlink_brass
        output = "unilib:chain_brass_link 12",
        recipe = {
            {"", "unilib:metal_brass_ingot", "unilib:metal_brass_ingot"},
            {"unilib:metal_brass_ingot", "", "unilib:metal_brass_ingot"},
            {"unilib:metal_brass_ingot", "unilib:metal_brass_ingot", ""},
        },
    })

    unilib.register_node("unilib:chain_brass", "basic_materials:chain_brass", mode, {
        -- From basic_materials:chain_brass
        description = S("Hanging Brass Chain"),
        tiles = {"unilib_chain_brass.png"},
        groups = {cracky = 3},
        -- (no sounds)

        climbable = true,
        drawtype = "mesh",
        inventory_image = "unilib_chain_brass_inv.png",
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
        -- From basic_materials:chain_brass
        output = "unilib:chain_brass 2",
        recipe = {
            {"unilib:chain_brass_link"},
            {"unilib:chain_brass_link"},
            {"unilib:chain_brass_link"},
        }
    })

end
