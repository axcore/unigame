---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_dark = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_worldgen.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_granite_dark.init()

    return {
        description = "Dark granite",
    }

end

function unilib.pkg.stone_granite_dark.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "granite_dark",
        description = S("Dark Granite"),

        category = "intrusive",
        colour = "#55413B",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 3/4)
        hardness = 3,
        hardness_real = 3,
        not_super_flag = true,
    })

    unilib.register_node("unilib:stone_granite_dark", "technic:granite", mode, {
        -- From technic:granite
        description = S("Dark Granite"),
        tiles = {"unilib_stone_granite_dark.png"},
        -- N.B. granite = 1, smoothstone = 1, stone = 1 not in original code
        groups = {cracky = 1, granite = 1, smoothstone = 1, stone = 1},
        sounds = unilib.global.sound_table.stone,
    })

    -- (no block/brick/cobble/rubble variants)

    unilib.register_stone_smooth_compressed({
        -- Original to unilib. Creates unilib:stone_granite_dark_compressed
        part_name = "granite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Compressed Dark Granite"),
    })

    unilib.register_stone_smooth_condensed({
        -- Original to unilib. Creates unilib:stone_granite_dark_condensed
        part_name = "granite_dark",
        orig_name = nil,

        replace_mode = mode,
        description = S("Condensed Dark Granite"),
    })

end
