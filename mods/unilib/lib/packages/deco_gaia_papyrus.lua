---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_gaia_papyrus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_gaia_papyrus.init()

    return {
        description = "Papyrus for the \"gaia\" remix",
        depends = {"abm_standard_papyrus_grow", "biome_gaia", "plant_papyrus_ordinary"},
    }

end

function unilib.pkg.deco_gaia_papyrus.post()

    -- Allow papyrus to grow on common "gaia" remix dirts/sands
    for _, item_name in pairs({
        "dirt_black",
        "dirt_brown",
        "dirt_clayey",
        "dirt_coarse",
        "dirt_dark",
        "dirt_ordinary",
        "dirt_sandy",
        "dirt_silt_coarse",
        "dirt_silt_fine",
    }) do
        unilib.pkg.abm_standard_papyrus_grow.register_papyrus_dirt("unilib:" .. item_name, true)
    end

    for _, item_name in pairs({
        "sand_desert",
        "sand_ordinary",
        "sand_silver",
    }) do
        unilib.pkg.abm_standard_papyrus_grow.register_papyrus_dirt("unilib:" .. item_name, false)
    end

end
