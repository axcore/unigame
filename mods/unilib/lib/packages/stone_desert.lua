---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_desert = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode
local unilib_add_mode = unilib.global.imported_mod_table.unilib.add_mode
local walls_add_mode = unilib.global.imported_mod_table.walls.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_desert.init()

    return {
        description = "Desert stone",
        optional = {"gravel_stone_desert", "mineral_mese"},
    }

end

function unilib.pkg.stone_desert.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "desert",
        description = S("Desert"),

        basic_platform_flag = true,
        category = "other",
        colour = "#814F3C",
        fictional_flag = true,
        grinder_flag = true,
        grinder_powder = "unilib:stone_desert_powder",
        grinder_gravel = "unilib:gravel_stone_desert",
        hardness = 1,
    })

    unilib.register_node("unilib:stone_desert", "default:desert_stone", default_add_mode, {
        -- From default:desert_stone
        description = S("Desert Stone"),
        tiles = {"unilib_stone_desert.png"},
        groups = {cracky = 3, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:stone_desert_cobble",
    })
    --[[
    unilib.register_stairs("unilib:stone_desert", {
        drop_name = "unilib:stone_desert_cobble",
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_desert", {
        all_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "desert",

        drop_name = "unilib:stone_desert_cobble",
    })
    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["mineral_mese"] ~= nil and
            (moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")) then

        unilib.register_stone_trap({
            -- From moreblocks:trap_desert_stone. Creates unilib:stone_desert_trap
            orig_name = "moreblocks:trap_desert_stone",
            ingredient = "unilib:stone_desert",
            replace_mode = moreblocks_add_mode,
            group_table = {cracky = 3},
        })

    end

    unilib.register_node(
        -- From default:desert_stone_block
        "unilib:stone_desert_block",
        "default:desert_stone_block",
        default_add_mode,
        {
            description = S("Desert Stone Block"),
            tiles = {"unilib_stone_desert_block.png"},
            groups = {cracky = 2, stone = 1, stoneblock = 1},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From default:desert_stone_block
        output = "unilib:stone_desert_block",
        ingredient = "unilib:stone_desert",
    })
    --[[
    unilib.register_stairs("unilib:stone_desert_block")
    unilib.register_carvings("unilib:stone_desert_block", {
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "desert",
    })

    unilib.register_node(
        -- From default:desert_stonebrick
        "unilib:stone_desert_brick",
        "default:desert_stonebrick",
        default_add_mode,
        {
            description = S("Desert Stone Bricks"),
            tiles = {"unilib_stone_desert_brick.png"},
            groups = {cracky = 2, stone = 1, stonebrick = 1},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_2x2x4({
        -- From default:desert_stonebrick
        output = "unilib:stone_desert_brick",
        ingredient = "unilib:stone_desert",
    })
    --[[
    unilib.register_stairs("unilib:stone_desert_brick", {
        img_rotate_flag = true,
    })
    unilib.register_carvings("unilib:stone_desert_brick", {
        brick_flag = true,
        column_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "desert",
    })
    unilib.utils.set_auto_rotate("unilib:stone_desert_brick", unilib.setting.auto_rotate_brick_flag)

    unilib.register_node(
        -- From default:desert_cobble
        "unilib:stone_desert_cobble",
        "default:desert_cobble",
        default_add_mode,
        {
            description = S("Desert Cobblestone"),
            tiles = {"unilib_stone_desert_cobble.png"},
            groups = {cobble = 1, cracky = 3, stone = 2},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- From default:desert_stone
        type = "cooking",
        output = "unilib:stone_desert",
        recipe = "unilib:stone_desert_cobble",
    })
    --[[
    unilib.register_stairs("unilib:stone_desert_cobble", {
        -- From default:desert_stone
        cooked_name = "unilib:stone_desert",
        group_type = "cobble",
    })
    unilib.register_carvings("unilib:stone_desert_cobble", {
        millwork_flag = true,
    })
    unilib.register_wall({
        -- From walls:desertcobble
        orig_name = "walls:desertcobble",
        ingredient = "unilib:stone_desert_cobble",

        replace_mode = walls_add_mode,
        description = S("Desert Cobblestone Wall"),
        sound_name = "stone",
        img_list = {"unilib_stone_desert_cobble.png"},
    })
    ]]--
    unilib.register_stone_cobble_cuttings({
        part_name = "desert",

        replace_mode = default_add_mode,
        wall_orig_name = "walls:desertcobble",
    })

    if unilib.setting.squeezed_stone_flag and (
        moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")
    ) then

        -- N.B. moreblocks code tweaked to match compressed cobbles in underch
        unilib.register_node(
            -- From moreblocks:desert_cobble_compressed
            "unilib:stone_desert_cobble_compressed",
            "moreblocks:desert_cobble_compressed",
            moreblocks_add_mode,
            {
                description = S("Compressed Desert Cobblestone"),
                tiles = {"unilib_stone_desert_cobble_compressed.png"},
--              groups = {compressedstone = 1, cracky = 1},
                groups = {compressedstone = 1, cracky = 3},
                sounds = unilib.global.sound_table.stone,

                is_ground_content = false,
                stack_max = unilib.global.squeezed_stack_max,
            }
        )
        unilib.misc.set_squeezed_recipes(
            -- From moreblocks:desert_cobble_compressed
            "unilib:stone_desert_cobble",
            "unilib:stone_desert_cobble_compressed"
        )
        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:stone_desert 9",
            recipe = "unilib:stone_desert_cobble_compressed",
        })
--      unilib.register_stairs("unilib:stone_desert_cobble_compressed")

    end

    if unilib.setting.squeezed_stone_flag then

        -- N.B. Condensed cobble does not appear in moreblocks
        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_desert_cobble_condensed
            part_name = "desert",
            orig_name = nil,

            replace_mode = moreblocks_add_mode,
            description = S("Condensed Desert Cobblestone"),
        })

    end

    if unilib.setting.technic_update_flag then

        -- N.B. The technic grinding recipe is provided in
        --      ../lib/system/load/load_consolidate_technic.lua
        unilib.register_craftitem("unilib:stone_desert_powder", nil, unilib_add_mode, {
            -- Original to unilib
            description = S("Desert Stone Powder"),
            inventory_image = "unilib_stone_desert_powder.png",
        })
        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:stone_desert",
            recipe = "unilib:stone_desert_powder",
        })

    end

end
