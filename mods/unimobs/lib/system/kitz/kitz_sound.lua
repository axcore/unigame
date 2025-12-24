---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- kitz_sound.lua
--      Shared API functions from the petz/kitz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local random = math.random

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/kitz/api/api_sound.lua)
---------------------------------------------------------------------------------------------------

function unimobs.kitz_api.make_sound(dest_type, dest, sound_file, max_hear_distance)

    -- Was kitz.make_sound()
    -- Causes the item "dest" to play the specified "sound_file"
    -- "dest_type" can be "object", "player" or "pos"
    --
    -- ATTENTION: When composing the "sound_file" argument using a particular petz-compatible
    --      creature, use its .generic_type field, not its .mob_type field

    if dest_type == "object" then

        core.sound_play(
            sound_file,
            {
                object = dest,
                gain = 0.5,
                max_hear_distance =
                        max_hear_distance or unimobs.kitz_const.default_max_hear_distance,
            }
        )

     elseif dest_type == "player" then

        local pname = dest:get_player_name()
        core.sound_play(
            sound_file,
            {
                to_player = pname,
                gain = 0.5,
                max_hear_distance =
                        max_hear_distance or unimobs.kitz_const.default_max_hear_distance,
            }
        )

     elseif dest_type == "pos" then

        core.sound_play(
            sound_file,
            {
                pos = dest,
                gain = 0.5,
                max_hear_distance =
                        max_hear_distance or unimobs.kitz_const.default_max_hear_distance,
            }
        )

    end

end

function unimobs.kitz_api.make_misc_sound(self, chance, max_hear_distance)

    -- Was kitz.make_misc_sound()
    -- Plays one of the sound files, selected at random, from the "misc" sound definition
    --
    -- This function does not check all of the formats supported by the original mobkit API, but
    --      only mobs whose .sounds are in the following formats, widely used in the original petz
    --      code:
    --
    --      sounds = {
    --          misc = "unilib_mob_cat_normal_miaow_1",
    --      },
    --
    --      sounds = {
    --          misc = {"unilib_mob_cat_normal_miaow_1", "unilib_mob_cat_normal_miaow_2", ... },
    --      },

    if self.is_muted_flag == true or self.status == "sleep" then
        return
    end

    local random_number = random(1, chance)
    if random_number == 1 then

        if self.sounds and self.sounds["misc"] then

            local misc_sound
            if type(self.sounds["misc"]) == "table" then
                misc_sound = self.sounds["misc"][random(1, #self.sounds["misc"])]
            else
                misc_sound = self.sounds["misc"]
            end

            unimobs.kitz_api.make_sound(
                "object",
                self.object,
                misc_sound,
                max_hear_distance or unimobs.kitz_const.default_max_hear_distance
            )

        end

    end

end
