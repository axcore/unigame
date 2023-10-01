---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_ethereal_ice = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_ethereal_ice.init()

    return {
        description = "Overrides ice from minetest_game with settings from ethereal-ng, giving" ..
                " ice a new texture",
        depends = "ice_ordinary",
    }

end

function unilib.pkg.override_ethereal_ice.exec()

    if unilib.mtgame_tweak_flag then

        -- (Use the ethereal-ng texture for ordinary ice, which matches the texture used by the
        --      ethereal-ng ice brick node)
        unilib.override_item("unilib:ice_ordinary", {
            tiles = {"unilib_ice_ordinary_ethereal.png"},
        })

    end

end
