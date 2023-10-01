---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_conglomerate_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_conglomerate_normal.init()

    return {
        description = "Normal conglomerate",
        optional = "gravel_ordinary",
    }

end

function unilib.pkg.stone_conglomerate_normal.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "conglomerate_normal",
        description = S("Normal Conglomerate"),

        category = "sedimentary",
        grinder_flag = false,
        hardness = 1,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_conglomerate_normal", "aotearoa:conglomerate", mode, {
        -- From aotearoa:conglomerate
        description = S("Normal Conglomerate"),
        tiles = {"unilib_stone_conglomerate_normal.png"},
        -- N.B. smoothstone = 1, stone = 1 not in original code
        groups = {cracky = 3, crumbly = 1, smoothstone = 1, soft_stone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:stone_conglomerate_normal",
    })
    if unilib.pkg_executed_table["gravel_ordinary"] ~= nil then

        unilib.register_craft_2x2({
            -- From aotearoa:conglomerate
            output = "unilib:stone_conglomerate_normal",
            ingredient = "unilib:gravel_ordinary",
        })
        unilib.register_craft({
            -- From aotearoa:conglomerate
            output = "unilib:gravel_ordinary 4",
            recipe = {
                {"unilib:stone_conglomerate_normal"},
            },
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_conglomerate_normal", {
        basic_flag = true,
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "conglomerate_normal",

        drop_name = "unilib:stone_conglomerate_normal",
    })

    unilib.register_node(
        -- From aotearoa:conglomerate_block
        "unilib:stone_conglomerate_normal_block",
        "aotearoa:conglomerate_block",
        mode,
        {
            description = S("Normal Conglomerate Block"),
            tiles = {"unilib_stone_conglomerate_normal_block.png"},
            -- N.B. stone = 1, stoneblock = 1 not in original code
            groups = {cracky = 2, soft_stone = 1, stone = 1, stoneblock = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_3x3x9({
        -- From aotearoa:conglomerate_block
        output = "unilib:stone_conglomerate_normal_block",
        ingredient = "unilib:stone_conglomerate_normal",
    })
    --[[
    unilib.register_stairs("unilib:stone_conglomerate_normal_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "conglomerate_normal",
    })

    unilib.register_node(
        -- From aotearoa:conglomeratebrick
        "unilib:stone_conglomerate_normal_brick",
        "aotearoa:conglomeratebrick",
        mode,
        {
            description = S("Normal Conglomerate Bricks"),
            tiles = {"unilib_stone_conglomerate_normal_brick.png"},
            -- N.B. stone = 1, stonebrick = 1 not in original code
            groups = {cracky = 2, soft_stone = 1, stone = 1, stonebrick = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_2x2x4({
        -- From aotearoa:conglomeratebrick
        output = "unilib:stone_conglomerate_normal_brick",
        ingredient = "unilib:stone_conglomerate_normal",
    })
    --[[
    unilib.register_stairs("unilib:stone_conglomerate_normal_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "conglomerate_normal",
    })
    unilib.set_auto_rotate("unilib:stone_conglomerate_normal_brick", unilib.auto_rotate_brick_flag)

    -- (no cobble/rubble variants)

end
