---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    badlands
-- Code:    LGPL-3.0
-- Media:   LGPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_barren = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.badlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_barren.init()

    return {
        description = "Barren sandstone",
        depends = "sand_barren",
    }

end

function unilib.pkg.stone_sandstone_barren.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_barren",
        description = S("Barren Sandstone"),

        category = "sedimentary",
        colour = "#B76447",
        grinder_flag = true,
        grinder_powder = "unilib:sand_barren",
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 4)
        hardness = 1,
        hardness_real = 4,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("sandstone_barren", 3, 2)

    unilib.register_node("unilib:stone_sandstone_barren", "badlands:red_sandstone", mode, {
        -- From badlands:red_sandstone
        description = S("Barren Sandstone"),
        tiles = {"unilib_stone_sandstone_ordinary.png^[colorize:sienna:175^[colorize:red:40"},
        groups = {cracky = smooth_cracky, crumbly = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_craft_2x2({
        -- From badlands:red_sandstone
        output = "unilib:stone_sandstone_barren",
        ingredient = "unilib:sand_barren",
    })
    unilib.register_craft({
        -- From badlands:red_sandstone
        output = "unilib:sand_barren 4",
        recipe = {
            {"unilib:stone_sandstone_barren"},
        },
    })

    unilib.register_node(
        -- From badlands:red_sandstone_block
        "unilib:stone_sandstone_barren_block",
        "badlands:red_sandstone_block",
        mode,
        {
            description = S("Barren Sandstone Block"),
            tiles = {
                "unilib_stone_sandstone_ordinary_block.png^[colorize:sienna:175^[colorize:red:40",
            },
            groups = {cracky = block_cracky},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From badlands:red_sandstone_block
        output = "unilib:stone_sandstone_barren_block",
        ingredient = "unilib:stone_sandstone_barren",
    })

    unilib.register_node(
        -- From badlands:red_sandstone_brick
        "unilib:stone_sandstone_barren_brick",
        "badlands:red_sandstone_brick",
        mode,
        {
            description = S("Barren Sandstone Brick"),
            tiles = {
                "unilib_stone_sandstone_ordinary_brick.png^[colorize:sienna:175^[colorize:red:40",
            },
            groups = {cracky = 2},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
            paramtype2 = "facedir",
            place_param2 = 0,
        }
    )
    unilib.register_craft_2x2x4({
        -- From badlands:red_sandstone_brick
        output = "unilib:stone_sandstone_barren_brick",
        ingredient = "unilib:stone_sandstone_barren",
    })

end
