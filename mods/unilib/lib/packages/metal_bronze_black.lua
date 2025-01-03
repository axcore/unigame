---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_bronze_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_bronze_black.init()

    return {
        description = "Black bronze",
        depends = {"metal_copper_rare", "metal_gold_rare", "metal_silver_rare"},
    }

end

function unilib.pkg.metal_bronze_black.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "bronze_black",
        description = S("Black Bronze"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_bronze_black_powder
        part_name = "bronze_black",
        orig_name = nil,

        replace_mode = mode,
        description = S("Black Bronze Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From real_minerals:black_bronze_ingot
        "unilib:metal_bronze_black_ingot",
        "real_minerals:black_bronze_ingot",
        mode,
        {
            description = S("Black Bronze Ingot"),
            inventory_image = "unilib_metal_bronze_black_ingot.png",
            -- N.B. alloy = 1 not in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From real_minerals:black_bronze_ingot
        type = "shapeless",
        output = "unilib:metal_bronze_black_ingot 4",
        recipe = {
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_gold_rare_ingot",
            "unilib:metal_silver_rare_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_bronze_black_ingot 9",
        recipe = {
            {"unilib:metal_bronze_black_block"},
        },
    })

    unilib.register_node(
        -- From real_minerals:black_bronze_block
        "unilib:metal_bronze_black_block",
        "real_minerals:black_bronze_block",
        mode,
        {
            description = S("Black Bronze Block"),
            tiles = {"unilib_metal_bronze_black_block.png"},
            groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
            sounds = unilib.global.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From real_minerals:black_bronze_block
        output = "unilib:metal_bronze_black_block",
        ingredient = "unilib:metal_bronze_black_ingot",
    })
    unilib.register_stairs("unilib:metal_bronze_black_block")
    unilib.register_carvings("unilib:metal_bronze_black_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_bronze_black_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Black Bronze Block"),
            tiles = {"unilib_metal_bronze_black_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("bronze_black")

    end

end
