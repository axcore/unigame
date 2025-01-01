---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_flora_spread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.flowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_flora_spread.init()

    return {
        description = "ABM to handle spread of flora (from minetest_game/flowers)",
        depends = "shared_standard",
    }

end

function unilib.pkg.abm_standard_flora_spread.post()

    -- Adapted from flowers/init.lua
    -- Handle spread of flowers, mushrooms, and some grasses

    unilib.register_abm({
        label = "Flora spread (for flowers, mushrooms, grasses etc) [abm_standard_flora_spread]",
        nodenames = {"group:flora"},

        chance = 300,
        interval = 13 / unilib.setting.abm_spread_factor,

        action = function(...)
            unilib.pkg.shared_standard.flora_spread(...)
        end,
    })

    -- Nullify the original minetest_game ABM, if present. This prevents marram grass from turning
    --      into dry shrubs on unilib:sand_ordinary beaches)
    --[[
    unilib.register_obsolete_abm({
        mod_origin = "flowers",
        label = "Flower spread",
    })
    ]]--
    if core.get_modpath("flowers") and flowers.flower_spread ~= nil then
        function flowers.flower_spread() end
    end

end
