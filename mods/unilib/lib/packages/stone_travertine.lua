---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    decoblocks
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_travertine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.decoblocks.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_travertine.init()

    return {
        description = "Travertine",
    }

end

function unilib.pkg.stone_travertine.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "travertine",
        description = S("Travertine"),

        category = "sedimentary",
        colour = "#D5C1A4",
        grinder_flag = true,
        hardness = 1,
    })

    unilib.register_node("unilib:stone_travertine", "default:travertine", mode, {
        -- From decoblocks, default:travertine
        description = S("Travertine"),
        tiles = {"unilib_stone_travertine.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = 3, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,

        -- N.B. drop not in original code
        drop = "unilib:stone_travertine_rubble",
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "travertine",

        drop_name = "unilib:stone_travertine_rubble",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_travertine_block
        part_name = "travertine",
        orig_name = nil,

        replace_mode = mode,
        description = S("Travertine Block"),
        img_list = {"unilib_stone_travertine.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_travertine_brick
        part_name = "travertine",
        orig_name = nil,

        replace_mode = mode,
        description = S("Travertine Bricks"),
        img_list = {"unilib_stone_travertine.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_rubble({
        -- Original to unilib. Creates unilib:stone_travertine_rubble
        part_name = "travertine",
        orig_name = nil,

        replace_mode = mode,
        description = S("Travertine Rubble"),
        img_list = {"unilib_stone_travertine.png^unilib_stone_rubble_overlay.png"},
    })

    unilib.register_stone_rubble_compressed({
        -- Original to unilib. Creates unilib:stone_travertine_rubble_compressed
        part_name = "travertine",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Travertine Rubble"),
    })

    unilib.register_stone_rubble_condensed({
        -- Original to unilib. Creates unilib:stone_travertine_rubble_condensed
        part_name = "travertine",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Travertine Rubble"),
    })

end
