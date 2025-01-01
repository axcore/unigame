---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_pfaa_stone_ordinary_with_spodumene = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_pfaa_stone_ordinary_with_spodumene.init()

    return {
        description = "Ordinary stone with spodumene as ore",
        depends = {"shared_pfaa", "stone_ordinary", "stone_ordinary_with_spodumene"},
    }

end

function unilib.pkg.ore_pfaa_stone_ordinary_with_spodumene.post()

    -- (The shared package provides eight generic ore distributions at overlapping depths)
    unilib.pkg.shared_pfaa.register_stone_ore("spodumene", 8)

end
