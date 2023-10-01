---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_palatinium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_palatinium.init()

    return {
        description = "Palatinium",
        optional = "item_screwdriver_ordinary",
    }

end

function unilib.pkg.metal_palatinium.exec()

    local c_block = "unilib:metal_palatinium_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

     unilib.register_metal({
        -- Original to unilib
        part_name = "palatinium",
        description = S("Palatinium"),

        fictional_flag = true,
        hardness = 2,
    })

    unilib.register_craftitem("unilib:metal_palatinium_lump", "xtraores:platinum_lump", mode, {
        -- From xtraores:platinum_lump
        description = S("Palatinium Lump"),
        inventory_image = "unilib_metal_palatinium_lump.png"
    })

    unilib.register_metal_powder({
        -- From xtraores:platinum_dust. Creates unilib:metal_palatinium_powder
        part_name = "palatinium",
        orig_name = "xtraores:platinum_dust",

        replace_mode = mode,
        description = S("Palatinium Powder"),
        lump_time = 5,
    })

    unilib.register_craftitem("unilib:metal_palatinium_ingot", "xtraores:platinum_ingot", mode, {
        -- From xtraores:platinum_ingot
        description = S("Palatinium Ingot"),
        inventory_image = "unilib_metal_palatinium_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From xtraores:platinum_ingot
        type = "cooking",
        output = "unilib:metal_palatinium_ingot",
        recipe = "unilib:metal_palatinium_lump",
    })
    unilib.register_craft({
        -- From xtraores:platinum_ingot
        output = "unilib:metal_palatinium_ingot 9",
        recipe = {
            {"unilib:metal_palatinium_block"},
        },
    })

    unilib.register_node("unilib:metal_palatinium_block", "xtraores:platinum_block", mode, {
        -- From xtraores:platinum_block
        description = S("Palatinium Block"),
        tiles = {"unilib_metal_palatinium_block.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:platinum_block
        output = "unilib:metal_palatinium_block",
        ingredient = "unilib:metal_palatinium_ingot",
    })
    unilib.register_stairs("unilib:metal_palatinium_block")

    unilib.register_node(
        -- From xtraores:platinum_block_compressed
        "unilib:metal_palatinium_block_compressed",
        "xtraores:platinum_block_compressed",
        mode,
        {
            description = S("Compressed Palatinium Block"),
            tiles = {"unilib_metal_palatinium_block_compressed.png"},
            groups = {cracky = 2},
            sounds = unilib.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.set_compressed_metal_recipes("palatinium")
    unilib.register_stairs("unilib:metal_palatinium_block_compressed")

    if unilib.pkg_executed_table["item_screwdriver_ordinary"] ~= nil then

        unilib.register_node(
            -- From xtraores:platinum_block_chiseled
            "unilib:metal_palatinium_block_chiselled",
            "xtraores:platinum_block_chiseled",
            mode,
            {
                description = S("Chiselled Palatinium Block"),
                tiles = {"unilib_metal_palatinium_block_chiselled.png"},
                groups = {cracky = 2},
                sounds = unilib.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From xtraores:platinum_block_chiseled
            output = "unilib:metal_palatinium_block_chiselled 8",
            recipe = {
                {c_block, c_block, c_block},
                {c_block, c_screwdriver, c_block},
                {c_block, c_block, c_block},
            },
            replacements = {
                {c_screwdriver, c_screwdriver},
            },
        })
        unilib.register_stairs("unilib:metal_palatinium_block_chiselled")

    end

    unilib.register_node("unilib:metal_palatinium_brick", "xtraores:platinum_brick", mode, {
        -- From xtraores:platinum_brick
        description = S("Palatinium Bricks"),
        tiles = {"unilib_metal_palatinium_brick.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:platinum_brick
        output = "unilib:metal_palatinium_brick",
        ingredient = "unilib:metal_palatinium_ingot",
    })
    unilib.register_craft({
        -- From xtraores:platinum_brick
        output = "unilib:metal_palatinium_ingot 4",
        recipe = {
            {"unilib:metal_palatinium_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_palatinium_brick", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:metal_palatinium_brick", unilib.auto_rotate_brick_flag)

end
