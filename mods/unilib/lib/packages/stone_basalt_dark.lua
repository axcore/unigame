---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_basalt_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_basalt_dark.init()

    return {
        description = "Dark basalt",
        depends = {"mineral_coal", "stone_ordinary"},
    }

end

function unilib.pkg.stone_basalt_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "basalt_dark",
        description = S("Dark Basalt"),

        category = "extrusive",
        colour = "#3D3938",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("basalt_dark", 3, 2)

    unilib.register_node("unilib:stone_basalt_dark", "darkage:basalt", mode, {
        -- From darkage:basalt
        description = S("Dark Basalt"),
        tiles = {"unilib_stone_basalt_dark.png"},
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = {
            max_items = 1,
            items = {
                {items = {"unilib:stone_basalt_dark_rubble"}, rarity = 3},
                {items = {"unilib:stone_basalt_dark"}},
            },
        },
    })
    unilib.register_craft({
        -- From darkage:basalt
        type = "cooking",
        output = "unilib:stone_basalt_dark",
        recipe = "unilib:stone_basalt_dark_rubble",
    })
    --[[
    unilib.register_stairs("unilib:stone_basalt_dark", {
        drop_name = "unilib:stone_basalt_dark_rubble",
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_basalt_dark", {
        facade_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "basalt_dark",

        drop_name = "unilib:stone_basalt_dark_rubble",
    })

    unilib.register_node("unilib:stone_basalt_dark_block", "darkage:basalt_block", mode, {
        -- From darkage:basalt_block
        description = S("Dark Basalt Block"),
        tiles = {"unilib_stone_basalt_dark_block.png"},
        groups = {cracky = block_cracky, stone = 1, stoneblock = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From darkage:basalt_block
        output = "unilib:stone_basalt_dark_block",
        ingredient = "unilib:stone_basalt_dark",
    })
    unilib.register_stone_block_cuttings({
        part_name = "basalt_dark",
    })

    unilib.register_node("unilib:stone_basalt_dark_brick", "darkage:basalt_brick", mode, {
        -- From darkage:basalt_brick
        description = S("Dark Basalt Bricks"),
        tiles = {"unilib_stone_basalt_dark_brick.png"},
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From darkage:basalt_brick
        output = "unilib:stone_basalt_dark_brick",
        ingredient = "unilib:stone_basalt_dark",
    })
    --[[
    unilib.register_stairs("unilib:stone_basalt_dark_brick", {
        img_rotate_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "basalt_dark",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_basalt_dark_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_node("unilib:stone_basalt_dark_rubble", "darkage:basalt_rubble", mode, {
        -- From darkage:basalt_rubble
        description = S("Dark Basalt Rubble"),
        tiles = {"unilib_stone_basalt_dark_rubble.png"},
        groups = {cracky = 3, rubble = 1, stone = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    if unilib.global.pkg_executed_table["mineral_coal"] ~= nil and
            unilib.global.pkg_executed_table["stone_ordinary"] ~= nil then

        unilib.register_craft({
            -- From darkage:basalt_rubble
            output = "unilib:stone_basalt_dark_rubble 4",
            recipe = {
                {"unilib:stone_ordinary_cobble", "unilib:stone_ordinary_cobble"},
                {"unilib:mineral_coal_lump", "unilib:mineral_coal_lump"},
            },
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_basalt_dark_rubble", {
        cooked_name = "unilib:stone_basalt_dark",
    })
    ]]--
    unilib.register_stone_rubble_cuttings({
        part_name = "basalt_dark",
    })
    -- N.B. Special exception for darkage stones: allow rubble walls
    if unilib.global.super_stone_table["basalt_dark"] ~= nil then

        unilib.register_wall({
            -- From darkage:basalt_rubble
            orig_name = "darkage:basalt_rubble_wall",
            ingredient = "unilib:stone_basalt_dark_rubble",

            replace_mode = mode,
            description = S("Dark Basalt Rubble Wall"),
            sound_name = "stone",
            img_list = {"unilib_stone_basalt_dark_rubble.png"},
        })

    end

    unilib.register_stone_rubble_compressed({
        -- Original to unilib. Creates unilib:stone_basalt_dark_rubble_compressed
        part_name = "basalt_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Dark Basalt Rubble"),
    })

    unilib.register_stone_rubble_condensed({
        -- Original to unilib. Creates unilib:stone_basalt_dark_rubble_condensed
        part_name = "basalt_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Dark Basalt Rubble"),
    })

end
