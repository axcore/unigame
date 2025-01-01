---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hangglider
-- Code:    LGPL 3.0+
-- Media:   CC-BY-SA 3.0 UNPORTED/CC-BY-SA 3.0/CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_hangglider = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.hangglider.add_mode

local no_fly_zone_flag = false

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_hangglider.can_fly(pname, pos)

    -- Checks if the player will get shot down at the position

    if areas and core.is_protected(vector.round(pos), pname) and no_fly_zone_flag then

        for id, area in pairs(areas:getAreasAtPos(pos)) do

            if area.no_fly then
                return false
            end

        end

    end

    return true

end

function unilib.pkg.shared_hangglider.play_shooting_sound(pos)

    core.sound_play("unilib_item_hangglider_warning", {
        pos = pos,
        max_hear_distance = 30,
        gain = 10.0,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_hangglider.init()

    return {
        description = "Shared functions for flying devices (from hanggliders)",
        notes = "This package provides functions for any flying device, to prevent players from" ..
                " using it to fly in protected areas (see the \"potion_flight\" package for a" ..
                " working example). Use the /no_fly_zone command to enable/disable flight in" ..
                " your areas",
    }

end

function unilib.pkg.shared_hangglider.exec()

    if core.global_exists("areas") then

        no_fly_zone_flag = true

        -- chat command definition adapted from "areas" mod
        core.register_chatcommand("no_fly_zone",{
            params = "<ID>",
            description = "Toggle airspace restrictions for area <ID>",

            func = function(name, param)

                local id = tonumber(param)
                if not id then
                    return false, "Invalid usage, see /help no_fly_zone."
                end

                if not areas:isAreaOwner(id, name) then
                    return false, "Area " .. id .. " does not exist or is not owned by you."
                end

                local open = not areas.areas[id].no_fly

                -- Save false as nil to avoid inflating the DB
                areas.areas[id].no_fly = open or nil
                areas:save()
                if open then
                    return true, ("No-fly-zone enabled in the area.")
                else
                    return true, ("No-fly-zone disabled in the area.")
                end

            end,
        })

    end

end
