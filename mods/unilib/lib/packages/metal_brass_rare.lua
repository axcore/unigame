---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_brass_rare = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_brass_rare.init()

    return {
        description = "Rare brass",
        depends = {"metal_copper_rare", "metal_zinc_rare"},
    }

end

function unilib.pkg.metal_brass_rare.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "brass_rare",
        description = S("Rare Brass"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_brass_rare_powder
        part_name = "brass_rare",
        orig_name = nil,

        replace_mode = mode,
        description = S("Rare Brass Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_brass_rare_ingot", "real_minerals:brass_ingot", mode, {
        -- From real_minerals:brass_ingot
        description = S("Rare Brass Ingot"),
        inventory_image = "unilib_metal_brass_rare_ingot.png",
        -- N.B. alloy = 1 not in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:brass_ingot
        type = "shapeless",
        output = "unilib:metal_brass_rare_ingot 4",
        recipe = {
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_zinc_rare_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_brass_rare_ingot 9",
        recipe = {
            {"unilib:metal_brass_rare_block"},
        },
    })

    unilib.register_node("unilib:metal_brass_rare_block", "real_minerals:brass_block", mode, {
        -- From real_minerals:brass_block
        description = S("Rare Brass Block"),
        tiles = {"unilib_metal_brass_rare_block.png"},
        groups = {bendy = 2, cracky = 2, level = 2, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:brass_block
        output = "unilib:metal_brass_rare_block",
        ingredient = "unilib:metal_brass_rare_ingot",
    })
    unilib.register_stairs("unilib:metal_brass_rare_block")
    unilib.register_carvings("unilib:metal_brass_rare_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_brass_rare_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Rare Brass Block"),
            tiles = {"unilib_metal_brass_rare_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("brass_rare")

    end

end
