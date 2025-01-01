---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.base_gaia = {}

local S = unilib.intllib
local default_add_mode = unilib.global.imported_mod_table.default.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.base_gaia.init()

    -- By running this section in .init(), rather than .exec, we can guarantee that it is the first
    --      package code run (assuming that the "mtgame" remix lists this package first)
    if default_add_mode ~= "defer" or not core.get_modpath("default") then

        unilib.misc.clear_registered_biomes()
        unilib.misc.clear_registered_decorations()
        unilib.misc.clear_registered_ores()

    end

    return {
        description = "Base package for the \"gaia\" remix",
        -- Another attempt to guarantee being first
        first = true,
    }

end

function unilib.pkg.base_gaia.post()

    if unilib.global.pkg_executed_table["meta_deco_optimise"] ~= nil then

        if unilib.global.remix_dir_table["gaia_simple"] ~= nil then
            unilib.pkg.meta_deco_optimise.do_optimise("gaia_simple")
        else
            unilib.pkg.meta_deco_optimise.do_optimise("gaia")
        end

    end

end
