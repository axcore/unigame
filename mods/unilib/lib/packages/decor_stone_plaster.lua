---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_stone_plaster = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_stone_plaster.init()

    return {
        description = "Decorative stone plaster nodes",
        depends = {"decor_bricks_stone_chalked", "stone_chalk_white", "stone_ordinary"},
    }

end

function unilib.pkg.decor_stone_plaster.exec()

    local img_bricks = "unilib_decor_bricks_stone_chalked.png"
    local img_chalk = "unilib_stone_chalk_white.png"
    local img_cobble = "unilib_stone_ordinary_cobble.png"

    unilib.register_node(
        -- From darkage:chalked_bricks_with_plaster
        "unilib:decor_stone_plaster_bricks",
        "darkage:chalked_bricks_with_plaster",
        mode,
        {
            description = S("Chalked Bricks with Plaster"),
            tiles = {
                img_chalk .. "^(" .. img_bricks .. "^[mask:unilib_mask_plaster_D.png)",
                img_chalk .. "^(" .. img_bricks .. "^[mask:unilib_mask_plaster_B.png)",
                img_chalk .. "^(" .. img_bricks .. "^[mask:unilib_mask_plaster_C.png)",
                img_chalk .. "^(" .. img_bricks .. "^[mask:unilib_mask_plaster_A.png)",
                img_bricks,
                img_chalk,
            },
            groups = {cracky = 3},
            sounds = unilib.sound_table.stone,

            drop = "unilib:stone_ordinary_cobble",
            -- N.B. unilib.auto_rotate_brick_flag does not apply to this node
            is_ground_content = false,
            paramtype2 = "facedir",
        }
    )
    unilib.register_craft({
        -- From darkage:chalked_bricks_with_plaster
        output = "unilib:decor_stone_plaster_bricks 2",
        recipe = {
            {"unilib:decor_bricks_stone_chalked", "unilib:stone_chalk_white_powder"},
            {"unilib:decor_bricks_stone_chalked", "unilib:stone_chalk_white_powder"},
        },
    })
    unilib.register_craft({
        -- From darkage:chalked_bricks_with_plaster
        output = "unilib:decor_stone_plaster_bricks 2",
        recipe = {
            {"unilib:stone_chalk_white_powder", "unilib:decor_bricks_stone_chalked"},
            {"unilib:stone_chalk_white_powder", "unilib:decor_bricks_stone_chalked"},
        },
    })

    unilib.register_node("unilib:decor_stone_plaster_cobble", "darkage:cobble_with_plaster", mode, {
        -- From darkage:cobble_with_plaster
        description = S("Cobblestone with Plaster"),
        tiles = {
            img_chalk .. "^(" .. img_cobble .. "^[mask:unilib_mask_plaster_D.png)",
            img_chalk .. "^(" .. img_cobble .. "^[mask:unilib_mask_plaster_B.png)",
            img_chalk .. "^(" .. img_cobble .. "^[mask:unilib_mask_plaster_C.png)",
            img_chalk .. "^(" .. img_cobble .. "^[mask:unilib_mask_plaster_A.png)",
            img_cobble,
            img_chalk,
        },
        groups = {cracky = 3},
        sounds = unilib.sound_table.stone,

        drop = "unilib:stone_ordinary_cobble",
        is_ground_content = false,
        paramtype2 = "facedir",
    })
    unilib.register_craft({
        -- From darkage:cobble_with_plaster
        output = "unilib:decor_stone_plaster_cobble 2",
        recipe = {
            {"unilib:stone_ordinary_cobble", "unilib:stone_chalk_white_powder"},
            {"unilib:stone_ordinary_cobble", "unilib:stone_chalk_white_powder"},
        },
    })

    unilib.register_craft({
        -- From darkage:cobble_with_plaster
        output = "unilib:decor_stone_plaster_cobble 2",
        recipe = {
            {"unilib:stone_chalk_white_powder", "unilib:stone_ordinary_cobble"},
            {"unilib:stone_chalk_white_powder", "unilib:stone_ordinary_cobble"},
        },
    })

end
