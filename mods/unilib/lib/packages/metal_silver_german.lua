---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_silver_german = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_silver_german.init()

    return {
        description = "German silver",
        depends = {"metal_copper_rare", "metal_nickel"},
    }

end

function unilib.pkg.metal_silver_german.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "silver_german",
        description = S("German Silver"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_silver_german_powder
        part_name = "silver_german",
        orig_name = nil,

        replace_mode = mode,
        description = S("German Silver Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From real_minerals:german_silver_ingot
        "unilib:metal_silver_german_ingot",
        "real_minerals:german_silver_ingot",
        mode,
        {
            description = S("German Silver Ingot"),
            inventory_image = "unilib_metal_silver_german_ingot.png",
            -- N.B. no groups in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From real_minerals:german_silver_ingot
        type = "shapeless",
        output = "unilib:metal_silver_german_ingot 4",
        recipe = {
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_copper_rare_ingot",
            "unilib:metal_nickel_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_silver_german_ingot 9",
        recipe = {
            {"unilib:metal_silver_german_block"},
        },
    })

    unilib.register_node(
        -- From real_minerals:german_silver_block
        "unilib:metal_silver_german_block",
        "real_minerals:german_silver_block",
        mode,
        {
            description = S("German Silver Block"),
            tiles = {"unilib_metal_silver_german_block.png"},
        -- N.B. level = 4 in original code; reduced to 3 because only admin-restricted unilib tools
        --      can dig level = 4
            groups = {bendy = 2, cracky = 2, level = 3, melty = 2, snappy = 1},
            sounds = unilib.global.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From real_minerals:german_silver_block
        output = "unilib:metal_silver_german_block",
        ingredient = "unilib:metal_silver_german_ingot",
    })
    unilib.register_stairs("unilib:metal_silver_german_block")
    unilib.register_carvings("unilib:metal_silver_german_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_silver_german_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed German Silver Block"),
            tiles = {"unilib_metal_silver_german_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("silver_german")

    end

end
