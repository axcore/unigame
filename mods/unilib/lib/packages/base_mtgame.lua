---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.base_mtgame = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.base_mtgame.init()

    -- By running this section in .init(), rather than .exec, we can guarantee that it is the first
    --      package code run (assuming that the "mtgame" remix lists this package first)
    if default_add_mode ~= "defer" then

        unilib.clear_registered_biomes()
        unilib.clear_registered_decorations()
        unilib.clear_registered_ores()

    end

    return {
        description = "Base package for the mtgame remix",
        -- Another attempt to guarantee being first
        first = true,
        optional = {
            "stone_ordinary",
            "liquid_water_ordinary",
            "liquid_water_river",
            "liquid_lava_ordinary",
        },
    }

end

function unilib.pkg.base_mtgame.post()

    unilib.setup_standard_base_pkg(default_add_mode)
    unilib.activate_standard_abm_lbm()

end
