---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_pounamu = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_pounamu.init()

    return {
        description = "Pounamu",
        optional = {
            "metal_copper",
            "metal_gold",
            "metal_steel",
            "metal_tin",
            "mineral_mese",
            "stone_andesite_antipodean",
            "stone_gneiss_antipodean",
            "stone_granite_antipodean",
            "stone_limestone_antipodean",
        },
    }

end

function unilib.pkg.stone_pounamu.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "pounamu",
        description = S("Pounamu"),

        category = "metamorphic",
        colour = "#5B804F",
        grinder_flag = true,
        hardness = 4,
    })

    unilib.register_node("unilib:stone_pounamu", "aotearoa:pounamu", mode, {
        -- From aotearoa:pounamu
        description = S("Pounamu"),
        tiles = {"unilib_stone_pounamu.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = 1, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:stone_pounamu",
    })
    --[[
    unilib.register_stairs("unilib:stone_pounamu", {
        basic_flag = true,
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "pounamu",

        drop_name = "unilib:stone_pounamu",
    })

    unilib.register_node("unilib:stone_pounamu_block", "aotearoa:pounamu_block", mode, {
        -- From aotearoa:pounamu_block
        description = S("Pounamu Block"),
        tiles = {"unilib_stone_pounamu_block.png"},
        -- N.B. stoneblock = 1 not in original code
        groups = {cracky = 1, stone = 1, stoneblock = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:pounamu_block
        output = "unilib:stone_pounamu_block",
        ingredient = "unilib:stone_pounamu",
    })
    --[[
    unilib.register_stairs("unilib:stone_pounamu_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "pounamu",
    })

    unilib.register_node("unilib:stone_pounamu_brick", "aotearoa:pounamubrick", mode, {
        -- From aotearoa:pounamubrick
        description = S("Pounamu Bricks"),
        tiles = {"unilib_stone_pounamu_brick.png"},
        -- N.B. stonebrick = 1 not in original code
        groups = {cracky = 1, stone = 1, stonebrick = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:pounamubrick
        output = "unilib:stone_pounamu_brick",
        ingredient = "unilib:stone_pounamu",
    })
    --[[
    unilib.register_stairs("unilib:stone_pounamu_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "pounamu",
    })
    unilib.utils.set_auto_rotate(
        "unilib:stone_pounamu_brick", unilib.setting.auto_rotate_brick_flag
    )

    -- Artificial mese using a "hocus-pocus" recipe
    -- (N.B. Don't bother checking for the optional packages; let Minetest deal with it)
    unilib.register_craft({
        output = "unilib:mineral_mese_block",
        recipe = {
            {
                "unilib:stone_granite_antipodean",
                "unilib:metal_gold_ingot",
                "unilib:stone_gneiss_antipodean",
            },
            {
                "unilib:metal_copper_ingot",
                "unilib:stone_pounamu",
                "unilib:metal_steel_ingot",
            },
            {
                "unilib:stone_andesite_antipodean",
                "unilib:metal_tin_ingot",
                "unilib:stone_limestone_antipodean",
            },
        },
    })

    unilib.register_stone_smooth_compressed({
        -- Original to unilib. Creates unilib:stone_pounamu_compressed
        part_name = "pounamu",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Pounamu"),
    })

    unilib.register_stone_smooth_condensed({
        -- Original to unilib. Creates unilib:stone_pounamu_condensed
        part_name = "pounamu",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Pounamu"),
    })

end
