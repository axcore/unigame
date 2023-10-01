---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_white.init()

    return {
        description = "White sandstone",
        notes = "GLEMr4 uses inappropriate textures for its white sandstone and white sandstone" ..
                " gravel nodes, having copied them from the \"node_texture_modifier\" mod. Here," ..
                " and in the \"sand_white\" package, we insert new code that better matches the" ..
                " textures, converting the sandstone to a sand, and the sandstone gravel to a" ..
                " sandstone",
        optional = "sand_white",
    }

end

function unilib.pkg.stone_sandstone_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_white",
        description = S("White Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_white",
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("sandstone_white", 3, nil)

    unilib.register_node(
        -- From GLEMr4, lib_materials:stone_sandstone_white_gravel, originally from "node texture
        --      modifier" mod
        "unilib:stone_sandstone_white",
        "lib_materials:stone_sandstone_white_gravel",
        mode,
        {
            description = S("White Sandstone"),
            -- N.B. Originally lib_materials_stone_sandstone_white_gravel.png
            tiles = {"unilib_stone_sandstone_white.png"},
            -- N.B. Originally cracky = 3, level = 2, stone = 1
            groups = {cracky = smooth_cracky, crumbly = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_2x2({
        -- Original to unilib
        output = "unilib:stone_sandstone_white",
        ingredient = "unilib:sand_white",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:sand_white 4",
        recipe = {
            {"unilib:stone_sandstone_white"},
        }
    })
    --[[
    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_white", {
            drop_name = "unilib:stone_sandstone_white_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_white", {
            group_type = "smooth",
        })

    end
    unilib.register_carvings("unilib:stone_sandstone_white")
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_white",

        sandstone_flag = true,
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_sandstone_white_block
        part_name = "sandstone_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Sandstone Block"),
        img_list = {"unilib_stone_sandstone_white.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_node(
        -- From GLEMr4, lib_materials:stone_sandstone_white_brick, originally from "node texture
        --      modifier" mod
        "unilib:stone_sandstone_white_brick",
        "lib_materials:stone_sandstone_white_brick",
        mode,
        {
            description = S("White Sandstone Bricks"),
            tiles = {"unilib_stone_sandstone_white_brick.png"},
            -- N.B. Originally cracky = 3, level = 2, stone = 1
            groups = {cracky = 2},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_2x2x4({
        -- Original to unilib
        output = "unilib:stone_sandstone_white_brick",
        ingredient = "unilib:stone_sandstone_white",
    })
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_white",
    })
    unilib.set_auto_rotate("unilib:stone_sandstone_white_brick", unilib.auto_rotate_brick_flag)

    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble_or_rubble_or_nothing({
            -- Original to unilib. Depending on real hardness, creates
            --      unilib:stone_sandstone_white_cobble, or unilib:stone_sandstone_white_rubble, or
            --      nothing
            part_name = "sandstone_white",
            cobble_description = S("White Sandstone Cobble"),
            rubble_description = S("White Sandstone Rubble"),

            replace_mode = mode,
            override_drop_flag = true,
        })

    end

end
