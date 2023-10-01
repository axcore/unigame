---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_bismuth = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_bismuth.init()

    return {
        description = "Bismuth",
        depends = "mineral_bismuthinite",
    }

end

function unilib.pkg.metal_bismuth.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "bismuth",
        description = S("Bismuth"),

        hardness = 1,
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_bismuth_powder
        orig_name = nil,
        metal_part_name = "bismuth",
        mineral_part_name = "bismuthinite",

        replace_mode = mode,
        description = S("Bismuth Powder"),
    })

    unilib.register_craftitem("unilib:metal_bismuth_ingot", "real_minerals:bismuth_ingot", mode, {
        -- From real_minerals:bismuth_ingot
        description = S("Bismuth Ingot"),
        inventory_image = "unilib_metal_bismuth_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:bismuth_ingot
        type = "cooking",
        output = "unilib:metal_bismuth_ingot",
        recipe = "unilib:mineral_bismuthinite_lump",

        cooktime = 5,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_bismuth_ingot 9",
        recipe = {
            {"unilib:metal_bismuth_block"},
        }
    })

    unilib.register_node("unilib:metal_bismuth_block", "real_minerals:bismuth_block", mode, {
        -- From real_minerals:bismuth_block
        description = S("Bismuth Block"),
        tiles = {"unilib_metal_bismuth_block.png"},
        groups = {bendy = 2, cracky = 2, level = 0, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:bismuth_block
        output = "unilib:metal_bismuth_block",
        ingredient = "unilib:metal_bismuth_ingot",
    })
    unilib.register_stairs("unilib:metal_bismuth_block")

end
