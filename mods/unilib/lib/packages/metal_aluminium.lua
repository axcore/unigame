---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_aluminium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_aluminium.init()

    return {
        description = "Aluminium",
        depends = "mineral_bauxite",
    }

end

function unilib.pkg.metal_aluminium.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "aluminium",
        description = S("Aluminium"),

        hardness = 1,
    })

    unilib.register_metal_powder_from_mineral({
        -- Original to unilib. Creates unilib:metal_aluminium_powder
        orig_name = nil,
        metal_part_name = "aluminium",
        mineral_part_name = "bauxite",

        replace_mode = mode,
        description = S("Aluminium Powder"),
    })

    unilib.register_craftitem(
        -- From real_minerals:aluminium_ingot
        "unilib:metal_aluminium_ingot",
        "real_minerals:aluminium_ingot",
        mode,
        {
            description = S("Aluminium Ingot"),
            inventory_image = "unilib_metal_aluminium_ingot.png",
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From real_minerals:aluminium_ingot
        type = "cooking",
        output = "unilib:metal_aluminium_ingot",
        recipe = "unilib:mineral_bauxite_lump",

        cooktime = 5,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_aluminium_ingot 9",
        recipe = {
            {"unilib:metal_aluminium_block"},
        },
    })

    unilib.register_node("unilib:metal_aluminium_block", "real_minerals:aluminium_block", mode, {
        -- From real_minerals:aluminium_block
        description = S("Aluminium Block"),
        tiles = {"unilib_metal_aluminium_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:aluminium_block
        output = "unilib:metal_aluminium_block",
        ingredient = "unilib:metal_aluminium_ingot",
    })
    unilib.register_stairs("unilib:metal_aluminium_block")
    unilib.register_carvings("unilib:metal_aluminium_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_aluminium_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Aluminium Block"),
            tiles = {"unilib_metal_aluminium_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("aluminium")

    end

end
