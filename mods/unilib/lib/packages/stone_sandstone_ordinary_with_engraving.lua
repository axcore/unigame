---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    tsm_pyramids
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.stone_sandstone_ordinary_with_engraving = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.tsm_pyramids.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.stone_sandstone_ordinary_with_engraving.init()

    return {
        description = "Ordinary sandstone engravings",
        depends = {"sand_ordinary", "shared_tsm_pyramids_engravings", "stone_sandstone_ordinary"},
    }

end

function unilib.pkg.stone_sandstone_ordinary_with_engraving.exec()

    unilib.pkg.shared_tsm_pyramids_engravings.do_engravings(
        "unilib:stone_sandstone_ordinary",
        "unilib:sand_ordinary"
    )

end
