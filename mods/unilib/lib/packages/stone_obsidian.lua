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

unilib.pkg.stone_obsidian = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.global.imported_mod_table.moreblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_obsidian.init()

    return {
        description = "Obsidian stone",
        optional = "mineral_mese",
    }

end

function unilib.pkg.stone_obsidian.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "obsidian",
        description = S("Obsidian"),

        basic_platform_flag = true,
        category = "extrusive",
        colour = "#1F2631",
        grinder_flag = false,
        hardness = 4,
    })

    unilib.register_node("unilib:stone_obsidian", "default:obsidian", default_add_mode, {
        -- From default:obsidian
        description = S("Obsidian Stone"),
        tiles = {"unilib_stone_obsidian.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.stone,
    })
    unilib.register_craft_3x3({
        -- From default:obsidian
        output = "unilib:stone_obsidian",
        ingredient = "unilib:stone_obsidian_shard",
    })
    --[[
    unilib.register_stairs("unilib:stone_obsidian", {
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_obsidian", {
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "obsidian",

        drop_name = "unilib:stone_obsidian",
    })
    if unilib.setting.mtgame_tweak_flag and
            unilib.global.pkg_executed_table["mineral_mese"] ~= nil and
            (moreblocks_add_mode ~= "defer" or not core.get_modpath("moreblocks")) then

        unilib.register_stone_trap({
            -- From moreblocks:trap_obsidian. Creates unilib:stone_obsidian_trap
            orig_name = "moreblocks:trap_obsidian",
            ingredient = "unilib:stone_obsidian",
            replace_mode = moreblocks_add_mode,
            group_table = {cracky = 1, level = 2},
        })

    end

    unilib.register_node(
        -- From default:obsidian_block
        "unilib:stone_obsidian_block",
        "default:obsidian_block",
        default_add_mode,
        {
            description = S("Obsidian Stone Block"),
            tiles = {"unilib_stone_obsidian_block.png"},
            groups = {cracky = 1, level = 2},
            sounds = unilib.global.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft_3x3x9({
        -- From default:obsidian_block
        output = "unilib:stone_obsidian_block",
        ingredient = "unilib:stone_obsidian",
    })
    --[[
    unilib.register_stairs("unilib:stone_obsidian_block")
    unilib.register_carvings("unilib:stone_obsidian_block", {
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "obsidian",
    })

    unilib.register_node("unilib:stone_obsidian_brick", "default:obsidianbrick", default_add_mode, {
        -- From default:obsidianbrick
        description = S("Obsidian Stone Bricks"),
        tiles = {"unilib_stone_obsidian_brick.png"},
        groups = {cracky = 1, level = 2},
        sounds = unilib.global.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From default:obsidianbrick
        output = "unilib:stone_obsidian_brick",
        ingredient = "unilib:stone_obsidian",
    })
    --[[
    unilib.register_stairs("unilib:stone_obsidian_brick", {
        img_rotate_flag = true,
    })
    unilib.register_carvings("unilib:stone_obsidian_brick", {
        brick_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "obsidian",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_obsidian_brick", unilib.setting.auto_rotate_brick_flag
    )

    unilib.register_craftitem(
        -- From default:obsidian_shard
        "unilib:stone_obsidian_shard",
        "default:obsidian_shard",
        default_add_mode,
        {
            description = S("Obsidian Stone Shard"),
            inventory_image = "unilib_stone_obsidian_shard.png",
        }
    )
    unilib.register_craft({
        -- From default:obsidian_shard
        output = "unilib:stone_obsidian_shard 9",
        recipe = {
            {"unilib:stone_obsidian"},
        },
    })

end
