---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_adamantite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_adamantite.init()

    return {
        description = "Adamantite",
        optional = "item_screwdriver_ordinary",
    }

end

function unilib.pkg.metal_adamantite.exec()

    local c_block = "unilib:metal_adamantite_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

    unilib.register_metal({
        -- Original to unilib
        part_name = "adamantite",
        description = S("Adamantite"),

        fictional_flag = true,
        hardness = 5,
    })

    unilib.register_craftitem("unilib:metal_adamantite_lump", "xtraores:adamantite_lump", mode, {
        -- From xtraores:adamantite_lump
        description = S("Adamantite Lump"),
        inventory_image = "unilib_metal_adamantite_lump.png"
    })

    unilib.register_metal_powder({
        -- From xtraores:adamantite_dust. Creates unilib:metal_adamantite_powder
        part_name = "adamantite",
        orig_name = "xtraores:adamantite_dust",

        replace_mode = mode,
        description = S("Adamantite Powder"),
        lump_time = 5,
    })

    unilib.register_craftitem("unilib:metal_adamantite_ingot", "xtraores:adamantite_ingot", mode, {
        -- From xtraores:adamantite_ingot
        description = S("Adamantite Ingot"),
        inventory_image = "unilib_metal_adamantite_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From xtraores:adamantite_ingot
        type = "cooking",
        output = "unilib:metal_adamantite_ingot",
        recipe = "unilib:metal_adamantite_lump",
    })
    unilib.register_craft({
        -- From xtraores:adamantite_ingot
        output = "unilib:metal_adamantite_ingot 9",
        recipe = {
            {"unilib:metal_adamantite_block"},
        },
    })

    unilib.register_node("unilib:metal_adamantite_block", "xtraores:adamantite_block", mode, {
        -- From xtraores:adamantite_block
        description = S("Adamantite Block"),
        tiles = {"unilib_metal_adamantite_block.png"},
        groups = {extrahard = 2},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:adamantite_block
        output = "unilib:metal_adamantite_block",
        ingredient = "unilib:metal_adamantite_ingot",
    })
    unilib.register_stairs("unilib:metal_adamantite_block")

    unilib.register_node(
        -- From xtraores:adamantite_block_compressed
        "unilib:metal_adamantite_block_compressed",
        "xtraores:adamantite_block_compressed",
        mode,
        {
            description = S("Compressed Adamantite Block"),
            tiles = {"unilib_metal_adamantite_block_compressed.png"},
            groups = {extrahard = 2},
            sounds = unilib.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.set_compressed_metal_recipes("adamantite")
    unilib.register_stairs("unilib:metal_adamantite_block_compressed")

    if unilib.pkg_executed_table["item_screwdriver_ordinary"] ~= nil then

        unilib.register_node(
            -- From xtraores:adamantite_block_chiseled
            "unilib:metal_adamantite_block_chiselled",
            "xtraores:adamantite_block_chiseled",
            mode,
            {
                description = S("Chiselled Adamantite Block"),
                tiles = {"unilib_metal_adamantite_block_chiselled.png"},
                groups = {extrahard = 2},
                sounds = unilib.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From xtraores:adamantite_block_chiseled
            output = "unilib:metal_adamantite_block_chiselled 8",
            recipe = {
                {c_block, c_block, c_block},
                {c_block, c_screwdriver, c_block},
                {c_block, c_block, c_block},
            },
            replacements = {
                {c_screwdriver, c_screwdriver},
            },
        })
        unilib.register_stairs("unilib:metal_adamantite_block_chiselled")

    end

    unilib.register_node("unilib:metal_adamantite_brick", "xtraores:adamantite_brick", mode, {
        -- From xtraores:adamantite_brick
        description = S("Adamantite Bricks"),
        tiles = {"unilib_metal_adamantite_brick.png"},
        groups = {extrahard = 2},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:adamantite_brick
        output = "unilib:metal_adamantite_brick",
        ingredient = "unilib:metal_adamantite_ingot",
    })
    unilib.register_craft({
        -- From xtraores:adamantite_brick
        output = "unilib:metal_adamantite_ingot 4",
        recipe = {
            {"unilib:metal_adamantite_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_adamantite_brick", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:metal_adamantite_brick", unilib.auto_rotate_brick_flag)

end
