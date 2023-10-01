---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_gold_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_gold_real.init()

    return {
        description = "Real gold",
        depends = "mineral_gold_native",
    }

end

function unilib.pkg.metal_gold_real.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "gold_real",
        description = S("Real Gold"),

        hardness = 2,
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_gold_real_powder
        orig_name = nil,
        metal_part_name = "gold_real",
        mineral_part_name = "gold_native",

        replace_mode = mode,
        description = S("Real Gold Powder"),
    })

    unilib.register_craftitem("unilib:metal_gold_real_ingot", "real_minerals:gold_ingot", mode, {
        -- From real_minerals:gold_ingot
        description = S("Real Gold Ingot"),
        inventory_image = "unilib_metal_gold_real_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:gold_ingot
        type = "cooking",
        output = "unilib:metal_gold_real_ingot",
        recipe = "unilib:mineral_gold_native_lump",

        cooktime = 5,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_gold_real_ingot 9",
        recipe = {
            {"unilib:metal_gold_real_block"},
        }
    })

    unilib.register_node("unilib:metal_gold_real_block", "real_minerals:gold_block", mode, {
        -- From real_minerals:gold_block
        description = S("Real Gold Block"),
        tiles = {"unilib_metal_gold_real_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:gold_block
        output = "unilib:metal_gold_real_block",
        ingredient = "unilib:metal_gold_real_ingot",
    })
    unilib.register_stairs("unilib:metal_gold_real_block")

end
