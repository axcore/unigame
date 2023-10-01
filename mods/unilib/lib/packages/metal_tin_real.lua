---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_tin_real = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_tin_real.init()

    return {
        description = "Real tin",
        at_least_one = {"mineral_cassiterite", "mineral_tin_native"},
    }

end

function unilib.pkg.metal_tin_real.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "tin_real",
        description = S("Real Tin"),

        hardness = 2,
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_tin_real_powder
        orig_name = nil,
        metal_part_name = "tin_real",
        mineral_part_name = "cassiterite",

        replace_mode = mode,
        description = S("Real Tin Powder"),
    })

    unilib.register_craftitem("unilib:metal_tin_real_ingot", "real_minerals:tin_ingot", mode, {
        -- From real_minerals:tin_ingot
        description = S("Real Tin Ingot"),
        inventory_image = "unilib_metal_tin_real_ingot.png",
        groups = {metal_ingot = 1},
    })
    if unilib.pkg_executed_table["mineral_cassiterite"] ~= nil then

        unilib.register_craft({
            -- From real_minerals:tin_ingot
            type = "cooking",
            output = "unilib:metal_tin_real_ingot",
            recipe = "unilib:mineral_cassiterite_lump",

            cooktime = 5,
        })

    end
    if unilib.pkg_executed_table["mineral_tin_native"] ~= nil then

        unilib.register_craft({
            -- From real_minerals:tin_ingot
            type = "cooking",
            output = "unilib:metal_tin_real_ingot",
            recipe = "unilib:mineral_tin_native_lump",

            cooktime = 5,
        })

    end
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_tin_real_ingot 9",
        recipe = {
            {"unilib:metal_tin_real_block"},
        }
    })

    unilib.register_node("unilib:metal_tin_real_block", "real_minerals:tin_block", mode, {
        -- From real_minerals:tin_block
        description = S("Real Tin Block"),
        tiles = {"unilib_metal_tin_real_block.png"},
        groups = {bendy = 2, cracky = 2, level = 0, melty = 2, snappy = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:tin_block
        output = "unilib:metal_tin_real_block",
        ingredient = "unilib:metal_tin_real_ingot",
    })
    unilib.register_stairs("unilib:metal_tin_real_block")

end
