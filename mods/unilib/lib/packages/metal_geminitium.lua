---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores/xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_geminitium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_geminitium.init()

    return {
        description = "Geminitium",
    }

end

function unilib.pkg.metal_geminitium.exec()

    local c_block = "unilib:metal_geminitium_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

    unilib.register_metal({
        -- Original to unilib
        part_name = "geminitium",
        description = S("Geminitium"),

        fictional_flag = true,
        hardness = 5,
    })

    unilib.register_craftitem("unilib:metal_geminitium_lump", "xtraores:geminitinum_lump", mode, {
        -- From xtraores:geminitinum_lump
        description = S("Geminitium Lump"),
        inventory_image = "unilib_metal_geminitium_lump.png"
    })

    -- (geminitium has no powder)

    unilib.register_craftitem(
        -- From xtraores:geminitinum_ingot
        "unilib:metal_geminitium_ingot",
        "xtraores:geminitinum_ingot",
        mode,
        {
            description = S("Geminitium Ingot"),
            inventory_image = "unilib_metal_geminitium_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From xtraores:geminitinum_ingot
        type = "cooking",
        output = "unilib:metal_geminitium_ingot",
        recipe = "unilib:metal_geminitium_lump",
        cooktime = 200,
    })
    unilib.register_craft({
        -- From xtraores:geminitinum_ingot
        output = "unilib:metal_geminitium_ingot 9",
        recipe = {
            {"unilib:metal_geminitium_block"},
        },
    })

    unilib.register_node("unilib:metal_geminitium_block", "xtraores:geminitinum_block", mode, {
        -- From xtraores:geminitinum_block
        description = S("Geminitium Block"),
        tiles = {{
            name = "unilib_metal_geminitium_block.png",
            animation = {
                type = "vertical_frames",
                length = 1,
                aspect_h = 16,
                aspect_w = 16,
            },
        }},
        groups = {extrahard = 0},
        sounds = unilib.global.sound_table.metal,

        -- N.B. was true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:geminitinum_block
        output = "unilib:metal_geminitium_block",
        ingredient = "unilib:metal_geminitium_ingot",
    })
    unilib.register_stairs("unilib:metal_geminitium_block")
    unilib.register_carvings("unilib:metal_geminitium_block", {
        millwork_flag = true,
    })

    if unilib.setting.squeezed_metal_flag then

        unilib.register_node("unilib:metal_geminitium_block_compressed", nil, mode, {
            -- Original to unilib
            description = S("Compressed Geminitium Block"),
            tiles = {{
                name = "unilib_metal_geminitium_block_compressed.png",
                animation = {
                    type = "vertical_frames",
                    length = 1,
                    -- N.B. unilib compressed block textures are 17x17, not 16x16
                    aspect_h = 17,
                    aspect_w = 17,
                },
            }},
            groups = {cracky = 1, level = 3},
            sounds = unilib.global.sound_table.metal,

            is_ground_content = false,
            -- N.B. no .stack_max in original code
            stack_max = unilib.global.squeezed_stack_max,
        })
        unilib.misc.set_compressed_metal_recipes("geminitium")

    end

    unilib.register_node("unilib:metal_geminitium_brick", "xtraores:geminitinum_brick", mode, {
        -- From xtraores:geminitinum_brick
        description = S("Geminitium Bricks"),
        tiles = {{
            name = "unilib_metal_geminitium_brick.png",
            animation = {
                type = "vertical_frames",
                length = 1,
                aspect_h = 16,
                aspect_w = 16,
            },
        }},
        groups = {extrahard = 0},
        sounds = unilib.global.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:geminitinum_brick
        output = "unilib:metal_geminitium_brick",
        ingredient = "unilib:metal_geminitium_ingot",
    })
    unilib.register_craft({
        -- From xtraores:geminitinum_brick
        output = "unilib:metal_geminitium_ingot 4",
        recipe = {
            {"unilib:metal_geminitium_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_geminitium_brick", {
        img_rotate_flag = true,
    })
    unilib.utils.set_auto_rotate(
        "unilib:metal_geminitium_brick", unilib.setting.auto_rotate_brick_flag
    )

end
