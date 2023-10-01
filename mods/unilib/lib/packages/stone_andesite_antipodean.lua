---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_andesite_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_andesite_antipodean.init()

    return {
        description = "Antipodean andesite",
    }

end

function unilib.pkg.stone_andesite_antipodean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "andesite_antipodean",
        description = S("Antipodean Andesite"),

        category = "extrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("andesite_antipodean", 3, 2)

    unilib.register_node("unilib:stone_andesite_antipodean", "aotearoa:andesite", mode, {
        -- From aotearoa:andesite
        description = S("Antipodean Andesite"),
        tiles = {"unilib_stone_andesite_antipodean.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drops smoothstone in original code
    })
    --[[
    unilib.register_stairs("unilib:stone_andesite_antipodean", {
        basic_flag = true,
        drop_name = "unilib:stone_andesite_antipodeanrubble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "andesite_antipodean",
    })

    unilib.register_node(
        -- From aotearoa:andesite_block
        "unilib:stone_andesite_antipodean_block",
        "aotearoa:andesite_block",
        mode,
        {
            description = S("Antipodean Andesite Block"),
            tiles = {"unilib_stone_andesite_antipodean_block.png"},
            -- N.B. stoneblock = 1 not in original code
            groups = {cracky = block_cracky, stone = 1, stoneblock = 1},
            sounds = unilib.sound_table.stone,
        }
    )
    unilib.register_craft_3x3x9({
        -- From aotearoa:andesite_block
        output = "unilib:stone_andesite_antipodean_block",
        ingredient = "unilib:stone_andesite_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_andesite_antipodean_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "andesite_antipodean",
    })

    unilib.register_node("unilib:stone_andesite_antipodean_brick", "aotearoa:andesitebrick", mode, {
        -- From aotearoa:andesitebrick
        description = S("Antipodean Andesite Bricks"),
        tiles = {"unilib_stone_andesite_antipodean_brick.png"},
        -- N.B. stonebrick = 1 not in original code
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:andesite_antipodeanbrick
        output = "unilib:stone_andesite_antipodean_brick",
        ingredient = "unilib:stone_andesite_antipodean",
    })
    --[[
    unilib.register_stairs("unilib:stone_andesite_antipodean_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "andesite_antipodean",
    })
    unilib.set_auto_rotate("unilib:stone_andesite_antipodean_brick", unilib.auto_rotate_brick_flag)

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates
        --      unilib:stone_andesite_antipodean_cobble, or unilib:stone_andesite_antipodean_rubble,
        --      or nothing
        part_name = "andesite_antipodean",
        cobble_description = S("Antipodean Andesite Cobble"),
        rubble_description = S("Antipodean Andesite Rubble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

    unilib.register_decoration("aotearoa_stone_andesite_antipodean", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:stone_andesite_antipodean",

        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.095,
            seed = 1109,
            spread = {x = 6, y = 6, z = 6},
        },
        sidelen = 16,
    })

end
