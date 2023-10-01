---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_unobtainium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_unobtainium.init()

    return {
        description = "Unobtainium",
        optional = "item_screwdriver_ordinary",
    }

end

function unilib.pkg.metal_unobtainium.exec()

    local c_block = "unilib:metal_unobtainium_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

    unilib.register_metal({
        -- Original to unilib
        part_name = "unobtainium",
        description = S("Unobtainium"),

        fictional_flag = true,
        hardness = 5,
    })

    unilib.register_craftitem("unilib:metal_unobtainium_lump", "xtraores:unobtainium_lump", mode, {
        -- From xtraores:unobtainium_lump
        description = S("Unobtainium Lump"),
        inventory_image = "unilib_metal_unobtainium_lump.png"
    })

    unilib.register_metal_powder({
        -- From xtraores:unobtainium_dust. Creates unilib:metal_unobtainium_powder
        part_name = "unobtainium",
        orig_name = "xtraores:unobtainium_dust",

        replace_mode = mode,
        description = S("Unobtainium Powder"),
        lump_time = 5,
    })

    unilib.register_craftitem(
        -- From xtraores:unobtainium_ingot
        "unilib:metal_unobtainium_ingot",
        "xtraores:unobtainium_ingot",
        mode,
        {
            description = S("Unobtainium Ingot"),
            inventory_image = "unilib_metal_unobtainium_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From xtraores:unobtainium_ingot
        type = "cooking",
        output = "unilib:metal_unobtainium_ingot",
        recipe = "unilib:metal_unobtainium_lump",
    })
    unilib.register_craft({
        -- From xtraores:unobtainium_ingot
        output = "unilib:metal_unobtainium_ingot 9",
        recipe = {
            {"unilib:metal_unobtainium_block"},
        },
    })

    unilib.register_node("unilib:metal_unobtainium_block", "xtraores:unobtainium_block", mode, {
        -- From xtraores:unobtainium_block
        description = S("Unobtainium Block"),
        tiles = {"unilib_metal_unobtainium_block.png"},
        groups = {extrahard = 0},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:unobtainium_block
        output = "unilib:metal_unobtainium_block",
        ingredient = "unilib:metal_unobtainium_ingot",
    })
    unilib.register_stairs("unilib:metal_unobtainium_block")

    unilib.register_node(
        -- From xtraores:unobtainium_block_compressed
        "unilib:metal_unobtainium_block_compressed",
        "xtraores:unobtainium_block_compressed",
        mode,
        {
            description = S("Compressed Unobtainium Block"),
            tiles = {"unilib_metal_unobtainium_block_compressed.png"},
            groups = {extrahard = 0},
            sounds = unilib.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.set_compressed_metal_recipes("unobtainium")
    unilib.register_stairs("unilib:metal_unobtainium_block_compressed")

    if unilib.pkg_executed_table["item_screwdriver_ordinary"] ~= nil then

        unilib.register_node(
            -- From xtraores:unobtainium_block_chiseled
            "unilib:metal_unobtainium_block_chiselled",
            "xtraores:unobtainium_block_chiseled",
            mode,
            {
                description = S("Chiselled Unobtainium Block"),
                tiles = {"unilib_metal_unobtainium_block_chiselled.png"},
                groups = {extrahard = 0},
                sounds = unilib.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From xtraores:unobtainium_block_chiseled
            output = "unilib:metal_unobtainium_block_chiselled 8",
            recipe = {
                {c_block, c_block, c_block},
                {c_block, c_screwdriver, c_block},
                {c_block, c_block, c_block},
            },
            replacements = {
                {c_screwdriver, c_screwdriver},
            },
        })
        unilib.register_stairs("unilib:metal_unobtainium_block_chiselled")

    end

    unilib.register_node("unilib:metal_unobtainium_brick", "xtraores:unobtainium_brick", mode, {
        -- From xtraores:unobtainium_brick
        description = S("Unobtainium Bricks"),
        tiles = {"unilib_metal_unobtainium_brick.png"},
        groups = {extrahard = 0},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:unobtainium_brick
        output = "unilib:metal_unobtainium_brick",
        ingredient = "unilib:metal_unobtainium_ingot",
    })
    unilib.register_craft({
        -- From xtraores:unobtainium_brick
        output = "unilib:metal_unobtainium_ingot 4",
        recipe = {
            {"unilib:metal_unobtainium_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_unobtainium_brick", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:metal_unobtainium_brick", unilib.auto_rotate_brick_flag)

end
