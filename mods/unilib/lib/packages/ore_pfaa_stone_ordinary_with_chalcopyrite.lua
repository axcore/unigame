---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_pfaa_stone_ordinary_with_chalcopyrite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_pfaa_stone_ordinary_with_chalcopyrite.init()

    return {
        description = "Ordinary stone with chalcopyrite as ore",
        depends = {"shared_pfaa", "stone_ordinary", "stone_ordinary_with_chalcopyrite"},
    }

end

function unilib.pkg.ore_pfaa_stone_ordinary_with_chalcopyrite.post()

    -- (The shared package provides eight generic ore distributions at overlapping depths)
    unilib.pkg.shared_pfaa.register_stone_ore("chalcopyrite", 4)

end
