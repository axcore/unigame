---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_tumbaga = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_tumbaga.init()

    return {
        description = "Tumbaga",
        depends = {"metal_copper_real", "metal_gold_real"},
    }

end

function unilib.pkg.metal_tumbaga.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "tumbaga",
        description = S("Tumbaga"),

        alloy_flag = true,
        hardness = 1,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_tumbaga_powder
        part_name = "tumbaga",
        orig_name = nil,

        replace_mode = mode,
        description = S("Tumbaga Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_tumbaga_ingot", "real_minerals:tumbaga_ingot", mode, {
        -- From real_minerals:tumbaga_ingot
        description = S("Tumbaga Ingot"),
        inventory_image = "unilib_metal_tumbaga_ingot.png",
        -- N.B. alloy = 1 not in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:tumbaga_ingot
        type = "shapeless",
        output = "unilib:metal_tumbaga_ingot 2",
        recipe = {
            "unilib:metal_copper_real_ingot",
            "unilib:metal_gold_real_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_tumbaga_ingot 9",
        recipe = {
            {"unilib:metal_tumbaga_block"},
        }
    })

    unilib.register_node("unilib:metal_tumbaga_block", "real_minerals:tumbaga_block", mode, {
        -- From real_minerals:tumbaga_block
        description = S("Tumbaga Block"),
        tiles = {"unilib_metal_tumbaga_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:tumbaga_block
        output = "unilib:metal_tumbaga_block",
        ingredient = "unilib:metal_tumbaga_ingot",
    })
    unilib.register_stairs("unilib:metal_tumbaga_block")

end
