---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_serpentine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_serpentine.init()

    return {
        description = "Serpentine",
    }

end

function unilib.pkg.stone_serpentine.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "serpentine",
        description = S("Serpentine"),

        category = "metamorphic",
        colour = "#CEE0B7",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 2)
        hardness = 1,
        hardness_real = 2,
    })

    local smooth_cracky, block_cracky = unilib.stone.get_adjusted_cracky("serpentine", 3, nil)

    unilib.register_node("unilib:stone_serpentine", "darkage:serpentine", mode, {
        -- From darkage:serpentine
        description = S("Serpentine"),
        tiles = {"unilib_stone_serpentine.png"},
        -- N.B. stone = 1 not in original code
        groups = {cracky = smooth_cracky, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })
    --[[
    unilib.register_stairs("unilib:stone_serpentine", {
        drop_name = "unilib:stone_serpentine_rubble",
        group_type = "smooth",
    })
    unilib.register_carvings("unilib:stone_serpentine", {
        facade_flag = true,
    })
    ]]--
    unilib.register_stone_smooth_cuttings({
        part_name = "serpentine",
    })

    unilib.register_stone_block({
        -- Original to unilib. Creates unilib:stone_serpentine_block
        part_name = "serpentine",
        orig_name = nil,

        replace_mode = mode,
        description = S("Serpentine Block"),
        img_list = {"unilib_stone_serpentine.png^unilib_stone_block_overlay.png"},
    })

    unilib.register_stone_brick({
        -- Original to unilib. Creates unilib:stone_serpentine_brick
        part_name = "serpentine",
        orig_name = nil,

        replace_mode = mode,
        description = S("Serpentine Bricks"),
        img_list = {"unilib_stone_serpentine.png^unilib_stone_brick_overlay.png"},
    })

    unilib.register_stone_cobble_or_rubble_or_nothing({
        -- Original to unilib. Depending on real hardness, creates unilib:stone_serpentine_cobble,
        --      or unilib:stone_serpentine_rubble, or nothing
        part_name = "serpentine",
        cobble_description = S("Serpentine Cobble"),
        cobble_compressed_description = S("Compressed Serpentine Cobble"),
        cobble_condensed_description = S("Condensed Serpentine Cobble"),
        rubble_description = S("Serpentine Rubble"),
        rubble_compressed_description = S("Compressed Serpentine Rubble"),
        rubble_condensed_description = S("Condensed Serpentine Rubble"),
        smooth_compressed_description = S("Compressed Serpentine"),
        smooth_condensed_description = S("Condensed Serpentine"),

        replace_mode = mode,
        override_drop_flag = true,
    })

end
