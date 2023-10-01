---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_gold_rose = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_gold_rose.init()

    return {
        description = "Rose gold",
        depends = {"metal_brass_real", "metal_gold_real"},
    }

end

function unilib.pkg.metal_gold_rose.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "gold_rose",
        description = S("Rose Gold"),

        alloy_flag = true,
        hardness = 1,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_gold_rose_powder
        part_name = "gold_rose",
        orig_name = nil,

        replace_mode = mode,
        description = S("Rose Gold Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From real_minerals:rose_gold_ingot
        "unilib:metal_gold_rose_ingot",
        "real_minerals:rose_gold_ingot",
        mode,
        {
            description = S("Rose Gold Ingot"),
            inventory_image = "unilib_metal_gold_rose_ingot.png",
            -- N.B. alloy = 1 not in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From real_minerals:rose_gold_ingot
        type = "shapeless",
        output = "unilib:metal_gold_rose_ingot 4",
        recipe = {
            "unilib:metal_gold_real_ingot",
            "unilib:metal_gold_real_ingot",
            "unilib:metal_gold_real_ingot",
            "unilib:metal_brass_real_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_gold_rose_ingot 9",
        recipe = {
            {"unilib:metal_gold_rose_block"},
        }
    })

    unilib.register_node("unilib:metal_gold_rose_block", "real_minerals:rose_gold_block", mode, {
        -- From real_minerals:rose_gold_block
        description = S("Rose Gold Block"),
        tiles = {"unilib_metal_gold_rose_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:rose_gold_block
        output = "unilib:metal_gold_rose_block",
        ingredient = "unilib:metal_gold_rose_ingot",
    })
    unilib.register_stairs("unilib:metal_gold_rose_block")

end
