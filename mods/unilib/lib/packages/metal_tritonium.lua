---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_tritonium = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_tritonium.init()

    return {
        description = "Tritonium",
        optional = "item_screwdriver_ordinary",
    }

end

function unilib.pkg.metal_tritonium.exec()

    local c_block = "unilib:metal_tritonium_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

    unilib.register_metal({
        -- Original to unilib
        part_name = "tritonium",
        description = S("Tritonium"),

        fictional_flag = true,
        hardness = 3,
    })

    unilib.register_craftitem("unilib:metal_tritonium_lump", "xtraores:titanium_lump", mode, {
        -- From xtraores:titanium_lump
        description = S("Tritonium Lump"),
        inventory_image = "unilib_metal_tritonium_lump.png"
    })

    unilib.register_metal_powder({
        -- From xtraores:titanium_dust. Creates unilib:metal_tritonium_powder
        part_name = "tritonium",
        orig_name = "xtraores:titanium_dust",

        replace_mode = mode,
        description = S("Tritonium Powder"),
        lump_time = 5,
    })

    unilib.register_craftitem("unilib:metal_tritonium_ingot", "xtraores:titanium_ingot", mode, {
        -- From xtraores:titanium_ingot
        description = S("Tritonium Ingot"),
        inventory_image = "unilib_metal_tritonium_ingot.png",
        -- N.B. no groups in original code
        groups = {metal_ingot = 1},
    })
    unilib.register_craft({
        -- From xtraores:titanium_ingot
        type = "cooking",
        output = "unilib:metal_tritonium_ingot",
        recipe = "unilib:metal_tritonium_lump",
    })
    unilib.register_craft({
        -- From xtraores:titanium_ingot
        output = "unilib:metal_tritonium_ingot 9",
        recipe = {
            {"unilib:metal_tritonium_block"},
        },
    })

    unilib.register_node("unilib:metal_tritonium_block", "xtraores:titanium_block", mode, {
        -- From xtraores:titanium_block
        description = S("Tritonium Block"),
        tiles = {"unilib_metal_tritonium_block.png"},
        groups = {extrahard = 0},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:titanium_block
        output = "unilib:metal_tritonium_block",
        ingredient = "unilib:metal_tritonium_ingot",
    })
    unilib.register_stairs("unilib:metal_tritonium_block")

    unilib.register_node(
        -- From xtraores:titanium_block_compressed
        "unilib:metal_tritonium_block_compressed",
        "xtraores:titanium_block_compressed",
        mode,
        {
            description = S("Compressed Tritonium Block"),
            tiles = {"unilib_metal_tritonium_block_compressed.png"},
            groups = {extrahard = 0},
            sounds = unilib.sound_table.metal,

            -- N.B. true in original code
            is_ground_content = false,
        }
    )
    unilib.set_compressed_metal_recipes("tritonium")
    unilib.register_stairs("unilib:metal_tritonium_block_compressed")

    if unilib.pkg_executed_table["item_screwdriver_ordinary"] ~= nil then

        unilib.register_node(
            -- From xtraores:titanium_block_chiseled
            "unilib:metal_tritonium_block_chiselled",
            "xtraores:titanium_block_chiseled",
            mode,
            {
                description = S("Chiselled Tritonium Block"),
                tiles = {"unilib_metal_tritonium_block_chiselled.png"},
                groups = {extrahard = 0},
                sounds = unilib.sound_table.metal,

                -- N.B. true in original code
                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From xtraores:titanium_block_chiseled
            output = "unilib:metal_tritonium_block_chiselled 8",
            recipe = {
                {c_block, c_block, c_block},
                {c_block, c_screwdriver, c_block},
                {c_block, c_block, c_block},
            },
            replacements = {
                {c_screwdriver, c_screwdriver},
            },
        })
        unilib.register_stairs("unilib:metal_tritonium_block_chiselled")

    end

    unilib.register_node("unilib:metal_tritonium_brick", "xtraores:titanium_brick", mode, {
        -- From xtraores:titanium_brick
        description = S("Tritonium Bricks"),
        tiles = {"unilib_metal_tritonium_brick.png"},
        groups = {extrahard = 0},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:titanium_brick
        output = "unilib:metal_tritonium_brick",
        ingredient = "unilib:metal_tritonium_ingot",
    })
    unilib.register_craft({
        -- From xtraores:titanium_brick
        output = "unilib:metal_tritonium_ingot 4",
        recipe = {
            {"unilib:metal_tritonium_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_tritonium_brick", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:metal_tritonium_brick", unilib.auto_rotate_brick_flag)

end
