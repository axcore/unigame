---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_bronze_rare = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_bronze_rare.init()

    return {
        description = "Rare bronze",
        depends = {"metal_copper_rare", "metal_tin_rare"},
    }

end

function unilib.pkg.metal_bronze_rare.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "bronze_rare",
        description = S("Rare Bronze"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_bronze_rare_powder
        part_name = "bronze_rare",
        orig_name = nil,

        replace_mode = mode,
        description = S("Rare Bronze Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From real_minerals:bronze_ingot
        "unilib:metal_bronze_rare_ingot",
        "real_minerals:bronze_ingot",
        mode,
        {
            description = S("Rare Bronze Ingot"),
            inventory_image = "unilib_metal_bronze_rare_ingot.png",
            -- N.B. alloy = 1 not in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From real_minerals:bronze_ingot
        type = "shapeless",
        output = "unilib:metal_bronze_rare_ingot 4",
        recipe = {
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_tin_rare_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_bronze_rare_ingot 9",
        recipe = {
            {"unilib:metal_bronze_rare_block"},
        },
    })

    unilib.register_node("unilib:metal_bronze_rare_block", "real_minerals:bronze_block", mode, {
        -- From real_minerals:bronze_block
        description = S("Rare Bronze Block"),
        tiles = {"unilib_metal_bronze_rare_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:bronze_block
        output = "unilib:metal_bronze_rare_block",
        ingredient = "unilib:metal_bronze_rare_ingot",
    })
    unilib.register_stairs("unilib:metal_bronze_rare_block")
    unilib.register_carvings("unilib:metal_bronze_rare_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_bronze_rare_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Rare Bronze Block"),
            tiles = {"unilib_metal_bronze_rare_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("bronze_rare")

    end

end
