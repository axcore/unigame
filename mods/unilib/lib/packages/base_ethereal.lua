---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.base_ethereal = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.base_ethereal.init()

    -- By running this section in .init(), rather than .exec, we can guarantee that it is the first
    --      package code run (assuming that the "ethereal" remix lists this package first)
    if default_add_mode ~= "defer" or not core.get_modpath("default") then

        unilib.misc.clear_registered_biomes()
        unilib.misc.clear_registered_decorations()
        -- (ethereal does not clear registered ores)
--      unilib.misc.clear_registered_ores()

    end

    return {
        description = "Base package for the ethereal remix",
        -- Another attempt to guarantee being first
        first = true,
    }

end
