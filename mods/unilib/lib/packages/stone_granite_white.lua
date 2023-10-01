---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_white = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_white.init()

    return {
        description = "White granite",
    }

end

function unilib.pkg.stone_granite_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_white",
        description = S("White Granite"),

        category = "intrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3/4)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("granite_white", 3, 3)

    unilib.register_node("unilib:stone_granite_white", "mapgen:granite", mode, {
        -- From farlands, mapgen:granite
        description = S("White Granite"),
        tiles = {"unilib_stone_granite_white.png"},
        -- N.B. granite = 1, smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, granite = 1, stone = 1, smoothstone = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "granite_white",
    })

    unilib.register_node("unilib:stone_granite_white_block", "decoblocks:refined_granite", mode, {
        -- From farlands, decoblocks:refined_granite
        description = S("White Granite Block"),
        tiles = {"unilib_stone_granite_white_block.png"},
        -- N.B. stoneblock = 1 not in original code
        groups = {cracky = block_cracky, stone = 1, stoneblock = 1},
        sounds = unilib.sound_table.stone,
    })
    -- N.B. For consistency, replaced the original craft recipe with a standard one
    --[[
    unilib.register_craft({
        -- From farlands, decoblocks:refined_granite
        type = "cooking",
        output = "unilib:stone_granite_white_block",
        recipe = "unilib:stone_granite_white",
        cooktime = 5,
    })
    ]]--
    unilib.register_craft_3x3x9({
        -- Original to unilib
        output = "unilib:stone_granite_white_block",
        ingredient = "unilib:stone_granite_white",
    })
    unilib.register_stone_block_cuttings({
        part_name = "granite_white",
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_granite_white_brick
        part_name = "granite_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("White Granite Bricks"),
        img_list = {"unilib_stone_granite_white.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates
        --      unilib:stone_granite_white_cobble, or unilib:stone_granite_white_rubble, or nothing
        part_name = "granite_white",
        cobble_description = S("White Granite Cobble"),
        rubble_description = S("White Granite Rubble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
