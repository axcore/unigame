---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.base_australia = {}

local S = unilib.intllib
local default_add_mode = unilib.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.base_australia.init()

    -- By running this section in .init(), rather than .exec, we can guarantee that it is the first
    --      package code run (assuming that the "mtgame" remix lists this package first)
    if default_add_mode ~= "defer" then

        unilib.clear_registered_biomes()
        unilib.clear_registered_decorations()
        unilib.clear_registered_ores()

    end

    return {
        description = "Base package for the australia remix",
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

function unilib.pkg.base_australia.exec()

    unilib.setup_standard_base_pkg(default_add_mode)

end
