---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    PFAA
-- Code:    Artistic-2.0
-- Media:   Artistic-2.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ore_pfaa_clay_ordinary_with_limonite_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pfaa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ore_pfaa_clay_ordinary_with_limonite_brown.init()

    return {
        description = "Ordinary clay with brown limonite as ore",
        depends = {"clay_ordinary", "clay_ordinary_with_limonite_brown", "shared_pfaa"},
    }

end

function unilib.pkg.ore_pfaa_clay_ordinary_with_limonite_brown.post()

    -- (The shared package provides eight generic ore distributions at overlapping depths)
    unilib.pkg.shared_pfaa.register_clay_ore("limonite_brown", 2)

end
