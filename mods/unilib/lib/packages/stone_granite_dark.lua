---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_granite_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.technic_worldgen.add_mode

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
        sounds = unilib.sound_table.stone,
    })

    -- (no block/brick/cobble/rubble variants)

end
