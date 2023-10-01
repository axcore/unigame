---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_antipodean.init()

    return {
        description = "Antipodean sandstone",
        optional = "sand_red_antipodean",
    }

end

function unilib.pkg.stone_sandstone_antipodean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_antipodean",
        description = S("Antipodean Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_red_antipodean",
        grinder_gravel = "unilib:gravel_red_antipodean",
        hardness = 1,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_sandstone_antipodean", "australia:red_stone", mode, {
        -- From australia:red_stone
        description = S("Antipodean Sandstone"),
        tiles = {"unilib_stone_sandstone_antipodean.png"},
        groups = {cracky = 3, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:stone_sandstone_antipodean_cobble",
    })
    if unilib.pkg_executed_table["sand_red_antipodean"] ~= nil then

        unilib.register_craft_2x2({
            -- Original to unilib
            output = "unilib:stone_sandstone_antipodean",
            ingredient = "unilib:sand_red_antipodean",
        })
        unilib.register_craft({
            -- Original to unilib
            output = "unilib:sand_red_antipodean 4",
            recipe = {
                {"unilib:stone_sandstone_antipodean"},
            }
        })

    end
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_antipodean",

        drop_name = "unilib:stone_sandstone_antipodean_cobble",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_sandstone_antipodean_block
        part_name = "sandstone_antipodean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Antipodean Sandstone Block"),
        img_list = {"unilib_stone_sandstone_antipodean.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_node(
        -- From australia:red_stonebrick
        "unilib:stone_sandstone_antipodean_brick",
        "australia:red_stonebrick",
        mode,
        {
            description = S("Antipodean Sandstone Bricks"),
            tiles = {"unilib_stone_sandstone_antipodean_brick.png"},
            groups = {cracky = 2, stone = 1},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From australia:red_stonebrick
        output = "unilib:stone_sandstone_antipodean_brick",
        ingredient = "unilib:stone_sandstone_antipodean",
    })
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_antipodean",
    })
    unilib.set_auto_rotate("unilib:stone_sandstone_antipodean_brick", unilib.auto_rotate_brick_flag)

    unilib.register_node("unilib:stone_sandstone_antipodean_cobble", "australia:red_cobble", mode, {
        -- From australia:red_cobble
        description = S("Antipodean Sandstone Cobble"),
        tiles = {"unilib_stone_sandstone_antipodean_cobble.png"},
        groups = {cracky = 3, stone = 2},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From australia:red_stone
        type = "cooking",
        output = "unilib:stone_sandstone_antipodean",
        recipe = "unilib:stone_sandstone_antipodean_cobble",
    })
    unilib.register_stone_cobble_cuttings({
        part_name = "sandstone_antipodean",

        replace_mode = mode,
    })

end
