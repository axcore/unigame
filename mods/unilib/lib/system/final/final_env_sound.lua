---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- final_env_sound.lua
--      Set up environmental sounds
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Node search radius around player
local radius = 8
-- Table of environmental sounds, depending on which packages have been loaded
local sound_table = {}
-- Cache the union of all trigger nodes
local cache_table = {}
-- Minetest v5.4.1 crashes on game start if cache_table (at the core.find_nodes_in_area() call
--      below), so we need to check for that
local cache_empty_flag = true

---------------------------------------------------------------------------------------------------
-- Prepare list of sounds
---------------------------------------------------------------------------------------------------

if unilib.global.pkg_executed_table["liquid_lava_ordinary"] ~= nil then

    sound_table["unilib_env_lava"] = {
        trigger = {"unilib:liquid_lava_ordinary_source", "unilib:liquid_lava_ordinary_flowing"},
        base_volume = 0,
        max_volume = 0.6,
        per_node = {
            ["unilib:liquid_lava_ordinary_source"] = 0.008,
            ["unilib:liquid_lava_ordinary_flowing"] = 0.002,
        },
    }

end

if unilib.global.pkg_executed_table["liquid_water_ordinary"] ~= nil then

    sound_table["unilib_env_water"] = {
        trigger = {"unilib:liquid_water_ordinary_flowing"},
        base_volume = 0.04,
        max_volume = 0.4,
        per_node = 0.004,
    }

end

if unilib.global.pkg_executed_table["liquid_water_river"] ~= nil then
    table.insert(sound_table["unilib_env_water"].trigger, "unilib:liquid_water_river_flowing")
end

if core.settings:get_bool("river_source_sounds") then
    table.insert(sound_table["unilib_env_water"].trigger, "unilib:liquid_water_river_source")
end

-- Cache the union of all trigger nodes
for sound_name, def_table in pairs(sound_table) do

    for _, full_name in ipairs(def_table.trigger) do

        table.insert(cache_table, full_name)
        cache_empty_flag = false

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function update_sound(player)

    -- Adapted from env_sounds/init.lua
    -- Update sound for player

    local player_name = player:get_player_name()
    local ppos = player:get_pos()
    ppos = vector.add(ppos, player:get_properties().eye_height)
    local areamin = vector.subtract(ppos, radius)
    local areamax = vector.add(ppos, radius)

    local pos = core.find_nodes_in_area(areamin, areamax, cache_table, true)
    if next(pos) == nil then -- If table empty
        return
    end

    for sound, def in pairs(sound_table) do

        -- Find average position
        local posav = {0, 0, 0}
        local count = 0
        for _, name in ipairs(def.trigger) do

            if pos[name] then

                for _, p in ipairs(pos[name]) do

                    posav[1] = posav[1] + p.x
                    posav[2] = posav[2] + p.y
                    posav[3] = posav[3] + p.z

                end

                count = count + #pos[name]

            end

        end

        if count > 0 then

            posav = vector.new(posav[1] / count, posav[2] / count, posav[3] / count)

            -- Calculate gain
            local gain = def.base_volume
            if type(def.per_node) == 'table' then

                for name, multiplier in pairs(def.per_node) do

                    if pos[name] then
                        gain = gain + #pos[name] * multiplier
                    end

                end

            else

                gain = gain + count * def.per_node

            end

            gain = math.min(gain, def.max_volume)

            core.sound_play(
                sound,
                {
                    pos = posav,
                    to_player = player_name,
                    gain = gain,
                },
                true
            )

        end

    end

end

local function cyclic_update()

    -- Adapted from env_sounds/init.lua
    -- Cyclic sound update

    for _, player in pairs(core.get_connected_players()) do
        update_sound(player)
    end

    core.after(3.5, cyclic_update)

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- To avoid the crash mentioned above, do nothing if no environmental sounds are specified
if not cache_empty_flag then

    -- Update sound when player joins
    core.register_on_joinplayer(function(player)
        update_sound(player)
    end)

    -- Cyclic sound update
    core.after(0, cyclic_update)

end
