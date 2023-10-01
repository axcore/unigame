---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_pfaa_clay_ordinary_with_bauxite = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_pfaa_clay_ordinary_with_bauxite.init()

    return {
        description = "Ordinary clay with bauxite as ore",
        depends = {"clay_ordinary", "clay_ordinary_with_bauxite", "shared_pfaa"},
    }

end

function unilib.pkg.ore_pfaa_clay_ordinary_with_bauxite.post()

    -- (The shared package provides eight generic ore distributions at overlapping depths)
    unilib.pkg.shared_pfaa.register_clay_ore("bauxite", 1)

end
