---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_real.init()

    return {
        description = "Real steel",
        depends = {"metal_iron_wrought_real", "metal_iron_pig"},
    }

end

function unilib.pkg.metal_steel_real.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "steel_real",
        description = S("Real Steel"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_steel_real_powder
        part_name = "steel_real",
        orig_name = nil,

        replace_mode = mode,
        description = S("Real Steel Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_steel_real_ingot", "real_minerals:steel_ingot", mode, {
        -- From real_minerals:steel_real_ingot
        description = S("Real Steal Ingot"),
        inventory_image = "unilib_metal_steel_ingot.png",
        -- N.B. alloy = 1 not in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:steel_real_ingot
        type = "shapeless",
        output = "unilib:metal_steel_real_ingot 4",
        recipe = {
            "unilib:metal_iron_wrought_real_ingot",
            "unilib:metal_iron_wrought_real_ingot",
            "unilib:metal_iron_wrought_real_ingot",
            "unilib:metal_iron_pig_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_steel_real_ingot 9",
        recipe = {
            {"unilib:metal_steel_real_block"},
        }
    })

    unilib.register_node("unilib:metal_steel_real_block", "real_minerals:steel_block", mode, {
        -- From real_minerals:steel_real_block
        description = S("Real Steal Block"),
        tiles = {"unilib_metal_steel_block.png"},
        groups = {bendy = 2, cracky = 2, level = 4, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:steel_block
        output = "unilib:metal_steel_real_block",
        ingredient = "unilib:metal_steel_real_ingot",
    })
    unilib.register_stairs("unilib:metal_steel_real_block")

end
