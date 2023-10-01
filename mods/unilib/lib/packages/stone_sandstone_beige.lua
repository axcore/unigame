---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_beige = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_beige.init()

    return {
        description = "Beige sandstone",
        optional = "sand_beige",
    }

end

function unilib.pkg.stone_sandstone_beige.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_beige",
        description = S("Beige Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_beige",
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 4)
        hardness = 1,
        hardness_real = 4,
        not_super_flag = true,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("sandstone_beige", 3, nil)

    unilib.register_node("unilib:stone_sandstone_beige", "default:yellow_sandstone", mode, {
        -- From decoblocks, default:yellow_sandstone
        description = S("Beige Sandstone"),
        tiles = {"unilib_stone_sandstone_beige.png"},
        -- N.B. cracky = 3, stone = 1 in original code. Changed to match minetest_game sandstones
        groups = {cracky = smooth_cracky, crumbly = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_2x2({
        -- Original to unilib
        output = "unilib:stone_sandstone_beige",
        ingredient = "unilib:sand_beige",
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:sand_beige 4",
        recipe = {
            {"unilib:stone_sandstone_beige"},
        }
    })
    --[[
    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_beige", {
            drop_name = "unilib:stone_sandstone_beige_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_beige", {
            group_type = "smooth",
        })

    end
    unilib.register_carvings("unilib:stone_sandstone_beige")
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_beige",

        sandstone_flag = true,
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_sandstone_beige_block
        part_name = "sandstone_beige",
        orig_name = nil,

        replace_mode = mode,
        description = S("Beige Sandstone Block"),
        img_list = {"unilib_stone_sandstone_beige.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_sandstone_beige_brick
        part_name = "sandstone_beige",
        orig_name = nil,

        replace_mode = mode,
        description = S("Beige Sandstone Bricks"),
        img_list = {"unilib_stone_sandstone_beige.png^unilib_stone_brick_overlay.png"},
    })

    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stone_cobble_or_rubble_or_nothing({
            -- Original to unilib. Depending on real hardness, creates
            --      unilib:stone_sandstone_beige_cobble, or unilib:stone_sandstone_beige_rubble, or
            --      nothing
            part_name = "sandstone_beige",
            cobble_description = S("Beige Sandstone Cobble"),
            rubble_description = S("Beige Sandstone Rubble"),

            replace_mode = mode,
            override_drop_flag = true,
        })

    end

end
