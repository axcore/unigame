---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_oroide = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_oroide.init()

    return {
        description = "Oroide",
        depends = {"metal_copper_rare", "metal_tin_rare", "metal_zinc_rare"},
    }

end

function unilib.pkg.metal_oroide.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "oroide",
        description = S("Oroide"),

        alloy_flag = true,
        hardness = 1,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_oroide_powder
        part_name = "oroide",
        orig_name = nil,

        replace_mode = mode,
        description = S("Oroide Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_oroide_ingot", "real_minerals:oroide_ingot", mode, {
        -- From real_minerals:oroide_ingot
        description = S("Oroide Ingot"),
        inventory_image = "unilib_metal_oroide_ingot.png",
        -- N.B. no groups in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:oroide_ingot
        type = "shapeless",
        output = "unilib:metal_oroide_ingot 4",
        recipe = {
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_tin_rare_ingot",
            "unilib:metal_zinc_rare_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_oroide_ingot 9",
        recipe = {
            {"unilib:metal_oroide_block"},
        },
    })

    unilib.register_node("unilib:metal_oroide_block", "real_minerals:oroide_block", mode, {
        -- From real_minerals:oroide_block
        description = S("Oroide Block"),
        tiles = {"unilib_metal_oroide_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:oroide_block
        output = "unilib:metal_oroide_block",
        ingredient = "unilib:metal_oroide_ingot",
    })
    unilib.register_stairs("unilib:metal_oroide_block")
    unilib.register_carvings("unilib:metal_oroide_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_oroide_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Oroide Block"),
            tiles = {"unilib_metal_oroide_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("oroide")

    end

end
