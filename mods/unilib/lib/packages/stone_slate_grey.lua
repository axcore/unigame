---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_slate_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_slate_grey.init()

    return {
        description = "Grey slate",
        optional = "stone_shale_brown",
    }

end

function unilib.pkg.stone_slate_grey.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "slate_grey",
        description = S("Grey Slate"),

        category = "metamorphic",
        grinder_flag = true,
        hardness = 2,
    })

    unilib.register_node("unilib:stone_slate_grey", "darkage:slate", mode, {
        -- From darkage:slate
        description = S("Grey Slate"),
        tiles = {
            "unilib_stone_slate_grey.png",
            "unilib_stone_slate_grey.png",
            "unilib_stone_slate_grey_side.png",
        },
        -- N.B. stone = 1 not in original code
        groups = {cracky = 2, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:stone_slate_grey_rubble",
    })
    unilib.register_craft({
        -- From darkage:slate
        type = "cooking",
        output = "unilib:stone_slate_grey",
        recipe = "unilib:stone_slate_grey_rubble",
    })
    if unilib.pkg_executed_table["stone_shale_brown"] ~= nil then

        unilib.register_craft({
            -- From darkage:slate
            type = "cooking",
            output = "unilib:stone_slate_grey",
            recipe = "unilib:stone_shale_brown",
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_slate_grey", {
        drop_name = "unilib:stone_slate_grey_rubble",
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_slate_grey", {
        facade_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "slate_grey",

        drop_name = "unilib:stone_slate_grey_rubble",
    })

    unilib.register_node("unilib:stone_slate_grey_block", "darkage:slate_block", mode, {
        -- From darkage:slate_block
        description = S("Grey Slate Block"),
        tiles = {"unilib_stone_slate_grey_block.png"},
        -- N.B. stone = 1 not in original code
        groups = {cracky = 2, stone = 1, stoneblock = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From darkage:slate_block
        output = "unilib:stone_slate_grey_block",
        ingredient = "unilib:stone_slate_grey",
    })
    unilib.register_stone_block_cuttings({
        part_name = "slate_grey",
    })

    unilib.register_node("unilib:stone_slate_grey_brick", "darkage:slate_brick", mode, {
        -- From darkage:slate_brick
        description = S("Grey Slate Bricks"),
        tiles = {"unilib_stone_slate_grey_brick.png"},
        -- N.B. stone = 1 not in original code
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From darkage:slate_brick
        output = "unilib:stone_slate_grey_brick",
        ingredient = "unilib:stone_slate_grey",
    })
    --[[
    unilib.register_stairs("unilib:stone_slate_grey_brick", {
        img_rotate_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "slate_grey",
    })
    unilib.set_auto_rotate("unilib:stone_slate_grey_brick", unilib.auto_rotate_brick_flag)

    unilib.register_node("unilib:stone_slate_grey_rubble", "darkage:slate_rubble", mode, {
        -- From darkage:slate_rubble
        description = S("Grey Slate Rubble"),
        tiles = {"unilib_stone_slate_grey_rubble.png"},
        groups = {cracky = 2, rubble = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    --[[
    unilib.register_stairs("unilib:stone_slate_grey_rubble", {
        cooked_name = "unilib:stone_slate_grey",
    })
    ]]--
    unilib.register_stone_rubble_cuttings({
        part_name = "slate_grey",
    })
    -- N.B. Special exception for darkage stones: allow rubble walls
    if unilib.super_stone_table["slate_grey"] ~= nil then

        unilib.register_wall({
            -- From darkage:slate_rubble
            orig_name = "darkage:slate_rubble",
            ingredient = "unilib:stone_slate_grey_rubble",

            replace_mode = mode,
            description = S("Grey Slate Rubble Wall"),
            sound_name = "stone",
            img_list = {"unilib_stone_slate_grey_rubble.png"},
        })

    end

    unilib.register_node("unilib:stone_slate_grey_tile", "darkage:slate_tile", mode, {
        -- From darkage:slate_tile
        description = S("Grey Slate Tile"),
        tiles = {"unilib_stone_slate_grey_tile.png"},
        groups = {cracky = 2},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From darkage:slate_tile
        output = "unilib:stone_slate_grey_tile 2",
        recipe = {
            {"unilib:stone_slate_grey_brick", "unilib:stone_slate_grey_brick"},
            {"unilib:stone_slate_grey_brick", "unilib:stone_slate_grey_brick"},
        }
    })
    if unilib.super_stone_table["slate_grey"] ~= nil then
        unilib.register_stairs("unilib:stone_slate_grey_tile")
    end

end
