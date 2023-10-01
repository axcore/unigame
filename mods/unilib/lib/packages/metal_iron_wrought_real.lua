---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_iron_wrought_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_iron_wrought_real.init()

    return {
        description = "Real wrought iron",
    }

end

function unilib.pkg.metal_iron_wrought_real.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "iron_wrought_real",
        description = S("Real Wrought Iron"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_craftitem(
        -- From real_minerals:wrought_iron_ingot
        "unilib:metal_iron_wrought_real_ingot",
        "real_minerals:wrought_iron_ingot",
        mode,
        {
            description = S("Real Wrought Iron Ingot"),
            inventory_image = "unilib_metal_iron_wrought_real_ingot.png",
            -- N.B. no groups in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    -- N.B. real_minerals does not provide a craft recipe for the ingot, so we are forced to insert
    --      this (extremely unrealistic) one
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_iron_wrought_real_ingot",
        recipe = {
            {"unilib:metal_iron_pig_ingot"},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_iron_wrought_real_ingot 9",
        recipe = {
            {"unilib:metal_iron_wrought_real_block"},
        },
    })

    unilib.register_node(
        -- From real_minerals:wrought_iron_block
        "unilib:metal_iron_wrought_real_block",
        "real_minerals:wrought_iron_block",
        mode,
        {
            description = S("Real Wrought Iron Block"),
            tiles = {"unilib_metal_iron_wrought_real_block.png"},
            groups = {bendy = 2, cracky = 2, level = 3, melty = 2, snappy = 1},
            sounds = unilib.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From real_minerals:wrought_iron_block
        output = "unilib:metal_iron_wrought_real_block",
        ingredient = "unilib:metal_iron_wrought_real_ingot",
    })
    unilib.register_stairs("unilib:metal_iron_wrought_real_block")

end
