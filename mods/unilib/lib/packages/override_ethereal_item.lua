---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_ethereal_item = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_ethereal_item.init()

    return {
        description = "Overrides paper from minetest_game with settings from ethereal-ng, giving" ..
                " a craft recipe based on cotton",
        depends = {"crop_cotton", "item_paper_ordinary"},
    }

end

function unilib.pkg.override_ethereal_item.exec()

    local c_cotton = "unilib:crop_cotton_harvest"

    if unilib.setting.mtgame_tweak_flag then

        unilib.register_craft({
            -- From ethereal-ng/extras.lua
            output = "unilib:item_paper_ordinary 2",
            recipe = {
                {c_cotton, c_cotton, c_cotton},
            },
        })

    end

end
