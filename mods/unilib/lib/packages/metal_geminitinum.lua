---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xtraores
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.metal_geminitinum = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.xtraores.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.metal_geminitinum.init()

    return {
        description = "Geminitinum",
    }

end

function unilib.pkg.metal_geminitinum.exec()

    local c_block = "unilib:metal_geminitinum_block"
    local c_screwdriver = "unilib:item_screwdriver_ordinary"

    unilib.register_metal({
        -- Original to unilib
        part_name = "geminitinum",
        description = S("Geminitinum"),

        fictional_flag = true,
        hardness = 5,
    })

    unilib.register_craftitem("unilib:metal_geminitinum_lump", "xtraores:geminitinum_lump", mode, {
        -- From xtraores:geminitinum_lump
        description = S("Geminitinum Lump"),
        inventory_image = "unilib_metal_geminitinum_lump.png"
    })

    -- (geminitinum has no powder)

    unilib.register_craftitem(
        -- From xtraores:geminitinum_ingot
        "unilib:metal_geminitinum_ingot",
        "xtraores:geminitinum_ingot",
        mode,
        {
            description = S("Geminitinum Ingot"),
            inventory_image = "unilib_metal_geminitinum_ingot.png",
            -- N.B. no groups in original code
            groups = {metal_ingot = 1},
        }
    )
    unilib.register_craft({
        -- From xtraores:geminitinum_ingot
        type = "cooking",
        output = "unilib:metal_geminitinum_ingot",
        recipe = "unilib:metal_geminitinum_lump",
        cooktime = 200,
    })
    unilib.register_craft({
        -- From xtraores:geminitinum_ingot
        output = "unilib:metal_geminitinum_ingot 9",
        recipe = {
            {"unilib:metal_geminitinum_block"},
        },
    })

    unilib.register_node("unilib:metal_geminitinum_block", "xtraores:geminitinum_block", mode, {
        -- From xtraores:geminitinum_block
        description = S("Geminitinum Block"),
        tiles = {{
            name = "unilib_metal_geminitinum_block.png",
            animation = {
                type = "vertical_frames",
                length = 1,
                aspect_h = 16,
                aspect_w = 16,
            },
        }},
        groups = {extrahard = 0},
        sounds = unilib.sound_table.metal,

        -- N.B. was true in original code
        is_ground_content = false,
    })
    unilib.register_craft_3x3({
        -- From xtraores:geminitinum_block
        output = "unilib:metal_geminitinum_block",
        ingredient = "unilib:metal_geminitinum_ingot",
    })
    unilib.register_stairs("unilib:metal_geminitinum_block")

    unilib.register_node("unilib:metal_geminitinum_brick", "xtraores:geminitinum_brick", mode, {
        -- From xtraores:geminitinum_brick
        description = S("Geminitinum Bricks"),
        tiles = {{
            name = "unilib_metal_geminitinum_brick.png",
            animation = {
                type = "vertical_frames",
                length = 1,
                aspect_h = 16,
                aspect_w = 16,
            },
        }},
        groups = {extrahard = 0},
        sounds = unilib.sound_table.metal,

        -- N.B. true in original code
        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From xtraores:geminitinum_brick
        output = "unilib:metal_geminitinum_brick",
        ingredient = "unilib:metal_geminitinum_ingot",
    })
    unilib.register_craft({
        -- From xtraores:geminitinum_brick
        output = "unilib:metal_geminitinum_ingot 4",
        recipe = {
            {"unilib:metal_geminitinum_brick"},
        },
    })
    unilib.register_stairs("unilib:metal_geminitinum_brick", {
        img_rotate_flag = true,
    })
    unilib.set_auto_rotate("unilib:metal_geminitinum_brick", unilib.auto_rotate_brick_flag)

end
