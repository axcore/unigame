---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_brown.init()

    return {
        description = "Brown sandstone",
        optional = "sand_brown",
    }

end

function unilib.pkg.stone_sandstone_brown.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_brown",
        description = S("Brown Sandstone"),

        category = "sedimentary",
        colour = "#443716",
        grinder_flag = true,
        grinder_powder = "unilib:sand_brown",
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("sandstone_brown", 3, nil)

    unilib.register_node("unilib:stone_sandstone_brown", "lib_materials:stone_sand", mode, {
        -- From GLEMr4, lib_materials:stone_sand
        description = S("Brown Sandstone"),
        tiles = {"unilib_stone_sandstone_brown.png"},
        groups = {cracky = smooth_cracky, level = 2, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_craft_2x2({
        -- Original to unilib
        output = "unilib:stone_sandstone_brown",
        ingredient = "unilib:sand_brown",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:sand_brown 4",
        recipe = {
            {"unilib:stone_sandstone_brown"},
        },
    })
    --[[
    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_brown", {
            drop_name = "unilib:stone_sandstone_brown_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_brown", {
            group_type = "smooth",
        })

    end
    unilib.register_carvings("unilib:stone_sandstone_brown")
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_brown",

        sandstone_flag = true,
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_sandstone_brown_block
        part_name = "sandstone_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Sandstone Block"),
        img_list = {"unilib_stone_sandstone_brown.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_sandstone_brown_brick
        part_name = "sandstone_brown",
        orig_name = nil,

        replace_mode = mode,
        description = S("Brown Sandstone Bricks"),
        img_list = {"unilib_stone_sandstone_brown.png^unilib_stone_brick_overlay.png"},
    })

    if unilib.setting.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble_or_rubble_or_nothing({
            -- Original to unilib. Depending on real hardness, creates
            --      unilib:stone_sandstone_brown_cobble, or unilib:stone_sandstone_brown_rubble, or
            --      nothing
            part_name = "sandstone_brown",
            cobble_description = S("Brown Sandstone Cobble"),
            cobble_compressed_description = S("Compressed Brown Sandstone Cobble"),
            cobble_condensed_description = S("Condensed Brown Sandstone Cobble"),
            rubble_description = S("Brown Sandstone Rubble"),
            rubble_compressed_description = S("Compressed Brown Sandstone Rubble"),
            rubble_condensed_description = S("Condensed Brown Sandstone Rubble"),
            smooth_compressed_description = S("Compressed Brown Sandstone"),
            smooth_condensed_description = S("Condensed Brown Sandstone"),

            replace_mode = mode,
            override_drop_flag = true,
        })

    end

end
