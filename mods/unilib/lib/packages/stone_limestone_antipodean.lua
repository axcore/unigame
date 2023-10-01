---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_limestone_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_limestone_antipodean.init()

    return {
        description = "Antipodean limestone",
        optional = {"coral_block_brown", "coral_block_orange", "stone_limestone_coquina"},
    }

end

function unilib.pkg.stone_limestone_antipodean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "limestone_antipodean",
        description = S("Antipodean Limestone"),

        category = "sedimentary",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 1)
        hardness = 2,
        hardness_real = 1,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("limestone_antipodean", 2, 2)

    unilib.register_node("unilib:stone_limestone_antipodean", "aotearoa:limestone", mode, {
        -- From aotearoa:limestone
        description = S("Antipodean Limestone"),
        tiles = {"unilib_stone_limestone_antipodean.png"},
        -- N.B. limestone = 1, smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, limestone = 1, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drops smoothstone in original code
    })
    if unilib.pkg_executed_table["stone_limestone_coquina"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:limestone
            type = "cooking",
            output = "unilib:stone_limestone_antipodean",
            recipe = "unilib:stone_limestone_coquina",
            cooktime = 120,
        })

    end
    -- N.B. original code uses non-existence "default:coral"
    if unilib.pkg_executed_table["coral_block_brown"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:limestone
            type = "cooking",
            output = "unilib:stone_limestone_antipodean",
            recipe = "unilib:coral_block_brown",
            cooktime = 120,
        })

    end
    if unilib.pkg_executed_table["coral_block_orange"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:limestone
            type = "cooking",
            output = "unilib:stone_limestone_antipodean",
            recipe = "unilib:coral_block_orange",
            cooktime = 120,
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_limestone_antipodean", {
        basic_flag = true,
        drop_name = "unilib:stone_limestone_antipodean_cobble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "limestone_antipodean",
    })

    unilib.register_node(
        -- From aotearoa:limestone_block
        "unilib:stone_limestone_antipodean_block",
        "aotearoa:limestone_block",
        mode,
        {
            description = S("Antipodean Limestone Block"),
            tiles = {"unilib_stone_limestone_antipodean_block.png"},
            -- N.B. stoneblock = 1 not in original code
            groups = {cracky = block_cracky, stone = 1, stoneblock = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_3x3x9({
        -- From aotearoa:limestone_block
        output = "unilib:stone_limestone_antipodean_block",
        ingredient = "unilib:stone_limestone_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_limestone_antipodean_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "limestone_antipodean",
    })

    unilib.register_node(
        -- From aotearoa:limestonebrick
        "unilib:stone_limestone_antipodean_brick",
        "aotearoa:limestonebrick",
        mode,
            {
            description = S("Antipodean Limestone Bricks"),
            tiles = {"unilib_stone_limestone_antipodean_brick.png"},
            -- N.B. stonebrick = 1 not in original code
            groups = {cracky = 2, stone = 1, stonebrick = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_2x2x4({
        -- From aotearoa:limestonebrick
        output = "unilib:stone_limestone_antipodean_brick",
        ingredient = "unilib:stone_limestone_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_limestone_antipodean_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "limestone_antipodean",
    })
    unilib.set_auto_rotate("unilib:stone_limestone_antipodean_brick", unilib.auto_rotate_brick_flag)

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates
        --      unilib:stone_limestone_antipodean_cobble, or
        --      unilib:stone_limestone_antipodean_rubble, or nothing
        part_name = "limestone_antipodean",
        cobble_description = S("Antipodean Limestone Cobble"),
        rubble_description = S("Antipodean Limestone Rubble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
