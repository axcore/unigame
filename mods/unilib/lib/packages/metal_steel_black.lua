---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    real_minerals
-- Code:    GPL 3.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_steel_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.real_minerals.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_steel_black.init()

    return {
        description = "Black steel",
        depends = {"metal_bronze_black", "metal_steel_rare", "metal_nickel"},
    }

end

function unilib.pkg.metal_steel_black.exec()

    unilib.register_metal({
        -- Original to unilib
        part_name = "steel_black",
        description = S("Black Steel"),

        alloy_flag = true,
        hardness = 2,
    })

    unilib.register_metal_powder({
        -- Original to unilib. Creates unilib:metal_steel_black_powder
        part_name = "steel_black",
        orig_name = nil,

        replace_mode = mode,
        description = S("Black Steel Powder"),
        no_lump_flag = true,
    })

    unilib.register_craftitem(
        -- From real_minerals:black_steel_ingot
        "unilib:metal_steel_black_ingot",
        "real_minerals:black_steel_ingot",
        mode,
        {
            description = S("Black Steel Ingot"),
            inventory_image = "unilib_metal_steel_black_ingot.png",
            -- N.B. alloy = 1 not in original code
            groups = {alloy = 1, metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From real_minerals:black_steel_ingot
        type = "shapeless",
        output = "unilib:metal_steel_black_ingot 4",
        recipe = {
            "unilib:metal_steel_rare_ingot",
            "unilib:metal_steel_rare_ingot",
            "unilib:metal_nickel_ingot",
            "unilib:metal_bronze_black_ingot",
        },
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:metal_steel_black_ingot 9",
        recipe = {
            {"unilib:metal_steel_black_block"},
        },
    })

    unilib.register_node(
        -- From real_minerals:black_steel_block
        "unilib:metal_steel_black_block",
        "real_minerals:black_steel_block",
        mode,
        {
            description = S("Black Steel Block"),
            tiles = {"unilib_metal_steel_black_block.png"},
            -- N.B. level = 5 in original code; reduced to 3 because only admin-restricted unilib
            --      tools can dig level = 5
            groups = {bendy = 2, cracky = 2, level = 3, melty = 2, snappy = 1},
            sounds = unilib.global.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3({
        -- From real_minerals:black_steel_block
        output = "unilib:metal_steel_black_block",
        ingredient = "unilib:metal_steel_black_ingot",
    })
    unilib.register_stairs("unilib:metal_steel_black_block")
    unilib.register_carvings("unilib:metal_steel_black_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_steel_black_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Black Steel Block"),
            tiles = {"unilib_metal_steel_black_block_compressed.png"},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("steel_black")

    end

end
