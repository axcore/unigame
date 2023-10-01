---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_slate_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.australia.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slate_antipodean.init()

    return {
        description = "Antipodean slate",
    }

end

function unilib.pkg.stone_slate_antipodean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "slate_antipodean",
        description = S("Antipodean Slate"),

        category = "extrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 2,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("slate_antipodean", 2, nil)

    unilib.register_node("unilib:stone_slate_antipodean", "australia:bluestone", mode, {
        -- From australia:bluestone
        description = S("Antipodean Slate"),
        tiles = {"unilib_stone_slate_antipodean.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:stone_slate_antipodean_cobble",
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "slate_antipodean",

        drop_name = "unilib:stone_slate_antipodean_cobble",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_slate_antipodean_block
        part_name = "slate_antipodean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Antipodean Slate Block"),
        img_list = {"unilib_stone_slate_antipodean.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_node(
        -- From australia:bluestone_brick
        "unilib:stone_slate_antipodean_brick",
        "australia:bluestone_brick",
        mode,
        {
            description = S("Antipodean Slate Bricks"),
            tiles = {"unilib_stone_slate_antipodean_brick.png"},
            -- N.B. stonebrick = 1 not in original code
            groups = {cracky = 1, stone = 1, stonebrick = 1},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From australia:bluestone_brick
        output = "unilib:stone_slate_antipodean_brick",
        ingredient = "unilib:stone_slate_antipodean",
    })
    unilib.register_stone_brick_cuttings({
        part_name = "slate_antipodean",
    })
    unilib.set_auto_rotate("unilib:stone_slate_antipodean_brick", unilib.auto_rotate_brick_flag)

    unilib.register_node(
        -- From australia:bluestone_cobble
        "unilib:stone_slate_antipodean_cobble",
        "australia:bluestone_cobble",
        mode,
        {
            description = S("Antipodean Slate Cobble"),
            tiles = {"unilib_stone_slate_antipodean_cobble.png"},
            -- N.B. cobble = 1 not in original code
            groups = {cobble = 1, cracky = 2, stone = 2},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- From australia:bluestone
        type = "cooking",
        output = "unilib:stone_slate_antipodean",
        recipe = "unilib:stone_slate_antipodean_cobble",
    })
    unilib.register_stone_cobble_cuttings({
        part_name = "slate_antipodean",

        replace_mode = mode,
    })

end
