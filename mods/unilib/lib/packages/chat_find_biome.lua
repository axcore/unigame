---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    findbiomes
-- Code:    MIT
-- Media:   unknown
--
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_find_biome = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

-- Does what it says on the tin
local find_water_level = tonumber(core.get_mapgen_setting("water_level"))
-- Calculate the maximum playable limit
local find_mapgen_limit = tonumber(core.get_mapgen_setting("mapgen_limit"))
local find_chunksize = tonumber(core.get_mapgen_setting("chunksize"))
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

-- A list of biome names for /switch_biome
local switch_biome_list = {}
-- The next biome for switching (position of an item in the list; the first item is #1)
local switch_next_biome = 0

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_in_world(pos)

    -- Returns true if pos is within the world boundaries

    return not (
        math.abs(pos.x) > find_playable_limit or math.abs(pos.y) > find_playable_limit or
                math.abs(pos.z) > find_playable_limit
    )

end

local function adjust_pos_to_biome_limits(pos, biome_id)

    -- Checks if pos is within the biome's boundaries. If it isn't, places pos inside the
    --      boundaries

    local bpos = table.copy(pos)
    local biome_name = core.get_biome_name(biome_id)
    local biome = core.registered_biomes[biome_name]
    if not biome then

        unilib.utils.show_error("chat_find_biome package: non-existent biome!")
        return bpos, true

    end

    local axes = {"y", "x", "z"}
    local out_of_bounds = false
    for a = 1, #axes do

        local ax = axes[a]
        local min, max
        if biome[ax .. "_min"] then
            min = biome[ax .. "_min"]
        else
            min = -find_playable_limit
        end
        if biome[ax .. "_max"] then
            max = biome[ax .. "_max"]
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

                local biome_data = core.get_biome_data(pos)
                -- Sometimes biome_data is nil
                local biome = biome_data and biome_data.biome
                for id_ind = 1, #biome_ids do

                    local biome_id = biome_ids[id_ind]
                    pos = adjust_pos_to_biome_limits(pos, biome_id)
                    local spos = table.copy(pos)
                    if biome == biome_id then

                        local good_spawn_height = pos.y <= find_water_level + 16 and
                                pos.y >= find_water_level
                        local spawn_y = core.get_spawn_level(spos.x, spos.z)
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

        local id = core.get_biome_id(biomes[i])
        if not id then
            return nil, false
        end

        table.insert(biome_ids, id)

    end

    success_flag = search()

    return spawn_pos, success_flag

end

local function match_biome(pattern)

    -- Original to unilib
    -- Called only by /find_biome. Returns a list of biomes whose name matches the specified
    --      pattern, sorted by length (so that the closest match is the one used first)

    local return_list = {}

    for biome_name, _ in pairs(core.registered_biomes) do

        if string.match(biome_name, pattern) then
            table.insert(return_list, biome_name)
        end

    end

    table.sort(return_list, function(a, b)
        return string.len(a) < string.len(b)
    end)

    return return_list

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_find_biome.init()

    return {
        description = "Chat commands /find_biome, /switch_biome",
        notes = "Finds and teleports to the specified (or most recent) biome, or teleports to" ..
                " biomes in a repeating cycle",
    }

end

function unilib.pkg.chat_find_biome.exec()

    -- Adapted from "findbiomes" mod
    core.register_chatcommand("find_biome", {
        params = S("[biome]"),
        description = S(
            "Finds and teleports to the first matching biome found (or the previous biome found" ..
                    " with this command, if no pattern is specified)"
        ),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not unilib.global.mods_loaded_flag then
                return false
            elseif not player then
                return false, unilib.constant.chat_offline_msg
            end

            -- biome_list is a list of biomes matching "param"; we transport the player to the first
            --      biome that the algorithm can actually find in the world
            local biome_list = {}
            if param == "" and recent_biome ~= nil then

                table.insert(biome_list, recent_biome)

            else

                biome_list = match_biome(param)
                if #biome_list == 0 then
                    return false, S("No matching biomes found (try /list_biomes)")
                end

            end

            local pos = player:get_pos()

            for _, biome_name in ipairs(biome_list) do

                local biome_pos, success_flag = find_biome(pos, {biome_name})
                if success_flag then

                    player:set_pos(biome_pos)
                    recent_biome = biome_name
                    return true, S(
                        "Biome \"@1\" found at @2",
                        biome_name,
                        core.pos_to_string(biome_pos)
                    )

                end

            end

            -- The algorithm couldn't find any of the biomes in "biome_list" (although they have all
            --      been registered)
            if #biome_list == 1 then

                return false, S(
                    "Found one biome matching \"@1\", but couldn't find its location in the world",
                    param
                )

            else

                return false, S(
                    "Found @1 biomes matching \"@2\", but couldn't find their locations in the" ..
                            " world",
                    #biome_list,
                    param
                )

            end

        end,
    })

    -- Original to unilib
    core.register_chatcommand("switch_biome", {
        params = "",
        description = S("Teleports to biomes in a repeating cycle"),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            end

            if not unilib.global.mods_loaded_flag then
                return false
            end

            -- If this is the first time using the command in this session, compile a list of biomes
            if switch_next_biome == 0 then

                for biome_name, _ in pairs(core.registered_biomes) do
                    table.insert(switch_biome_list, biome_name)
                end

                if #switch_biome_list == 0 then
                    return false, S("No biomes found!")
                else
                    switch_next_biome = 1
                end

            end

            local next_biome = switch_biome_list[switch_next_biome]
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
                    core.pos_to_string(biome_pos)
                )

            else

                return false, S("Biome \"@1\" not found!", next_biome)

            end

        end,
    })

end
