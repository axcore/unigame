---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_scoria = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_scoria.init()

    return {
        description = "Scoria",
    }

end

function unilib.pkg.stone_scoria.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "scoria",
        description = S("Scoria"),

        category = "extrusive",
        grinder_flag = false,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 2/3)
        hardness = 1,
        hardness_real = 2,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("scoria", 3, 2)

    unilib.register_node("unilib:stone_scoria", "aotearoa:scoria", mode, {
        -- From aotearoa:scoria
        description = S("Scoria"),
        tiles = {"unilib_stone_scoria.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        -- N.B. drops smoothstone in original code
    })
    --[[
    unilib.register_stairs("unilib:stone_scoria", {
        basic_flag = true,
        drop_name = "unilib:stone_scoria_rubble",
        group_type = "smooth",
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "scoria",
    })

    unilib.register_node("unilib:stone_scoria_block", "aotearoa:scoria_block", mode, {
        -- From aotearoa:scoria_block
        description = S("Scoria Block"),
        tiles = {"unilib_stone_scoria_block.png"},
        -- N.B. stoneblock = 1 not in original code
        groups = {cracky = block_cracky, stone = 1, stoneblock = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_3x3x9({
        -- From aotearoa:scoria_block
        output = "unilib:stone_scoria_block",
        ingredient = "unilib:stone_scoria",
    })
    --[[
    unilib.register_stairs("unilib:stone_scoria_block", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_block_cuttings({
        part_name = "scoria",
    })

    unilib.register_node("unilib:stone_scoria_brick", "aotearoa:scoriabrick", mode, {
        -- From aotearoa:scoriabrick
        description = S("Scoria Bricks"),
        tiles = {"unilib_stone_scoria_brick.png"},
        -- N.B. stonebrick = 1 not in original code
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_craft_2x2x4({
        -- From aotearoa:scoriabrick
        output = "unilib:stone_scoria_brick",
        ingredient = "unilib:stone_scoria",
    })
    --[[
    unilib.register_stairs("unilib:stone_scoria_brick", {
        basic_flag = true,
    })
    ]]--
    unilib.register_stone_brick_cuttings({
        part_name = "scoria",
    })
    unilib.set_auto_rotate("unilib:stone_scoria_brick", unilib.auto_rotate_brick_flag)

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_scoria_cobble, or
        --      unilib:stone_scoria_rubble, or nothing
        part_name = "scoria",
        cobble_description = S("Scoria Cobble"),
        rubble_description = S("Scoria Rubble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

    unilib.register_decoration("aotearoa_stone_scoria", {
        -- From aotearoa/spawn_plants.lua
        deco_type = "simple",
        decoration = "unilib:stone_scoria",

        noise_params = {
            octaves = 2,
            offset = 0,
            persist = 0.7,
            scale = 0.095,
            seed = 2009,
            spread = {x = 6, y = 6, z = 6},
        },
        sidelen = 16,
    })

end
