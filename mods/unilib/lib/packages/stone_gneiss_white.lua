---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_gneiss_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_gneiss_white.init()

    return {
        description = "White gneiss",
        optional = "stone_schist_grey",
    }

end

function unilib.pkg.stone_gneiss_white.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "gneiss_white",
        description = S("White Gneiss"),

        category = "metamorphic",
        colour = "#BCC8C9",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("gneiss_white", 3, 2)

    unilib.register_node("unilib:stone_gneiss_white", "darkage:gneiss", mode, {
        -- From darkage:gneiss
        description = S("White Gneiss"),
        tiles = {"unilib_stone_gneiss_white.png"},
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:stone_gneiss_white_rubble"}, rarity = 3},
                {items = {"unilib:stone_gneiss_white"}}
            },
        },
    })
    unilib.register_craft({
        -- From darkage:gneiss
        type = "cooking",
        output = "unilib:stone_gneiss_white",
        recipe = "unilib:stone_gneiss_white_rubble",
    })
    if unilib.global.pkg_executed_table["stone_schist_grey"] ~= nil then

        unilib.register_craft({
            -- From darkage:gneiss
            type = "cooking",
            output = "unilib:stone_gneiss_white",
            recipe = "unilib:stone_schist_grey",
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_gneiss_white", {
        drop_name = "unilib:stone_gneiss_white_rubble",
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_gneiss_white", {
        facade_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "gneiss_white",

        drop_name = "unilib:stone_gneiss_white_rubble",
    })

    unilib.register_node("unilib:stone_gneiss_white_block", "darkage:gneiss_block", mode, {
        -- From darkage:gneiss_block
        description = S("White Gneiss Block"),
        tiles = {"unilib_stone_gneiss_white_block.png"},
        groups = {cracky = block_cracky, stone = 1, stoneblock = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From darkage:gneiss_block
        output = "unilib:stone_gneiss_white_block",
        ingredient = "unilib:stone_gneiss_white",
    })
    unilib.register_stone_block_cuttings({
        part_name = "gneiss_white",
    })

    unilib.register_node("unilib:stone_gneiss_white_brick", "darkage:gneiss_brick", mode, {
        -- From darkage:gneiss_brick
        description = S("White Gneiss Bricks"),
        tiles = {"unilib_stone_gneiss_white_brick.png"},
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From darkage:gneiss_brick
        output = "unilib:stone_gneiss_white_brick",
        ingredient = "unilib:stone_gneiss_white",
    })
    --[[
    unilib.register_stairs("unilib:stone_gneiss_white_brick", {
        img_rotate_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "gneiss_white",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_gneiss_white_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_node("unilib:stone_gneiss_white_rubble", "darkage:gneiss_rubble", mode, {
        -- From darkage:gneiss_rubble
        description = S("White Gneiss Rubble"),
        tiles = {"unilib_stone_gneiss_white_rubble.png"},
        groups = {cracky = 3, rubble = 1, stone = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    --[[
    unilib.register_stairs("unilib:stone_gneiss_white_rubble", {
        cooked_name = "unilib:stone_gneiss_white",
    })
    ]]--
    unilib.register_stone_rubble_cuttings({
        part_name = "gneiss_white",
    })

    unilib.register_stone_rubble_compressed({
        -- Original to unilib. Creates unilib:stone_gneiss_white_rubble_compressed
        part_name = "gneiss_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed White Gneiss Rubble"),
    })

    unilib.register_stone_rubble_condensed({
        -- Original to unilib. Creates unilib:stone_gneiss_white_rubble_condensed
        part_name = "gneiss_white",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed White Gneiss Rubble"),
    })

end
