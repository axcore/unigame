---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_limestone_coquina = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_limestone_coquina.init()

    return {
        description = "Coquina limestone",
        optional = "sand_seashells",
    }

end

function unilib.pkg.stone_limestone_coquina.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "limestone_coquina",
        description = S("Coquina Limestone"),

        category = "sedimentary",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_node("unilib:stone_limestone_coquina", "aotearoa:coquina_limestone", mode, {
        -- From aotearoa:coquina_limestone
        description = S("Coquina Limestone"),
        tiles = {"unilib_stone_limestone_coquina.png"},
        -- N.B. limestone = 1, smoothstone = 1, stone = 1 not in original code
        groups = {
            cracky = 3, crumbly = 1, limestone = 1, smoothstone = 1, stone = 1, soft_stone = 1,
        },
        sounds = unilib.sound_table.stone,

        -- N.B. drops smoothstone in original code
        drop = "unilib:stone_limestone_coquina_rubble",
    })
    if unilib.pkg_executed_table["sand_seashells"] ~= nil then

        unilib.register_craft_2x2({
            -- From aotearoa:coquina_limestone
            output = "unilib:stone_limestone_coquina",
            ingredient = "unilib:sand_seashells",
        })
        unilib.register_craft({
            -- From aotearoa:coquina_limestone
            output = "unilib:sand_seashells 4",
            recipe = {
                {"unilib:stone_limestone_coquina"},
            },
        })

    end
    --[[
    unilib.register_stairs("unilib:stone_limestone_coquina", {
        basic_flag = true,
        drop_name = "unilib:stone_limestone_coquina_rubble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "limestone_coquina",

        drop_name = "unilib:stone_limestone_coquina_rubble",
    })

    unilib.register_node(
        -- From aotearoa:coquina_limestone_block
        "unilib:stone_limestone_coquina_block",
        "aotearoa:coquina_limestone_block",
        mode,
        {
            description = S("Coquina Limestone Block"),
            tiles = {"unilib_stone_limestone_coquina_block.png"},
            -- N.B. stone = 1, stoneblock = 1 not in original code
            groups = {cracky = 2, soft_stone = 1, stone = 1, stoneblock = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_3x3x9({
        -- From aotearoa:coquina_limestone_block
        output = "unilib:stone_limestone_coquina_block",
        ingredient = "unilib:stone_limestone_coquina",
    })
    --[[
    unilib.register_stairs("unilib:stone_limestone_coquina_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "limestone_coquina",
    })

    unilib.register_node(
        -- From aotearoa:coquina_limestonebrick
        "unilib:stone_limestone_coquina_brick",
        "aotearoa:coquina_limestonebrick",
        mode,
        {
            description = S("Coquina Limestone Bricks"),
            tiles = {"unilib_stone_limestone_coquina_brick.png"},
            -- N.B. stone = 1, stonebrick = 1 not in original code
            groups = {cracky = 2, soft_stone = 1, stone = 1, stonebrick = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_2x2x4({
        -- From aotearoa:coquina_limestonebrick
        output = "unilib:stone_limestone_coquina_brick",
        ingredient = "unilib:stone_limestone_coquina",
    })
    --[[
    unilib.register_stairs("unilib:stone_limestone_coquina_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "limestone_coquina",
    })
    unilib.set_auto_rotate("unilib:stone_limestone_coquina_brick", unilib.auto_rotate_brick_flag)

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_limestone_coquina_rubble
        part_name = "limestone_coquina",
        orig_name = nil,

        replace_mode = mode,
        description = S("Coquina Limestone Rubble"),
        img_list = {"unilib_stone_limestone_coquina.png^unilib_stone_rubble_overlay.png"},
    })

end
