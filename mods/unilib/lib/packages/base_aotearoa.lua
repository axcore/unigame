---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.base_aotearoa = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.base_aotearoa.init()

    -- By running this section in .init(), rather than .exec, we can guarantee that it is the first
    --      package code run (assuming that the "mtgame" remix lists this package first)
    if default_add_mode ~= "defer" or not core.get_modpath("default") then

        unilib.misc.clear_registered_biomes()
        unilib.misc.clear_registered_decorations()
        -- (aotearoa does not clear registered ores)
--      unilib.misc.clear_registered_ores()

    end

    return {
        description = "Base package for the aotearoa remix",
        -- Another attempt to guarantee being first
        first = true,
    }

end
