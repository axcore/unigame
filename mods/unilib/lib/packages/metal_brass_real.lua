---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_brass_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_brass_real.init()

    return {
        description = "Real brass",
        depends = {"metal_copper_real", "metal_zinc_real"},
    }

end

function unilib.pkg.metal_brass_real.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "brass_real",
        description = S("Real Brass"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_brass_real_powder
        part_name = "brass_real",
        orig_name = nil,

        replace_mode = mode,
        description = S("Real Brass Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_brass_real_ingot", "real_minerals:brass_ingot", mode, {
        -- From real_minerals:brass_ingot
        description = S("Real Brass Ingot"),
        inventory_image = "unilib_metal_brass_real_ingot.png",
        -- N.B. alloy = 1 not in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:brass_ingot
        type = "shapeless",
        output = "unilib:metal_brass_real_ingot 4",
        recipe = {
            "unilib:metal_copper_real_ingot",
            "unilib:metal_copper_real_ingot",
            "unilib:metal_copper_real_ingot",
            "unilib:metal_zinc_real_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_brass_real_ingot 9",
        recipe = {
            {"unilib:metal_brass_real_block"},
        }
    })

    unilib.register_node("unilib:metal_brass_real_block", "real_minerals:brass_block", mode, {
        -- From real_minerals:brass_block
        description = S("Real Brass Block"),
        tiles = {"unilib_metal_brass_real_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:brass_block
        output = "unilib:metal_brass_real_block",
        ingredient = "unilib:metal_brass_real_ingot",
    })
    unilib.register_stairs("unilib:metal_brass_real_block")

end
