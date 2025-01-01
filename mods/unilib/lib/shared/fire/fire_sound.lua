---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fire_sound.lua
--      Enable fire sound
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Enable fire sound
---------------------------------------------------------------------------------------------------

-- Adapted from fire/init.lua

local handles = {}
local timer = 0

-- Parameters
local radius = 8 -- Flame node search radius around player
local cycle = 3 -- Cycle time for sound updates

-- Update sound for player
local function update_player_sound(player)

    local player_name = player:get_player_name()
    -- Search for flame nodes in radius around player
    local ppos = player:get_pos()
    local areamin = vector.subtract(ppos, radius)
    local areamax = vector.add(ppos, radius)
    local fpos, num = core.find_nodes_in_area(
        areamin,
        areamax,
        {"unilib:fire_ordinary", "unilib:fire_permanent"}
    )

    -- Total number of flames in radius
    local flames = (num["unilib:fire_ordinary"] or 0) + (num["unilib:fire_permanent"] or 0)

    -- Stop previous sound
    if handles[player_name] then

        core.sound_stop(handles[player_name])
        handles[player_name] = nil

    end

    -- If flames
    if flames > 0 then

        -- Find centre of flame positions
        local fposmid = fpos[1]

        -- If more than 1 flame
        if #fpos > 1 then

            local fposmin = areamax
            local fposmax = areamin
            for i = 1, #fpos do

                local fposi = fpos[i]
                if fposi.x > fposmax.x then
                    fposmax.x = fposi.x
                end
                if fposi.y > fposmax.y then
                    fposmax.y = fposi.y
                end
                if fposi.z > fposmax.z then
                    fposmax.z = fposi.z
                end
                if fposi.x < fposmin.x then
                    fposmin.x = fposi.x
                end
                if fposi.y < fposmin.y then
                    fposmin.y = fposi.y
                end
                if fposi.z < fposmin.z then
                    fposmin.z = fposi.z
                end

            end

            fposmid = vector.divide(vector.add(fposmin, fposmax), 2)

        end

        -- Play sound
        local handle = core.sound_play(
            "unilib_fire",
            {
                gain = math.min(0.06 * (1 + flames * 0.125), 0.18),
                loop = true,     -- In case of lag
                max_hear_distance = 32,
                pos = fposmid,
                to_player = player_name,
            }
        )

        -- Store sound handle for this player
        if handle then
            handles[player_name] = handle
        end
    end
end

-- Cycle for updating players sounds
core.register_globalstep(function(dtime)

    timer = timer + dtime
    if timer < cycle then
        return
    end

    timer = 0
    local players = core.get_connected_players()
    for n = 1, #players do
        update_player_sound(players[n])
    end

end)

-- Stop sound and clear handle on player leave
core.register_on_leaveplayer(function(player)

    local player_name = player:get_player_name()
    if handles[player_name] then

        core.sound_stop(handles[player_name])
        handles[player_name] = nil

    end

end)
