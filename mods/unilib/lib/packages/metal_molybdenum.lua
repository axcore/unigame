---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_molybdenum = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_molybdenum.init()

    return {
        description = "Molybdenum",
    }

end

function unilib.pkg.metal_molybdenum.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "molybdenum",
        description = S("Molybdenum"),

        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_molybdenum_powder
        part_name = "molybdenum",
        orig_name = nil,

        replace_mode = mode,
        description = S("Molybdenum Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_molybdenum_ingot", nil, mode, {
        -- Original to unilib
        description = S("Molybdenum Ingot"),
        inventory_image = "unilib_metal_molybdenum_ingot.png",
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_molybdenum_ingot 9",
        recipe = {
            {"unilib:metal_molybdenum_block"},
        },
    })

    unilib.register_node("unilib:metal_molybdenum_block", nil, mode, {
        -- Original to unilib
        description = S("Molybdenum Block"),
        tiles = {"unilib_metal_molybdenum_block.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.metal,

        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- Original to unilib
        output = "unilib:metal_molybdenum_block",
        ingredient = "unilib:metal_molybdenum_ingot",
    })
    unilib.register_stairs("unilib:metal_molybdenum_block")
    unilib.register_carvings("unilib:metal_molybdenum_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_molybdenum_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Molybdenum Block"),
            tiles = {"unilib_metal_molybdenum_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("molybdenum")

    end

end
