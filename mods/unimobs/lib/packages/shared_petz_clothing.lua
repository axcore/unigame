---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_petz_clothing = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- Shared function
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_clothing.destroy_callback(player)

    -- Was petz.armor_destroy()

    local pos = player:get_pos()
    if pos then

        core.sound_play({
            name = "unilib_clothing_destroy",
            gain = 0.5,
            pos = pos,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_clothing.init()

    return {
        description = "Shared functions for clothing (from petz)",
    }

end
