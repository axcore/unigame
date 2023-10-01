---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_silver_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_silver_real.init()

    return {
        description = "Real silver",
        depends = "mineral_silver_native",
    }

end

function unilib.pkg.metal_silver_real.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "silver_real",
        description = S("Real Silver"),

        hardness = 2,
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_silver_real_powder
        orig_name = nil,
        metal_part_name = "silver_real",
        mineral_part_name = "silver_native",

        replace_mode = mode,
        description = S("Real Silver Powder"),
    })

    unilib.register_craftitem(
        -- From real_minerals:silver_ingot
        "unilib:metal_silver_real_ingot",
        "real_minerals:silver_ingot",
        mode,
        {
            description = S("Real Silver Ingot"),
            inventory_image = "unilib_metal_silver_real_ingot.png",
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From real_minerals:silver_ingot
        type = "cooking",
        output = "unilib:metal_silver_real_ingot",
        recipe = "unilib:mineral_silver_native_lump",

        cooktime = 5,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_silver_real_ingot 9",
        recipe = {
            {"unilib:metal_silver_real_block"},
        }
    })

    unilib.register_node("unilib:metal_silver_real_block", "real_minerals:silver_block", mode, {
        -- From real_minerals:silver_block
        description = S("Real Silver Block"),
        tiles = {"unilib_metal_silver_real_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:silver_block
        output = "unilib:metal_silver_real_block",
        ingredient = "unilib:metal_silver_real_ingot",
    })
    unilib.register_stairs("unilib:metal_silver_real_block")

end
