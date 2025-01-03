---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_monel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_monel.init()

    return {
        description = "Monel",
        depends = {"metal_copper_rare", "metal_nickel"},
    }

end

function unilib.pkg.metal_monel.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "monel",
        description = S("Monel"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_monel_powder
        part_name = "monel",
        orig_name = nil,

        replace_mode = mode,
        description = S("Monel Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem("unilib:metal_monel_ingot", "real_minerals:monel_ingot", mode, {
        -- From real_minerals:monel_ingot
        description = S("Monel Ingot"),
        inventory_image = "unilib_metal_monel_ingot.png",
        -- N.B. no groups in original code
        groups = {alloy = 1, metal_ingot = 1},
    })
    unilib.register_craft({
        -- From real_minerals:monel_ingot
        type = "shapeless",
        output = "unilib:metal_monel_ingot 4",
        recipe = {
            "unilib:metal_nickel_ingot",
            "unilib:metal_nickel_ingot",
            "unilib:metal_nickel_ingot",
            "unilib:metal_copper_rare_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_monel_ingot 9",
        recipe = {
            {"unilib:metal_monel_block"},
        },
    })

    unilib.register_node("unilib:metal_monel_block", "real_minerals:monel_block", mode, {
        -- From real_minerals:monel_block
        description = S("Monel Block"),
        tiles = {"unilib_metal_monel_block.png"},
        -- N.B. level = 4 in original code; reduced to 3 because only admin-restricted unilib tools
        --      can dig level = 4
        groups = {bendy = 2, cracky = 2, level = 3, melty = 2, snappy = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From real_minerals:monel_block
        output = "unilib:metal_monel_block",
        ingredient = "unilib:metal_monel_ingot",
    })
    unilib.register_stairs("unilib:metal_monel_block")
    unilib.register_carvings("unilib:metal_monel_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_monel_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Monel Block"),
            tiles = {"unilib_metal_monel_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("monel")

    end

end
