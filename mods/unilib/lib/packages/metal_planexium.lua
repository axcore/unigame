---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_planexium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_planexium.init()

    return {
        description = "Planexium",
        optional = "item_screwdriver_ordinary",
    }

end

function unilib.pkg.metal_planexium.exec()

    local c_block = "unilib:metal_planexium_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

     unilib.register_metal({
        -- Original to unilib
        part_name = "planexium",
        description = S("Planexium"),

        fictional_flag = true,
        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_planexium_lump", "xtraores:platinum_lump", mode, {
        -- From xtraores:platinum_lump
        description = S("Planexium Lump"),
        inventory_image = "unilib_metal_planexium_lump.png"
    })

    unilib.register_metal_powder({
        -- From xtraores:platinum_dust. Creates unilib:metal_planexium_powder
        part_name = "planexium",
        orig_name = "xtraores:platinum_dust",

        replace_mode = mode,
        description = S("Planexium Powder"),
        lump_time = 5,
    })

    unilib.register_craftitem("unilib:metal_planexium_ingot", "xtraores:platinum_ingot", mode, {
        -- From xtraores:platinum_ingot
        description = S("Planexium Ingot"),
        inventory_image = "unilib_metal_planexium_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From xtraores:platinum_ingot
        type = "cooking",
        output = "unilib:metal_planexium_ingot",
        recipe = "unilib:metal_planexium_lump",
    })
    unilib.register_craft({
        -- From xtraores:platinum_ingot
        output = "unilib:metal_planexium_ingot 9",
        recipe = {
            {"unilib:metal_planexium_block"},
        },
    })

    unilib.register_node("unilib:metal_planexium_block", "xtraores:platinum_block", mode, {
        -- From xtraores:platinum_block
        description = S("Planexium Block"),
        tiles = {"unilib_metal_planexium_block.png"},
        -- N.B. level = 1 not in original code; added for consistency with other metal packages
        groups = {cracky = 2, level = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:platinum_block
        output = "unilib:metal_planexium_block",
        ingredient = "unilib:metal_planexium_ingot",
    })
    unilib.register_stairs("unilib:metal_planexium_block")
    unilib.register_carvings("unilib:metal_planexium_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node(
            -- From xtraores:platinum_block_compressed
            "unilib:metal_planexium_block_compressed",
            "xtraores:platinum_block_compressed",
            mode,
            {
                description = S("Compressed Planexium Block"),
                tiles = {"unilib_metal_planexium_block_compressed.png"},
                -- N.B. level = 1 not in original code; added for consistency with other metal
                --      packages
                groups = {cracky = 2, level = 1},
                sounds = unilib.global.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
                -- N.B. no .stack_max in original code
                stack_max = unilib.global.squeezed_stack_max,
            }
        )
        unilib.misc.set_compressed_metal_recipes("planexium")

    end

    if unilib.global.pkg_executed_table["item_screwdriver_ordinary"] ~= nil then

        unilib.register_node(
            -- From xtraores:platinum_block_chiseled
            "unilib:metal_planexium_block_chiselled",
            "xtraores:platinum_block_chiseled",
            mode,
            {
                description = S("Chiselled Planexium Block"),
                tiles = {"unilib_metal_planexium_block_chiselled.png"},
                -- N.B. level = 1 not in original code; added for consistency with other metal
                --      packages
                groups = {cracky = 2, level = 1},
                sounds = unilib.global.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From xtraores:platinum_block_chiseled
            output = "unilib:metal_planexium_block_chiselled 8",
            recipe = {
                {c_block, c_block, c_block},
                {c_block, c_screwdriver, c_block},
                {c_block, c_block, c_block},
            },
            replacements = {
                {c_screwdriver, c_screwdriver},
            },
        })
        unilib.register_stairs("unilib:metal_planexium_block_chiselled")

    end

    unilib.register_node("unilib:metal_planexium_brick", "xtraores:platinum_brick", mode, {
        -- From xtraores:platinum_brick
        description = S("Planexium Bricks"),
        tiles = {"unilib_metal_planexium_brick.png"},
        -- N.B. level = 1 not in original code; added for consistency with other metal packages
        groups = {cracky = 2, level = 1},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:platinum_brick
        output = "unilib:metal_planexium_brick",
        ingredient = "unilib:metal_planexium_ingot",
    })
    unilib.register_craft({
        -- From xtraores:platinum_brick
        output = "unilib:metal_planexium_ingot 4",
        recipe = {
            {"unilib:metal_planexium_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_planexium_brick", {
        img_rotate_flag = true,
    })
    unilib.utils.set_auto_rotate(
        "unilib:metal_planexium_brick", unilib.setting.auto_rotate_brick_flag
    )

end
