---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_pink = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_pink.init()

    return {
        description = "Pink granite",
    }

end

function unilib.pkg.stone_granite_pink.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_pink",
        description = S("Pink Granite"),

        category = "intrusive",
        colour = "#C39198",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3/4)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("granite_pink", 3, 3)

    unilib.register_node("unilib:stone_granite_pink", "mapgen:granite_brown", mode, {
        -- From farlands, mapgen:granite_brown
        description = S("Pink Granite"),
        tiles = {"unilib_stone_granite_pink.png"},
        -- N.B. granite = 1, smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, granite = 1, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "granite_pink",
    })

    unilib.register_node(
        -- From farlands, decoblocks:refined_granite_brown
        "unilib:stone_granite_pink_block",
        "decoblocks:refined_granite_brown",
        mode,
        {
            description = S("Pink Granite Block"),
            tiles = {"unilib_stone_granite_pink_block.png"},
            -- N.B. stoneblock = 1 not in original code
            groups = {cracky = block_cracky, stoneblock = 1, stone = 1},
            sounds = unilib.global.sound_table.stone,

            -- N.B. is_ground_content = false not in original code; added to match other stones
            is_ground_content = false,
        }
    )
    -- N.B. For consistency, replaced the original craft recipe with a standard one
    --[[
    unilib.register_craft({
        -- From farlands, decoblocks:refined_granite_brown
        type = "cooking",
        output = "unilib:stone_granite_pink_block",
        recipe = "unilib:stone_granite_pink",
        cooktime = 5,
    })
    ]]--
    unilib.register_craft_3x3x9({
        -- Original to unilib
        output = "unilib:stone_granite_pink_block",
        ingredient = "unilib:stone_granite_pink",
    })
    unilib.register_stone_block_cuttings({
        part_name = "granite_pink",
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_granite_pink_brick
        part_name = "granite_pink",
        orig_name = nil,

        replace_mode = mode,
        description = S("Pink Granite Bricks"),
        img_list = {"unilib_stone_granite_pink.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_granite_pink_cobble,
        --      or unilib:stone_granite_pink_rubble, or nothing
        part_name = "granite_pink",
        cobble_description = S("Pink Granite Cobble"),
        cobble_compressed_description = S("Compressed Pink Granite Cobble"),
        cobble_condensed_description = S("Condensed Pink Granite Cobble"),
        rubble_description = S("Pink Granite Rubble"),
        rubble_compressed_description = S("Compressed Pink Granite Rubble"),
        rubble_condensed_description = S("Condensed Pink Granite Rubble"),
        smooth_compressed_description = S("Compressed Pink Granite"),
        smooth_condensed_description = S("Condensed Pink Granite"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
