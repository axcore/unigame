---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- fire.lua
--      Set up shared functions for fire
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (If no setting present, then enable flame sound)
local flame_sound_flag = minetest.settings:get_bool("flame_sound", true)

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function flood_flame(pos, _, newnode)

    -- Adapted from fire/init.lua
    -- Play flame extinguish sound if liquid is not an 'igniter'

    if minetest.get_item_group(newnode.name, "igniter") == 0 then

        minetest.sound_play(
            "unilib_extinguish_flame",
            {pos = pos, max_hear_distance = 16, gain = 0.15},
            true
        )

    end

    -- Remove the flame
    return false

end

---------------------------------------------------------------------------------------------------
-- Generic fire node definition
---------------------------------------------------------------------------------------------------

function unilib.get_generic_fire()

    -- Adapted from fire/init.lua
    -- Returns a definition table, which the calling code can then customise before calling
    --      unilib.register_node()
    --
    -- Return values:
    --      The definition table described above

    return {
        -- (no description)
        tiles = {{
            name = "unilib_fire_ordinary_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1
            }}
        },
        groups = {dig_immediate = 3, fire = 1, igniter = 2},
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 4,
        drawtype = "firelike",
        drop = "",
        floodable = true,
        inventory_image = "unilib_fire_ordinary.png",
        light_source = 13,
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,

        on_flood = flood_flame
    }

end

---------------------------------------------------------------------------------------------------
-- Fire sound generator
---------------------------------------------------------------------------------------------------

if flame_sound_flag then

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
        local fpos, num = minetest.find_nodes_in_area(
            areamin,
            areamax,
            {"unilib:fire_ordinary", "unilib:fire_permanent"}
        )

        -- Total number of flames in radius
        local flames = (num["unilib:fire_ordinary"] or 0) + (num["unilib:fire_permanent"] or 0)

        -- Stop previous sound
        if handles[player_name] then

            minetest.sound_stop(handles[player_name])
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
            local handle = minetest.sound_play(
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
    minetest.register_globalstep(function(dtime)

        timer = timer + dtime
        if timer < cycle then
            return
        end

        timer = 0
        local players = minetest.get_connected_players()
        for n = 1, #players do
            update_player_sound(players[n])
        end

    end)

    -- Stop sound and clear handle on player leave
    minetest.register_on_leaveplayer(function(player)

        local player_name = player:get_player_name()
        if handles[player_name] then

            minetest.sound_stop(handles[player_name])
            handles[player_name] = nil

        end

    end)

end
