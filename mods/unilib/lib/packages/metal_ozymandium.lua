---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_ozymandium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_ozymandium.init()

    return {
        description = "Ozymandium",
        optional = "item_screwdriver_ordinary",
    }

end

function unilib.pkg.metal_ozymandium.exec()

    local c_block = "unilib:metal_ozymandium_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

    unilib.register_metal({
        -- Original to unilib
        part_name = "ozymandium",
        description = S("Ozymandium"),

        fictional_flag = true,
        hardness = 3,
    })

    unilib.register_craftitem("unilib:metal_ozymandium_lump", "xtraores:osmium_lump", mode, {
        -- From xtraores:osmium_lump
        description = S("Ozymandium Lump"),
        inventory_image = "unilib_metal_ozymandium_lump.png"
    })

    unilib.register_metal_powder({
        -- From xtraores:osmium_dust. Creates unilib:metal_ozymandium_powder
        part_name = "ozymandium",
        orig_name = "xtraores:osmium_dust",

        replace_mode = mode,
        description = S("Ozymandium Powder"),
        lump_time = 5,
    })

    unilib.register_craftitem("unilib:metal_ozymandium_ingot", "xtraores:osmium_ingot", mode, {
        -- From xtraores:osmium_ingot
        description = S("Ozymandium Ingot"),
        inventory_image = "unilib_metal_ozymandium_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From xtraores:osmium_ingot
        type = "cooking",
        output = "unilib:metal_ozymandium_ingot",
        recipe = "unilib:metal_ozymandium_lump",
    })
    unilib.register_craft({
        -- From xtraores:osmium_ingot
        output = "unilib:metal_ozymandium_ingot 9",
        recipe = {
            {"unilib:metal_ozymandium_block"},
        },
    })

    unilib.register_node("unilib:metal_ozymandium_block", "xtraores:osmium_block", mode, {
        -- From xtraores:osmium_block
        description = S("Ozymandium Block"),
        tiles = {"unilib_metal_ozymandium_block.png"},
        groups = {extrahard = 3},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:osmium_block
        output = "unilib:metal_ozymandium_block",
        ingredient = "unilib:metal_ozymandium_ingot",
    })
    unilib.register_stairs("unilib:metal_ozymandium_block")
    unilib.register_carvings("unilib:metal_ozymandium_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node(
            -- From xtraores:osmium_block_compressed
            "unilib:metal_ozymandium_block_compressed",
            "xtraores:osmium_block_compressed",
            mode,
            {
                description = S("Compressed Ozymandium Block"),
                tiles = {"unilib_metal_ozymandium_block_compressed.png"},
                groups = {extrahard = 3},
                sounds = unilib.global.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
                -- N.B. no .stack_max in original code
                stack_max = unilib.global.squeezed_stack_max,
            }
        )
        unilib.misc.set_compressed_metal_recipes("ozymandium")

    end

    if unilib.global.pkg_executed_table["item_screwdriver_ordinary"] ~= nil then

        unilib.register_node(
            -- From xtraores:osmium_block_chiseled
            "unilib:metal_ozymandium_block_chiselled",
            "xtraores:osmium_block_chiseled",
            mode,
            {
                description = S("Chiselled Ozymandium Block"),
                tiles = {"unilib_metal_ozymandium_block_chiselled.png"},
                groups = {extrahard = 3},
                sounds = unilib.global.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From xtraores:osmium_block_chiseled
            output = "unilib:metal_ozymandium_block_chiselled 8",
            recipe = {
                {c_block, c_block, c_block},
                {c_block, c_screwdriver, c_block},
                {c_block, c_block, c_block},
            },
            replacements = {
                {c_screwdriver, c_screwdriver},
            },
        })
        unilib.register_stairs("unilib:metal_ozymandium_block_chiselled")

    end

    unilib.register_node("unilib:metal_ozymandium_brick", "xtraores:osmium_brick", mode, {
        -- From xtraores:osmium_brick
        description = S("Ozymandium Bricks"),
        tiles = {"unilib_metal_ozymandium_brick.png"},
        groups = {extrahard = 3},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:osmium_brick
        output = "unilib:metal_ozymandium_brick",
        ingredient = "unilib:metal_ozymandium_ingot",
    })
    unilib.register_craft({
        -- From xtraores:osmium_brick
        output = "unilib:metal_ozymandium_ingot 4",
        recipe = {
            {"unilib:metal_ozymandium_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_ozymandium_brick", {
        img_rotate_flag = true,
    })
    unilib.utils.set_auto_rotate(
        "unilib:metal_ozymandium_brick", unilib.setting.auto_rotate_brick_flag
    )

end
