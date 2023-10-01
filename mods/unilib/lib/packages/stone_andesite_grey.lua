---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_andesite_grey = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.glemr4.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_andesite_grey.init()

    return {
        description = "Grey andesite",
    }

end

function unilib.pkg.stone_andesite_grey.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "andesite_grey",
        description = S("Grey Andesite"),

        category = "extrusive",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match original mod's code, should be 3)
        hardness = 1,
        hardness_real = 3,
    })

    local smooth_cracky, block_cracky = unilib.get_adjusted_cracky("andesite_grey", 3, nil)

    unilib.register_node("unilib:stone_andesite_grey", "lib_materials:stone_andesite", mode, {
        -- From GLEMr4, lib_materials:stone_andesite
        description = S("Grey Andesite"),
        tiles = {"unilib_stone_andesite_grey.png"},
        -- N.B. smoothstone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,
    })
    unilib.register_stone_smooth_cuttings({
        part_name = "andesite_grey",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_andesite_grey_block
        part_name = "andesite_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Andesite Block"),
        img_list = {"unilib_stone_andesite_grey.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_andesite_grey_brick
        part_name = "andesite_grey",
        orig_name = nil,

        replace_mode = mode,
        description = S("Grey Andesite Bricks"),
        img_list = {"unilib_stone_andesite_grey.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates
        --      unilib:stone_andesite_grey_cobble, or unilib:stone_andesite_grey_rubble, or nothing
        part_name = "andesite_grey",
        cobble_description = S("Grey Andesite Cobble"),
        rubble_description = S("Grey Andesite Rubble"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
