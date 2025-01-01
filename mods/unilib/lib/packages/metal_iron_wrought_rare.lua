---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_iron_wrought_rare = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_iron_wrought_rare.init()

    return {
        description = "Rare wrought iron",
    }

end

function unilib.pkg.metal_iron_wrought_rare.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "iron_wrought_rare",
        description = S("Rare Wrought Iron"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_craftitem(
        -- From real_minerals:wrought_iron_ingot
        "unilib:metal_iron_wrought_rare_ingot",
        "real_minerals:wrought_iron_ingot",
        mode,
        {
            description = S("Rare Wrought Iron Ingot"),
            inventory_image = "unilib_metal_iron_wrought_rare_ingot.png",
            -- N.B. no groups in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    -- N.B. real_minerals does not provide a craft recipe for the ingot, so we are forced to insert
    --      this (extremely unrealistic) one
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_iron_wrought_rare_ingot",
        recipe = {
            {"unilib:metal_iron_pig_ingot"},
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_iron_wrought_rare_ingot 9",
        recipe = {
            {"unilib:metal_iron_wrought_rare_block"},
        },
    })

    unilib.register_node(
        -- From real_minerals:wrought_iron_block
        "unilib:metal_iron_wrought_rare_block",
        "real_minerals:wrought_iron_block",
        mode,
        {
            description = S("Rare Wrought Iron Block"),
            tiles = {"unilib_metal_iron_wrought_rare_block.png"},
            groups = {bendy = 2, cracky = 2, level = 3, melty = 2, snappy = 1},
            sounds = unilib.global.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From real_minerals:wrought_iron_block
        output = "unilib:metal_iron_wrought_rare_block",
        ingredient = "unilib:metal_iron_wrought_rare_ingot",
    })
    unilib.register_stairs("unilib:metal_iron_wrought_rare_block")
    unilib.register_carvings("unilib:metal_iron_wrought_rare_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_iron_wrought_rare_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Rare Wrought Iron Block"),
            tiles = {"unilib_metal_iron_wrought_rare_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("iron_wrought_rare")

    end

end
