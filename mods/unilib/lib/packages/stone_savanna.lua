---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_savanna = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_savanna.init()

    return {
        description = "Savanna stone",
    }

end

function unilib.pkg.stone_savanna.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "savanna",
        description = S("Savanna"),

        category = "sedimentary",
        colour = "#8E7B5C",
        fictional_flag = true,
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_node("unilib:stone_savanna", "mapgen:savanna_stone", mode, {
        -- From farlands, mapgen:savanna_stone
        description = S("Savanna Stone"),
        tiles = {"unilib_stone_savanna.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = 3, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        drop = "unilib:stone_savanna_cobble",
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "savanna",

        drop_name = "unilib:stone_savanna_cobble",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_savanna_block
        part_name = "savanna",
        orig_name = nil,

        replace_mode = mode,
        description = S("Savanna Stone Block"),
        img_list = {"unilib_stone_savanna.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_savanna_brick
        part_name = "savanna",
        orig_name = nil,

        replace_mode = mode,
        description = S("Savanna Stone Bricks"),
        img_list = {"unilib_stone_savanna.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_node("unilib:stone_savanna_cobble", "mapgen:savanna_cobblestone_stone", mode, {
        -- From farlands, mapgen:savanna_cobblestone_stone
        description = S("Savanna Cobblestone"),
        tiles = {"unilib_stone_savanna_cobble.png"},
        -- N.B. cobble = 1 not in original code
        groups = {cobble = 1, cracky = 3, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. is_ground_content = false not in original code; added to match other stones
        is_ground_content = false,
    })
    unilib.register_stone_cobble_cuttings({
        part_name = "savanna",

        replace_mode = mode,
    })

    unilib.register_stone_cobble_compressed({
        -- Original to unilib. Creates unilib:stone_savanna_cobble_compressed
        part_name = "savanna",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Savanna Stone Cobblestone"),
    })

    unilib.register_stone_cobble_condensed({
        -- Original to unilib. Creates unilib:stone_savanna_cobble_condensed
        part_name = "savanna",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Savanna Stone Cobblestone"),
    })

end
