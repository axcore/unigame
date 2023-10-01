---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_old_red = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_old_red.init()

    return {
        description = "Old red sandstone",
        optional = {"metal_iron", "sand_red", "stone_desert", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.stone_sandstone_old_red.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "sandstone_old_red",
        description = S("Old Red Sandstone"),

        category = "sedimentary",
        grinder_flag = true,
        grinder_powder = "unilib:sand_red",
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 4)
        hardness = 2,
        hardness_real = 4,
        not_super_flag = true,
    })

    -- (preserve original cracky values for smoothstone and blocks)

    unilib.register_node("unilib:stone_sandstone_old_red", "darkage:ors", mode, {
        -- From darkage:ors
        description = S("Old Red Sandstone"),
        tiles = {"unilib_stone_sandstone_old_red.png"},
        groups = {cracky = 2, smoothstone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:stone_sandstone_old_red_rubble",
    })
    unilib.register_craft({
        -- From darkage:ors
        type = "cooking",
        output = "unilib:stone_sandstone_old_red",
        recipe = "unilib:stone_sandstone_old_red_rubble",
    })
    if unilib.pkg_executed_table["metal_iron"] ~= nil and
            unilib.pkg_executed_table["stone_sandstone_ordinary"] ~= nil then

        unilib.register_craft({
            -- From darkage:ors
            output = "unilib:stone_sandstone_old_red 4",
            recipe = {
                {"unilib:stone_sandstone_ordinary", "unilib:stone_sandstone_ordinary"},
                {"unilib:metal_iron_lump", "unilib:stone_sandstone_ordinary"},
            }
        })

    end
    --[[
    if unilib.sandstone_cobble_rubble_flag then

        unilib.register_stairs("unilib:stone_sandstone_old_red", {
            drop_name = "unilib:stone_sandstone_old_red_rubble",
            group_type = "smooth",
        })

    else

        unilib.register_stairs("unilib:stone_sandstone_old_red", {
            group_type = "smooth",
        })

    end
    unilib.register_carvings("unilib:stone_sandstone_old_red", {
        facade_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "sandstone_old_red",

        drop_name = "unilib:stone_sandstone_old_red_rubble",
    })

    unilib.register_node("unilib:stone_sandstone_old_red_block", "darkage:ors_block", mode, {
        -- From darkage:ors_block
        description = S("Old Red Sandstone Block"),
        tiles = {"unilib_stone_sandstone_old_red_block.png"},
        groups = {cracky = 3, stone = 2, stoneblock = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From darkage:ors_block
        output = "unilib:stone_sandstone_old_red_block",
        ingredient = "unilib:stone_sandstone_old_red",
    })
    unilib.register_stone_block_cuttings({
        part_name = "sandstone_old_red",
    })

    unilib.register_node("unilib:stone_sandstone_old_red_brick", "darkage:ors_brick", mode, {
        -- From darkage:ors_brick
        description = S("Old Red Sandstone Brick"),
        tiles = {"unilib_stone_sandstone_old_red_brick.png"},
        groups = {cracky = 3, stone = 2, stonebrick = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From darkage:ors_brick
        output = "unilib:stone_sandstone_old_red_brick",
        ingredient = "unilib:stone_sandstone_old_red",
    })
    if unilib.pkg_executed_table["stone_desert"] ~= nil then

        unilib.register_craft({
            -- From darkage:ors_brick
            type = "cooking",
            output = "unilib:stone_sandstone_old_red_brick",
            recipe = "unilib:stone_desert",
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_sandstone_old_red_brick", {
        img_rotate_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "sandstone_old_red",
    })
    unilib.set_auto_rotate("unilib:stone_sandstone_old_red_brick", unilib.auto_rotate_brick_flag)

    unilib.register_node("unilib:stone_sandstone_old_red_rubble", "darkage:ors_rubble", mode, {
        -- From darkage:ors_rubble
        description = S("Old Red Sandstone Rubble"),
        tiles = {"unilib_stone_sandstone_old_red_rubble.png"},
        groups = {cracky = 3, crumbly = 2, rubble = 1, stone = 2},
        sounds = unilib.sound_table.stone,
    })
    --[[
    unilib.register_stairs("unilib:stone_sandstone_old_red_rubble", {
        cooked_name = "unilib:stone_sandstone_old_red",
    })
    ]]--
    unilib.register_stone_rubble_cuttings({
        part_name = "sandstone_old_red",
    })
    -- N.B. Special exception for darkage stones: allow rubble walls
    if unilib.super_stone_table["sandstone_old_red"] ~= nil then

        unilib.register_wall({
            -- From darkage:ors_rubble
            orig_name = "darkage:ors_rubble_wall",
            ingredient = "unilib:stone_sandstone_old_red_rubble",

            replace_mode = mode,
            description = S("Old Red Sandstone Rubble Wall"),
            sound_name = "stone",
            img_list = {"unilib_stone_sandstone_old_red_rubble.png"},
        })

    end

end
