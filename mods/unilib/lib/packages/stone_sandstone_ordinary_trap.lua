---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_ordinary_trap = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.tsm_pyramids.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_ordinary_trap.init()

    return {
        description = "Ordinary sandstone traps",
        depends = {"sand_ordinary", "shared_tsm_pyramids_traps", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.stone_sandstone_ordinary_trap.exec()

    unilib.pkg.shared_tsm_pyramids_traps.do_traps(
        "unilib:stone_sandstone_ordinary",
        "unilib:sand_ordinary",
        "tsm_pyramids:trap",
        "tsm_pyramids:trap_2"
    )

end
