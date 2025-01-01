---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_desert_trap = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.tsm_pyramids.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_desert_trap.init()

    return {
        description = "Desert sandstone traps",
        depends = {"sand_desert", "shared_tsm_pyramids_traps", "stone_sandstone_desert"},
    }

end

function unilib.pkg.stone_sandstone_desert_trap.exec()

    unilib.pkg.shared_tsm_pyramids_traps.do_traps(
        "unilib:stone_sandstone_desert",
        "unilib:sand_desert",
        "tsm_pyramids:desert_trap",
        "tsm_pyramids:desert_trap_2"
    )

end
