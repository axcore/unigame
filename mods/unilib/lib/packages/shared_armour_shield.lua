---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/shields
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_armour_shield = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.shields.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_armour_shield.play_shield_sound(player, sound_name)

    if not unilib.setting.armour_disable_shield_sound_flag and player then

        local pos = player:get_pos()
        if pos then

            core.sound_play(sound_name, {
                pos = pos,
                max_hear_distance = 10,
                gain = 0.5,
            })

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_armour_shield.init()

    return {
        description = "Shared functions for shields (from 3d_armor)",
    }

end
