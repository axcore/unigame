---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.brick_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.brick_ordinary.init()

    return {
        description = "Ordinary brick",
        depends = "clay_ordinary",
    }

end

function unilib.pkg.brick_ordinary.exec()

    unilib.register_craftitem("unilib:brick_ordinary", "default:clay_brick", mode, {
        -- From default:clay_brick
        description = S("Ordinary Brick"),
        inventory_image = "unilib_brick_ordinary.png",
    })
    unilib.register_craft({
        -- From default:clay_brick
        output = "unilib:brick_ordinary 4",
        recipe = {
            {"unilib:brick_ordinary_block"},
        }
    })
    unilib.register_craft({
        -- From default:clay_brick
        type = "cooking",
        output = "unilib:brick_ordinary",
        recipe = "unilib:clay_ordinary_lump",
    })

    unilib.register_node("unilib:brick_ordinary_block", "default:brick", mode, {
        -- From default:brick
        description = S("Ordinary Brick Block"),
        tiles = {
            "unilib_brick_ordinary_block.png^[transformFX",
            "unilib_brick_ordinary_block.png",
        },
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2({
        -- From default:brick
        output = "unilib:brick_ordinary_block",
        ingredient = "unilib:brick_ordinary",
    })
    unilib.register_stairs("unilib:brick_ordinary_block")
    unilib.register_carvings("unilib:brick_ordinary_block", {
        column_flag = true,
        millwork_flag = true,
    })
    unilib.set_auto_rotate("unilib:brick_ordinary_block", unilib.auto_rotate_brick_flag)

    if unilib.mtgame_tweak_flag then

        -- A vertical brick block, because similar-looking items imported from the "morebricks"
        --      mod have one
        unilib.register_node("unilib:brick_ordinary_block_vertical", nil, mode, {
            -- Original to unilib
            description = unilib.brackets(S("Ordinary Brick Block"), S("Vertical")),
            tiles = {"unilib_brick_ordinary_block_vertical.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:brick_ordinary_block_vertical",
            recipe = {
                {"unilib:brick_ordinary_block"},
            },
        })
        unilib.register_stairs("unilib:brick_ordinary_block_vertical")
        unilib.set_auto_rotate(
            "unilib:brick_ordinary_block_vertical",
            unilib.auto_rotate_brick_flag
        )

    end

end
