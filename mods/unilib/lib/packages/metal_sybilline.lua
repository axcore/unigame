---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_sybilline = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_sybilline.init()

    return {
        description = "Sybilline",
        optional = "item_screwdriver_ordinary",
    }

end

function unilib.pkg.metal_sybilline.exec()

    local c_block = "unilib:metal_sybilline_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

    unilib.register_metal({
        -- Original to unilib
        part_name = "sybilline",
        description = S("Sybilline"),

        fictional_flag = true,
        hardness = 3,
    })

    unilib.register_craftitem("unilib:metal_sybilline_lump", "xtraores:cobalt_lump", mode, {
        -- From xtraores:cobalt_lump
        description = S("Sybilline Lump"),
        inventory_image = "unilib_metal_sybilline_lump.png"
    })

    unilib.register_metal_powder({
        -- From xtraores:cobalt_dust. Creates unilib:metal_sybilline_powder
        part_name = "sybilline",
        orig_name = "xtraores:cobalt_dust",

        replace_mode = mode,
        description = S("Sybilline Powder"),
        lump_time = 5,
    })

    unilib.register_craftitem("unilib:metal_sybilline_ingot", "xtraores:cobalt_ingot", mode, {
        -- From xtraores:cobalt_ingot
        description = S("Sybilline Ingot"),
        inventory_image = "unilib_metal_sybilline_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From xtraores:cobalt_ingot
        type = "cooking",
        output = "unilib:metal_sybilline_ingot",
        recipe = "unilib:metal_sybilline_lump",
    })
    unilib.register_craft({
        -- From xtraores:cobalt_ingot
        output = "unilib:metal_sybilline_ingot 9",
        recipe = {
            {"unilib:metal_sybilline_block"},
        },
    })

    unilib.register_node("unilib:metal_sybilline_block", "xtraores:cobalt_block", mode, {
        -- From xtraores:cobalt_block
        description = S("Sybilline Block"),
        tiles = {"unilib_metal_sybilline_block.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:cobalt_block
        output = "unilib:metal_sybilline_block",
        ingredient = "unilib:metal_sybilline_ingot",
    })
    unilib.register_stairs("unilib:metal_sybilline_block")

    unilib.register_node(
        -- From xtraores:cobalt_block_compressed
        "unilib:metal_sybilline_block_compressed",
        "xtraores:cobalt_block_compressed",
        mode,
        {
            description = S("Compressed Sybilline Block"),
            tiles = {"unilib_metal_sybilline_block_compressed.png"},
            groups = {cracky = 1},
            sounds = unilib.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.set_compressed_metal_recipes("sybilline")
    unilib.register_stairs("unilib:metal_sybilline_block_compressed")

    if unilib.pkg_executed_table["item_screwdriver_ordinary"] ~= nil then

        unilib.register_node(
            -- From xtraores:cobalt_block_chiseled
            "unilib:metal_sybilline_block_chiselled",
            "xtraores:cobalt_block_chiseled",
            mode,
            {
                description = S("Chiselled Sybilline Block"),
                tiles = {"unilib_metal_sybilline_block_chiselled.png"},
                groups = {cracky = 1},
                sounds = unilib.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From xtraores:cobalt_block_chiseled
            output = "unilib:metal_sybilline_block_chiselled 8",
            recipe = {
                {c_block, c_block, c_block},
                {c_block, c_screwdriver, c_block},
                {c_block, c_block, c_block},
            },
            replacements = {
                {c_screwdriver, c_screwdriver},
            },
        })
        unilib.register_stairs("unilib:metal_sybilline_block_chiselled")

    end

    unilib.register_node("unilib:metal_sybilline_brick", "xtraores:cobalt_brick", mode, {
        -- From xtraores:cobalt_brick
        description = S("Sybilline Bricks"),
        tiles = {"unilib_metal_sybilline_brick.png"},
        groups = {cracky = 1},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:cobalt_brick
        output = "unilib:metal_sybilline_brick",
        ingredient = "unilib:metal_sybilline_ingot",
    })
    unilib.register_craft({
        -- From xtraores:cobalt_brick
        output = "unilib:metal_sybilline_ingot 4",
        recipe = {
            {"unilib:metal_sybilline_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_sybilline_brick", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:metal_sybilline_brick", unilib.auto_rotate_brick_flag)

end
