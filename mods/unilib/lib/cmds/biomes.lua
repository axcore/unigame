---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- biomes.lua
--      Set up chat commands for detecting/finding biomes
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Setup code (adapted from findbiomes/init.lua)
---------------------------------------------------------------------------------------------------

-- The commands /find_biome and /switch_biome must only work once all mods are loaded
local mods_loaded_flag = false

minetest.register_on_mods_loaded(function()

    -- Enable the chat commands to work
    mods_loaded_flag = true

end)

---------------------------------------------------------------------------------------------------
-- /show_biome: Toggles showing the current biome (adapted from display_biome/init.lua)
---------------------------------------------------------------------------------------------------

-- Table of connected player names (as keys) and their current position data (table as a value)
local show_player_table = {}
-- Global callbacks are expected every 0.1 seconds, but don't update the display more often than
--      every 0.5 seconds
local show_timer = 0

minetest.register_on_joinplayer(function(player)

    -- When the player connects, add an entry to "show_player_table"

    local pname = player:get_player_name()
    local storage_key = "biomes_show_" .. pname

    if tonumber(unilib.get_mod_attribute(storage_key)) == 1 then

        -- Display enabled
        show_player_table[pname] = {
            last_ippos = {x = 0,y = 0,z = 0},
            id = player:hud_add({
                name = "show_biomes",
                hud_elem_type = "text",

                number = 0xFF0000,  -- Red text
                position = {x = 0.5, y = 0.1},
                text = "-",
            }),
            enable = true,
        }

    else

        -- Display not enabled
        show_player_table[pname] = {
            last_ippos = {x = 0,y = 0,z = 0},
            id = player:hud_add({
                name = "show_biomes",
                hud_elem_type = "text",

                number = 0xFF0000,  -- Red text
                position = {x = 0.5, y = 0.1},
                text = "",
            }),
            enable = false,
        }

    end

end)

minetest.register_on_leaveplayer(function(player)

    -- When the player disconnects, remove the entry to "show_player_table"

    local pname = player:get_player_name()
    if show_player_table[pname] then
        show_player_table[pname] = nil
    end

end)

minetest.register_globalstep(function(dtime)

    -- Global callback to update the biome displayed

    -- Global callbacks are expected every 0.1 seconds, but don't update the display more often than
    --      every 0.5 seconds
    show_timer = show_timer + dtime
    if show_timer < 0.5 then
        return
    end
    show_timer = 0

    -- Update each player's display in turn
    for _, player in ipairs(minetest.get_connected_players()) do

        local pname = player:get_player_name()
        if show_player_table[pname].enable == true then

            -- Integer position
            local ippos = vector.round(player:get_pos())
            -- Surface position at which to calculate biome
            local bpos = vector.new(ippos)

            -- If the position has changed...
            if not vector.equals(ippos, show_player_table[pname].last_ippos) then

                -- Simple search for ground elevation
                while bpos.y > 0 and minetest.get_node(bpos).name == "air" do
                    bpos.y = bpos.y - 1
                end

                local heat, humidity, name
                local bdata = minetest.get_biome_data(bpos)
                heat = math.floor(bdata.heat + 0.5)
                humidity = math.floor(bdata.humidity + 0.5)
                name = minetest.get_biome_name(bdata.biome)

                local msg = S("Temperature: @1\nHumidity: @2", heat, humidity)
                -- (Default value of the .description field, is the same as the value of the .name
                --      field)
                if unilib.biome_table[name] ~= nil and
                        unilib.biome_table[name]["description"] ~= name then
                    msg = msg .. "\n" .. unilib.biome_table[name]["description"]
                end

                msg = msg .. "\n" .. name

                local rc = player:hud_change(show_player_table[pname].id, "text", msg)
                -- Check return code, seems to fix occasional startup glitches
                if rc == 1 then

                    -- Update player's position
                    show_player_table[pname].last_ippos = vector.new(ippos)

                end

            end

        end

    end

end)

minetest.register_chatcommand("show_biome", {
    params = "",
    description = S("Toggles showing the current biome"),
    privs = {unilib_tools = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        local storage_key = "biomes_show_" .. name

        if show_player_table[name].enable == true then

            player:hud_change(show_player_table[name].id, "text", "")
            show_player_table[name].enable = false
            unilib.set_mod_attribute(storage_key, "0")

        else

            player:hud_change(show_player_table[name].id, "text", "-")
            -- Reset position
            show_player_table[name].last_ippos = {x = 0, y = 0, z = 0}
            show_player_table[name].enable = true
            unilib.set_mod_attribute(storage_key, "1")

        end

    end,
})

---------------------------------------------------------------------------------------------------
-- /find_biome: Finds and teleports to the specified (or most recent) biome
--      (adapted from findbiomes/init.lua)
---------------------------------------------------------------------------------------------------

-- Does what it says on the tin
local find_water_level = tonumber(minetest.get_mapgen_setting("water_level"))
-- Calculate the maximum playable limit
local find_mapgen_limit = tonumber(minetest.get_mapgen_setting("mapgen_limit"))
local find_chunksize = tonumber(minetest.get_mapgen_setting("chunksize"))
local find_playable_limit = math.max(find_mapgen_limit - (find_chunksize + 1) * 16, 0)
-- Most recent biome selected by a /find_biome or /switch_biome command
local recent_biome = nil

-- Search parameters
-- Resolution of search grid in nodes.
local find_grid_res = 64
-- Number of points to check in the square search grid (edge * edge).
local find_check_points = 128 * 128

-- Direction table
local find_dir_table = {
    {x = 0, y = 0, z = 1},
    {x = -1, y = 0, z = 0},
    {x = 0, y = 0, z = -1},
    {x = 1, y = 0, z = 0},
}

local function is_in_world(pos)

    -- Returns true if pos is within the world boundaries

    return not (
        math.abs(pos.x) > find_playable_limit or math.abs(pos.y) > find_playable_limit or
                math.abs(pos.z) > find_playable_limit
    )

end

local function adjust_pos_to_biome_limits(pos, biome_id)

    -- Checks if pos is within the biome's boundaries. If it isn't, places pos inside the boundaries

    local bpos = table.copy(pos)
    local biome_name = minetest.get_biome_name(biome_id)
    local biome = minetest.registered_biomes[biome_name]
    if not biome then

        unilib.log("error", "[/find_biome] adjust_pos_to_biome_limits non-existing biome!")
        return bpos, true

    end

    local axes = {"y", "x", "z"}
    local out_of_bounds = false
    for a=1, #axes do

        local ax = axes[a]
        local min, max
        if biome[ax.."_min"] then
            min = biome[ax.."_min"]
        else
            min = -find_playable_limit
        end
        if biome[ax.."_max"] then
            max = biome[ax.."_max"]
        else
            max = find_playable_limit
        end

        min = tonumber(min)
        max = tonumber(max)
        if bpos[ax] < min then

            out_of_bounds = true
            bpos[ax] = min
            if max-min > 16 then
                bpos[ax] = math.max(bpos[ax] + 8, -find_playable_limit)
            end

        end

        if bpos[ax] > max then

            out_of_bounds = true
            bpos[ax] = max
            if max-min > 16 then
                bpos[ax] = math.min(bpos[ax] - 8, find_playable_limit)
            end

        end

    end

    return bpos, out_of_bounds

end

local function find_biome(pos, biomes)

    -- Called by both /find_biome and /switch_biomes

    -- Pos: Starting point for biome checks. This also sets the y co-ordinate for all points
    --      checked, so the suitable biomes must be active at this y.
    pos = vector.round(pos)

    -- Initial variables
    local edge_len = 1
    local edge_dist = 0
    local dir_step = 0
    local dir_ind = 1
    local success_flag = false
    local spawn_pos
    local biome_ids

    -- Get next position on square search spiral
    local function next_pos()

        if edge_dist == edge_len then

            edge_dist = 0
            dir_ind = dir_ind + 1
            if dir_ind == 5 then
                dir_ind = 1
            end
            dir_step = dir_step + 1
            edge_len = math.floor(dir_step / 2) + 1

        end

        local dir = find_dir_table[dir_ind]
        local move = vector.multiply(dir, find_grid_res)

        edge_dist = edge_dist + 1

        return vector.add(pos, move)

    end

    -- Position search
    local function search()

        local attempt = 1
        while attempt < 3 do

            for iter = 1, find_check_points do

                local biome_data = minetest.get_biome_data(pos)
                -- Sometimes biome_data is nil
                local biome = biome_data and biome_data.biome
                for id_ind = 1, #biome_ids do

                    local biome_id = biome_ids[id_ind]
                    pos = adjust_pos_to_biome_limits(pos, biome_id)
                    local spos = table.copy(pos)
                    if biome == biome_id then

                        local good_spawn_height = pos.y <= find_water_level + 16 and
                                pos.y >= find_water_level
                        local spawn_y = minetest.get_spawn_level(spos.x, spos.z)
                        if spawn_y then
                            spawn_pos = {x = spos.x, y = spawn_y, z = spos.z}
                        elseif not good_spawn_height then
                            spawn_pos = {x = spos.x, y = spos.y, z = spos.z}
                        elseif attempt >= 2 then
                            spawn_pos = {x = spos.x, y = spos.y, z = spos.z}
                        end

                        if spawn_pos then

                            local adjusted_pos, outside = adjust_pos_to_biome_limits(
                                spawn_pos,
                                biome_id
                            )
                            if is_in_world(spawn_pos) and not outside then
                                return true
                            end

                        end

                    end

                end

                pos = next_pos()

            end

            attempt = attempt + 1

        end

        return false

    end

    -- Table of suitable biomes
    biome_ids = {}
    for i=1, #biomes do

        local id = minetest.get_biome_id(biomes[i])
        if not id then
            return nil, false
        end
        table.insert(biome_ids, id)

    end

    success_flag = search()

    return spawn_pos, success_flag

end

minetest.register_chatcommand("find_biome", {
    params = S("[<biome>]"),
    description = S("Finds and teleports to the specified (or most recent) biome"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        if not mods_loaded_flag then
            return false
        elseif (param == nil or param == "") and recent_biome ~= nil then
            param = recent_biome
        elseif not minetest.get_biome_id(param) then
            return false, S("Biome does not exist (try /list_biomes)")
        end

        local player = minetest.get_player_by_name(name)
        local pos = player:get_pos()
        local biome_pos, success_flag = find_biome(pos, {param})
        if success_flag then

            player:set_pos(biome_pos)
            recent_biome = param
            return true, S("Biome found at @1", minetest.pos_to_string(biome_pos))

        else

            return false, S("Biome not found!")

        end

    end,
})

---------------------------------------------------------------------------------------------------
-- /switch_biome: Teleports to biomes in a repeating cycle (original to unilib)
---------------------------------------------------------------------------------------------------

-- A list of biome names
local switch_biome_list = {}
-- The next biome for switching (position of an item in the list; the first item is #1)
local switch_next_biome = 0

minetest.register_chatcommand("switch_biome", {
    params = "",
    description = S("Teleports to biomes in a repeating cycle"),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        if not mods_loaded_flag then
            return false
        end

        -- If this is the first time using the command in this session, compile a list of biomes
        if switch_next_biome == 0 then

            for biome_name, _ in pairs(minetest.registered_biomes) do
                table.insert(switch_biome_list, biome_name)
            end

            if #switch_biome_list == 0 then
                return false, S("No biomes found!")
            else
                switch_next_biome = 1
            end

        end

        local next_biome = switch_biome_list[switch_next_biome]

        local player = minetest.get_player_by_name(name)
        local pos = player:get_pos()
        local biome_pos, success_flag = find_biome(pos, {next_biome})
        if success_flag then

            player:set_pos(biome_pos)
            recent_biome = next_biome

            -- Set the biome to use, the next time this command is run
            switch_next_biome = switch_next_biome + 1
            if switch_next_biome > #switch_biome_list then
                switch_next_biome = 1
            end

            return true, S(
                "Biome \"@1\" found at @2",
                next_biome,
                minetest.pos_to_string(biome_pos)
            )

        else

            return false, S("Biome \"@1\" not found!")

        end

    end,
})
