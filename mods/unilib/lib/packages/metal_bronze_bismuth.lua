---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_bronze_bismuth = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_bronze_bismuth.init()

    return {
        description = "Bismuth bronze",
        depends = {"metal_bismuth", "metal_copper_real", "metal_tin_real"},
    }

end

function unilib.pkg.metal_bronze_bismuth.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "bronze_bismuth",
        description = S("Bismuth Bronze"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_bronze_bismuth_powder
        part_name = "bronze_bismuth",
        orig_name = nil,

        replace_mode = mode,
        description = S("Bismuth Bronze Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From real_minerals:bismuth_bronze_ingot
        "unilib:metal_bronze_bismuth_ingot",
        "real_minerals:bismuth_bronze_ingot",
        mode,
        {
            description = S("Bismuth Bronze Ingot"),
            inventory_image = "unilib_metal_bronze_bismuth_ingot.png",
            -- N.B. alloy = 1 not in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From real_minerals:bismuth_bronze_ingot
        type = "shapeless",
        output = "unilib:metal_bronze_bismuth_ingot 4",
        recipe = {
            "unilib:metal_copper_real_ingot",
            "unilib:metal_copper_real_ingot",
            "unilib:metal_bismuth_ingot",
            "unilib:metal_tin_real_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_bronze_bismuth_ingot 9",
        recipe = {
            {"unilib:metal_bronze_bismuth_block"},
        }
    })

    unilib.register_node(
        -- From real_minerals:bismuth_bronze_block
        "unilib:metal_bronze_bismuth_block",
        "real_minerals:bismuth_bronze_block",
        mode,
        {
            description = S("Bismuth Bronze Block"),
            tiles = {"unilib_metal_bronze_bismuth_block.png"},
            groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
            sounds = unilib.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From real_minerals:bismuth_bronze_block
        output = "unilib:metal_bronze_bismuth_block",
        ingredient = "unilib:metal_bronze_bismuth_ingot",
    })
    unilib.register_stairs("unilib:metal_bronze_bismuth_block")

end
