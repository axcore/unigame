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
--
-- From:    technic/technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ordinary = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode
local moreblocks_add_mode = unilib.imported_mod_table.moreblocks.add_mode
local technic_add_mode = unilib.imported_mod_table.technic.add_mode
local walls_add_mode = unilib.imported_mod_table.walls.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ordinary.init()

    return {
        description = "Ordinary stone",
        optional = {"grass_jungle", "mineral_mese", "moss_green"},
    }

end

function unilib.pkg.stone_ordinary.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "ordinary",
        description = S("Ordinary"),

        basic_platform_flag = true,
        category = "other",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
        moss_flag = true,
    })

    unilib.register_node("unilib:stone_ordinary", "default:stone", default_add_mode, {
        -- From default:stone
        description = S("Ordinary Stone"),
        tiles = {"unilib_stone_ordinary.png"},
        groups = {cracky = 3, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:stone_ordinary_cobble",
    })
    --[[
    unilib.register_stairs("unilib:stone_ordinary", {
        drop_name = "unilib:stone_ordinary_cobble",
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_ordinary", {
        all_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "ordinary",

        drop_name = "unilib:stone_ordinary_cobble",
    })
    if unilib.mtgame_tweak_flag and
            unilib.pkg_executed_table["mineral_mese"] ~= nil and
            moreblocks_add_mode ~= "defer" then

        unilib.register_stone_trap({
            -- From moreblocks:trap_stone. Creates unilib:stone_ordinary_trap
            orig_name = "moreblocks:trap_stone",
            ingredient = "unilib:stone_ordinary",
            replace_mode = moreblocks_add_mode,
            group_table = {cracky = 3},
        })

    end

    unilib.register_node("unilib:stone_ordinary_block", "default:stone_block", default_add_mode, {
        -- From default:stone_block
        description = S("Ordinary Stone Block"),
        tiles = {"unilib_stone_ordinary_block.png"},
        groups = {cracky = 2, stone = 1, stoneblock = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From default:stone_block
        output = "unilib:stone_ordinary_block",
        ingredient = "unilib:stone_ordinary",
    })
    --[[
    unilib.register_stairs("unilib:stone_ordinary_block")
    unilib.register_carvings("unilib:stone_ordinary_block", {
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "ordinary",
    })

    unilib.register_node("unilib:stone_ordinary_brick", "default:stonebrick", default_add_mode, {
        -- From default:stonebrick
        description = S("Ordinary Stone Bricks"),
        tiles = {"unilib_stone_ordinary_brick.png"},
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From default:stonebrick
        output = "unilib:stone_ordinary_brick",
        ingredient = "unilib:stone_ordinary",
    })
    --[[
    unilib.register_stairs("unilib:stone_ordinary_brick", {
        img_rotate_flag = true,
    })
    unilib.register_carvings("unilib:stone_ordinary_brick", {
        brick_flag = true,
        column_flag = true,
        millwork_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "ordinary",
    })
    unilib.set_auto_rotate("unilib:stone_ordinary_brick", unilib.auto_rotate_brick_flag)

    unilib.register_node("unilib:stone_ordinary_cobble", "default:cobble", default_add_mode, {
        -- From default:cobble
        description = S("Ordinary Cobblestone"),
        tiles = {"unilib_stone_ordinary_cobble.png"},
        groups = {cobble = 1, cracky = 3, stone = 2},
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
    })
    unilib.register_craft({
        -- From default:stone
        type = "cooking",
        output = "unilib:stone_ordinary",
        recipe = "unilib:stone_ordinary_cobble",
    })
    --[[
    unilib.register_stairs("unilib:stone_ordinary_cobble", {
        cooked_name = "unilib:stone_ordinary",
        group_type = "cobble",
    })
    unilib.register_carvings("unilib:stone_ordinary_cobble", {
        column_flag = true,
        millwork_flag = true,
    })
    unilib.register_wall({
        -- From walls:cobble
        orig_name = "walls:cobble",
        ingredient = "unilib:stone_ordinary_cobble",

        replace_mode = walls_add_mode,
        description = S("Ordinary Cobblestone Wall"),
        sound_name = "stone",
        img_list = {"unilib_stone_ordinary_cobble.png"},
    })
    ]]--
    unilib.register_stone_cobble_cuttings({
        part_name = "ordinary",

        replace_mode = default_add_mode,
        wall_orig_name = "walls:cobble",
    })

    unilib.register_node(
        -- From default:mossycobble
        "unilib:stone_ordinary_cobble_mossy",
        "default:mossycobble",
        default_add_mode,
        {
            description = S("Mossy Ordinary Cobblestone"),
            tiles = {"unilib_stone_ordinary_cobble_mossy.png"},
            groups = {cracky = 3, mossycobble = 1, stone = 1},
            sounds = unilib.sound_table.stone,

            is_ground_content = false,
        }
    )
    unilib.register_craft({
        -- From default:stone
        type = "cooking",
        output = "unilib:stone_ordinary",
        recipe = "unilib:stone_ordinary_cobble_mossy",
    })
    if unilib.mtgame_tweak_flag and unilib.pkg_executed_table["grass_jungle"] ~= nil then

        minetest.register_craft({
            -- From moreblocks
            type = "shapeless",
            output = "unilib:stone_ordinary_cobble_mossy",
            recipe = {"unilib:grass_jungle", "unilib:stone_ordinary_cobble"},
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_ordinary_cobble_mossy", {
        cooked_name = "unilib:stone_ordinary",
    })
    unilib.register_carvings("unilib:stone_ordinary_cobble_mossy", {
        millwork_flag = true,
    })
    unilib.register_wall({
        -- From walls:mossycobble
        orig_name = "walls:mossycobble",
        ingredient = "unilib:stone_ordinary_cobble_mossy",

        replace_mode = walls_add_mode,
        description = S("Mossy Ordinary Cobblestone Wall"),
        sound_name = "stone",
        img_list = {"unilib_stone_ordinary_cobble_mossy.png"},
    })
    ]]--
    unilib.register_stone_cobble_mossy_cuttings({
        part_name = "ordinary",

        replace_mode = default_add_mode,
        wall_orig_name = "walls:mossycobble",
    })
    if unilib.pkg_executed_table["moss_green"] ~= nil then

        unilib.register_cuttable(
            "unilib:stone_ordinary_cobble_mossy",
            "unilib:stone_ordinary_cobble",
            "unilib:moss_green"
        )

        if minetest.registered_nodes["unilib:stone_ordinary_cobble_mossy_wall"] then

            unilib.register_cuttable(
                "unilib:stone_ordinary_cobble_mossy_wall",
                "unilib:stone_ordinary_cobble_wall",
                "unilib:moss_green"
            )

        end

        if minetest.registered_nodes["unilib:stone_ordinary_cobble_mossy_stair_slab"] then

            unilib.register_cuttable(
                "unilib:stone_ordinary_cobble_mossy_stair_slab",
                "unilib:stone_ordinary_cobble_stair_slab",
                "unilib:moss_green"
            )

            unilib.register_cuttable(
                "unilib:stone_ordinary_cobble_mossy_stair_simple",
                "unilib:stone_ordinary_cobble_stair_simple",
                "unilib:moss_green"
            )

            unilib.register_cuttable(
                "unilib:stone_ordinary_cobble_mossy_stair_outer",
                "unilib:stone_ordinary_cobble_stair_outer",
                "unilib:moss_green"
            )

            unilib.register_cuttable(
                "unilib:stone_ordinary_cobble_mossy_stair_inner",
                "unilib:stone_ordinary_cobble_stair_inner",
                "unilib:moss_green"
            )

        end

    end

    if unilib.mtgame_tweak_flag and moreblocks_add_mode ~= "defer" then

        -- N.B. moreblocks code tweaked to match compressed cobbles in underch

        unilib.register_node(
            -- From moreblocks:cobble_compressed
            "unilib:stone_ordinary_cobble_compressed",
            "moreblocks:cobble_compressed",
            moreblocks_add_mode,
            {
                description = S("Compressed Ordinary Cobblestone"),
                tiles = {"unilib_stone_ordinary_cobble_compressed.png"},
--              groups = {compressedstone = 1, cracky = 1},
                groups = {compressedstone = 1, cracky = 3},
                sounds = unilib.sound_table.stone,

                is_ground_content = false,
            }
        )
        unilib.register_craft_3x3({
            -- From moreblocks:cobble_compressed
            output = "unilib:stone_ordinary_cobble_compressed",
            ingredient = "unilib:stone_ordinary_cobble",
        })
        unilib.register_craft({
            -- From moreblocks:cobble_compressed
            output = "unilib:stone_ordinary_cobble 9",
            recipe = {
                {"unilib:stone_ordinary_cobble_compressed"},
            }
        })
        unilib.register_craft({
            -- Original to unilib
            type = "cooking",
            output = "unilib:stone_ordinary 9",
            recipe = "unilib:stone_ordinary_cobble_compressed",
        })
--      unilib.register_stairs("unilib:stone_ordinary_cobble_compressed")

    end

    if unilib.mtgame_tweak_flag then

        -- N.B. condensed cobble does not appear in moreblocks

        unilib.register_stone_cobble_condensed({
            -- Original to unilib. Creates unilib:stone_ordinary_cobble_condensed
            part_name = "ordinary",
            orig_name = nil,

            replace_mode = moreblocks_add_mode,
            description = S("Condensed Ordinary Cobblestone"),
        })

    end

    if unilib.technic_update_flag then

        -- (The technic grinding recipe is provided in ../lib/system/import_pkg.lua)

        unilib.register_craftitem(
            -- From technic:stone_dust
            "unilib:stone_ordinary_powder",
            "technic:stone_dust",
            technic_add_mode,
            {
                description = S("Ordinary Stone Powder"),
                inventory_image = "unilib_stone_ordinary_powder.png",
            }
        )
        unilib.register_craft({
            -- From technic:stone_dust
            type = "cooking",
            output = "unilib:stone_ordinary",
            recipe = "unilib:stone_ordinary_powder",
        })

    end

end
