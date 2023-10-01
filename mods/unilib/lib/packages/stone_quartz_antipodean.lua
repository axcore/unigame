---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_quartz_antipodean = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_quartz_antipodean.init()

    return {
        description = "Antipodean Quartz",
        notes = "Drops gold",
        depends = "metal_gold",
    }

end

function unilib.pkg.stone_quartz_antipodean.exec()

    unilib.register_stone({
        -- Original to unilib
        part_name = "quartz_antipodean",
        description = S("Antipodean Quartz"),

        category = "metamorphic",
        grinder_flag = true,
        -- (N.B. In-game hardness adjusted to match cracky groups below, should be 4)
        hardness = 2,
        hardness_real = 4,
        not_super_flag = true,
    })

    -- (preserve original cracky values for smoothstone and blocks)

    unilib.register_node("unilib:stone_quartz_antipodean", "aotearoa:quartz_with_gold", mode, {
        -- From aotearoa:quartz_with_gold
        description = S("Antipodean Quartz"),
        tiles = {"unilib_stone_quartz_antipodean.png"},
        -- N.B. smoothstone = 1, stone = 1 not in original code
        groups = {cracky = 2, smoothstone = 1, stone = 1},
        sounds = unilib.sound_table.stone,

        drop = "unilib:metal_gold_lump",
    })

    -- (no block/brick/cobble/rubble variants)

end
