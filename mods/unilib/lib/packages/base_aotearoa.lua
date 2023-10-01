---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.base_aotearoa = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.base_aotearoa.init()

    -- By running this section in .init(), rather than .exec, we can guarantee that it is the first
    --      package code run (assuming that the "mtgame" remix lists this package first)
    if default_add_mode ~= "defer" then

        unilib.clear_registered_biomes()
        unilib.clear_registered_decorations()
        -- (aotearoa does not clear registered ores)
--      unilib.clear_registered_ores()

    end

    return {
        description = "Base package for the aotearoa remix",
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

function unilib.pkg.base_aotearoa.exec()

    unilib.setup_standard_base_pkg(default_add_mode)

end
