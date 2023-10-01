---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_rarium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_rarium.init()

    return {
        description = "Rarium",
        optional = "item_screwdriver_ordinary",
    }

end

function unilib.pkg.metal_rarium.exec()

    local c_block = "unilib:metal_rarium_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

    unilib.register_metal({
        -- Original to unilib
        part_name = "rarium",
        description = S("Rarium"),

        fictional_flag = true,
        hardness = 5,
    })

    unilib.register_craftitem("unilib:metal_rarium_lump", "xtraores:rarium_lump", mode, {
        -- From xtraores:rarium_lump
        description = S("Rarium Lump"),
        inventory_image = "unilib_metal_rarium_lump.png"
    })

    unilib.register_metal_powder({
        -- From xtraores:rarium_dust. Creates unilib:metal_rarium_powder
        part_name = "rarium",
        orig_name = "xtraores:rarium_dust",

        replace_mode = mode,
        description = S("Rarium Powder"),
        lump_time = 5,
    })

    unilib.register_craftitem("unilib:metal_rarium_ingot", "xtraores:rarium_ingot", mode, {
        -- From xtraores:rarium_ingot
        description = S("Rarium Ingot"),
        inventory_image = "unilib_metal_rarium_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From xtraores:rarium_ingot
        type = "cooking",
        output = "unilib:metal_rarium_ingot",
        recipe = "unilib:metal_rarium_lump",
    })
    unilib.register_craft({
        -- From xtraores:rarium_ingot
        output = "unilib:metal_rarium_ingot 9",
        recipe = {
            {"unilib:metal_rarium_block"},
        },
    })

    unilib.register_node("unilib:metal_rarium_block", "xtraores:rarium_block", mode, {
        -- From xtraores:rarium_block
        description = S("Rarium Block"),
        tiles = {"unilib_metal_rarium_block.png"},
        groups = {extrahard = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:rarium_block
        output = "unilib:metal_rarium_block",
        ingredient = "unilib:metal_rarium_ingot",
    })
    unilib.register_stairs("unilib:metal_rarium_block")

    unilib.register_node(
        -- From xtraores:rarium_block_compressed
        "unilib:metal_rarium_block_compressed",
        "xtraores:rarium_block_compressed",
        mode,
        {
            description = S("Compressed Rarium Block"),
            tiles = {"unilib_metal_rarium_block_compressed.png"},
            groups = {extrahard = 1},
            sounds = unilib.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.set_compressed_metal_recipes("rarium")
    unilib.register_stairs("unilib:metal_rarium_block_compressed")

    if unilib.pkg_executed_table["item_screwdriver_ordinary"] ~= nil then

        unilib.register_node(
            -- From xtraores:rarium_block_chiseled
            "unilib:metal_rarium_block_chiselled",
            "xtraores:rarium_block_chiseled",
            mode,
            {
                description = S("Chiselled Rarium Block"),
                tiles = {"unilib_metal_rarium_block_chiselled.png"},
                groups = {extrahard = 1},
                sounds = unilib.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From xtraores:rarium_block_chiseled
            output = "unilib:metal_rarium_block_chiselled 8",
            recipe = {
                {c_block, c_block, c_block},
                {c_block, c_screwdriver, c_block},
                {c_block, c_block, c_block},
            },
            replacements = {
                {c_screwdriver, c_screwdriver},
            },
        })
        unilib.register_stairs("unilib:metal_rarium_block_chiselled")

    end

    unilib.register_node("unilib:metal_rarium_brick", "xtraores:rarium_brick", mode, {
        -- From xtraores:rarium_brick
        description = S("Rarium Bricks"),
        tiles = {"unilib_metal_rarium_brick.png"},
        groups = {extrahard = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:rarium_brick
        output = "unilib:metal_rarium_brick",
        ingredient = "unilib:metal_rarium_ingot",
    })
    unilib.register_craft({
        -- From xtraores:rarium_brick
        output = "unilib:metal_rarium_ingot 4",
        recipe = {
            {"unilib:metal_rarium_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_rarium_brick", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:metal_rarium_brick", unilib.auto_rotate_brick_flag)

end
