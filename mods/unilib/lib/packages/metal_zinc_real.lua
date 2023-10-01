---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_zinc_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_zinc_real.init()

    return {
        description = "Real zinc",
        depends = "mineral_sphalerite",
    }

end

function unilib.pkg.metal_zinc_real.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "zinc_real",
        description = S("Real Zinc"),

        hardness = 1,
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_zinc_real_powder
        orig_name = nil,
        metal_part_name = "zinc_real",
        mineral_part_name = "sphalerite",

        replace_mode = mode,
        description = S("Real Zinc Powder"),
    })

    unilib.register_craftitem("unilib:metal_zinc_real_ingot", "real_minerals:zinc_ingot", mode, {
        -- From real_minerals:zinc_ingot
        description = S("Real Zinc Ingot"),
        inventory_image = "unilib_metal_zinc_real_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:zinc_ingot
        type = "cooking",
        output = "unilib:metal_zinc_real_ingot",
        recipe = "unilib:mineral_sphalerite_lump",

        cooktime = 5,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_zinc_real_ingot 9",
        recipe = {
            {"unilib:metal_zinc_real_block"},
        }
    })

    unilib.register_node("unilib:metal_zinc_real_block", "real_minerals:zinc_block", mode, {
        -- From real_minerals:zinc_block
        description = S("Real Zinc Block"),
        tiles = {"unilib_metal_zinc_real_block.png"},
        groups = {bendy = 2, cracky = 2, level = 0, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:zinc_block
        output = "unilib:metal_zinc_real_block",
        ingredient = "unilib:metal_zinc_real_ingot",
    })
    unilib.register_stairs("unilib:metal_zinc_real_block")

end
