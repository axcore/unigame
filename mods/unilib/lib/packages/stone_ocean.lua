---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_ocean = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xocean.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_ocean.init()

    return {
        description = "Ocean stone",
    }

end

function unilib.pkg.stone_ocean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "ocean",
        description = S("Ocean Stone"),

        category = "other",
        colour = "#74A9B4",
        fictional_flag = true,
        grinder_flag = false,
        hardness = 1,
    })

    unilib.register_node("unilib:stone_ocean", "xocean:ocean_stone", mode, {
        -- From xocean:ocean_stone
        description = S("Ocean Stone"),
        tiles = {"unilib_stone_ocean.png"},
        -- N.B. smoothstone = 1, stone = 1 not in original code
        groups = {cracky = 3, smoothstone = 1, stone = 1},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:stone_ocean_cobble",
    })
    unilib.register_craft({
        -- From xocean:ocean_stone
        type = "cooking",
        output = "unilib:stone_ocean",
        recipe = "unilib:stone_ocean_cobble",
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "ocean",

        drop_name = "unilib:stone_ocean_cobble"
    })

    -- (no block variant)

    unilib.register_node("unilib:stone_ocean_brick", "xocean:ocean_brick", mode, {
        -- From xocean:ocean_brick
        description = S("Ocean Stone Bricks"),
        tiles = {"unilib_stone_ocean_brick.png"},
        -- N.B. stone = 1, stonebrick = 1 not in original code
        groups = {cracky = 2, stone = 1, stonebrick = 1},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_craft_2x2x4({
        -- From xocean:ocean_brick
        output = "unilib:stone_ocean_brick",
        ingredient = "unilib:stone_ocean_cobble",
    })
    unilib.register_stone_brick_cuttings({
        part_name = "ocean",
    })
    unilib.utils.set_auto_rotate("unilib:stone_ocean_brick", unilib.setting.auto_rotate_brick_flag)

    unilib.register_node("unilib:stone_ocean_cobble", "xocean:ocean_cobble", mode, {
        -- From xocean:ocean_cobble
        description = S("Ocean Cobblestone"),
        tiles = {"unilib_stone_ocean_cobble.png"},
        -- N.B. cobble = 1, stone = 2 not in original code
        groups = {cobble = 1, cracky = 3, stone = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_stone_cobble_cuttings({
        part_name = "ocean",

        replace_mode = mode,
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_ocean_cobble_compressed
        part_name = "ocean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Ocean Cobblestone"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_ocean_cobble_condensed
        part_name = "ocean",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Ocean Cobblestone"),
    })

end
