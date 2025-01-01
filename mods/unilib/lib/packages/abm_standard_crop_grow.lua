---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.abm_standard_crop_grow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.abm_standard_crop_grow.init()

    return {
        description = "ABM to handle crop growth (from farming_redo)",
    }

end

function unilib.pkg.abm_standard_crop_grow.post()

    -- Adapted from farming_redo/init.lua
    -- Handles any growth stages that have been omitted, or any crops from other mods that have been
    --      added to the map, that have since been converted to farming_redo crops

    unilib.register_abm({
        label = "Crop growth [abm_standard_crop_grow]",
        nodenames = {"group:growing"},

        catch_up = false,
        chance = 1,
        interval = 300,

        action = function(pos, node)
            unilib.farming.on_timer_prepare_growth(pos, node)
        end,
    })

end
