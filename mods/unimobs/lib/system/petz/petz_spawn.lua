---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- petz_spawn.lua
--      Shared API functions from the petz/petz mod
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local abs = math.abs
local floor = math.floor
local random = math.random

-- Timer to call unimobs.petz_api.spawn_mob() at regular intervals
local spawn_timer = 0
-- Used in calls to unimobs.petz_api.check_mob_limit (original value was 53)
local default_search_radius = 50
-- List of offsets used to adjust the position of mobs spawned in a herd. The first mini-table is
--      for the first mob spawned in the herd, and so on
local herd_offset_list = {
    {x = 0, z = 0},
    {x = 1, z = 0},
    {x = -2, z = 0},
    {x = 1, z = 1},
    {x = 0, z = -2},
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function can_mob_spawn_here(mob_type, spawn_biome, spawn_pos, spawn_node)

    -- Adadpted from code in petz.spawn_mob(), moved from our unimobs.petz_api.spawn_mob() into
    --      a separate function
    -- Returns true if the specified "mob_type" is suitable to be spawned at a location whose
    --      characteristics are described by "spawn_biome", "spawn_pos" and "spawn_node"

    -- N.B. Fixes a bug from the original code, that prevents any more mobs being added to the
    --      candidate list, if just one unregistered mob is checked
    local ent_table = core.registered_entities["unilib:mob_" .. mob_type]
    if not ent_table then
        return
    end

    -- Check forbidden/disabled spawning for this mob
    if unimobs.global.forbidden_spawn_table[mob_type] == true or
            unimobs.petz_api.get_msetting(mob_type, "disable_spawn_flag") then
        return false
    end

    -- Check monsters
    if ent_table.is_monster_flag and unimobs.petz_setting.disable_monsters_flag then
        return false
    end

    -- Check min/max height
    if (ent_table.spawn_max_height and spawn_pos.y > ent_table.spawn_max_height) or
            (ent_table.spawn_min_height and spawn_pos.y < ent_table.spawn_min_height) then
        return false
    end

    -- Check min/max light
    if ent_table.spawn_min_light then

        local light_level = core.get_node_light(spawn_pos, 0.5)
        if not light_level or light_level < ent_table.spawn_min_light then
            return false
        end

    end

    if ent_table.spawn_max_light then

        local light_level = core.get_node_light(spawn_pos, 0.5)
        if not light_level or light_level > ent_table.spawn_max_light then
            return false
        end

    end

    -- Check night-time spawning
    if ent_table.spawn_at_night_flag and not unimobs.petz_api.is_night() then
        return false
    end

    -- Check seasonal spawning
    local spawn_month = unimobs.petz_api.get_custom_msetting(mob_type, "spawn_month")
    if spawn_month and spawn_month ~= unimobs.petz_api.get_os_month() then
        return false
    end

    -- Check the biome in which the mob will spawn
    -- N.B. This code block fixes a flaw in the original petz code, in which mobs which spawn in
    --      specified biomes spawned at a much lower rate, than mobs that spawn in any biome
    if not unimobs.petz_api.get_msetting(mob_type, "spawn_biome_all_flag") and
            not unimobs.petz_api.check_lookup_table_in_msetting(
                mob_type, "spawn_biome_table", spawn_biome
            ) then
        return false
    end

    -- Check the node on which (or in which) the mob will spawn
    if not unimobs.petz_api.get_msetting(mob_type, "spawn_node_all_flag") and
            not unimobs.petz_api.check_lookup_table_in_msetting(
                mob_type, "spawn_node_table", spawn_node.name
            ) and
            not unimobs.petz_api.check_lookup_table_in_msetting_by_group(
                mob_type, "spawn_node_table", spawn_node.name
            ) then
        return false
    end

    -- This mob is suitable for spawning at the specified location
    return true

end

local function count_nearby_mobs(pos, dist, mob_type)

    -- From petz.count_closest_petz()
    -- Checks nearby mobs, returning two values: the total number of mobs found within the specified
    --      "dist", and the number that match the specified "mob_type"
    -- Only counts mobs which were registered via a call to unimobs.petz_api.register_mob()

    local mob_count = 0
    local matching_mob_count = 0

    for id, obj in pairs(unimobs.global.active_mob_table) do

        local luaent = obj.object:get_luaentity()
        if luaent and
                unimobs.mobkit_api.is_object_alive(obj.object) and
                luaent.petz_compat_flag and
                unimobs.petz_global.mob_table[luaent.mob_type] ~= nil then

            local obj_pos = obj.object:get_pos()
            local obj_dist = abs(obj_pos.x - pos.x) + abs(obj_pos.z - pos.z)
            if obj_dist <= dist then

                mob_count = mob_count + 1
                if luaent.mob_type == mob_type then
                    matching_mob_count = matching_mob_count + 1
                end

            end

        end

    end

    return mob_count, matching_mob_count

end

local function get_below_node(pos)

    -- From petz.get_node_below()
    -- Gets the node one block below the specified "pos"

    return core.get_node({x = pos.x, y = pos.y - 1.0, z = pos.z})

end

local function is_deep_in_liquid(pos)

    -- From petz.spawn_is_in_deep()
    -- Returns true if the two nodes immediately above the specified "pos" are liquids, false
    --      otherwise
    -- See also the similar (but not identical) function,
    --      unilib.pkg.shared_mobkit_aqua.is_deep_in_liquid()

    if not pos then
        return false
    end

    pos.y = pos.y + 1.1
    local above_def_table = unimobs.mobkit_api.get_node_defn_at_pos(pos)

    pos.y = pos.y + 1
    local higher_def_table = unimobs.mobkit_api.get_node_defn_at_pos(pos)

    if (above_def_table and above_def_table.drawtype == "liquid") and
            (higher_def_table and higher_def_table.drawtype == "liquid") then
        return true
    else
        return false
    end

end

local function do_timer(dtime)

    -- Originally in the core.register_globalstep() block
    -- Timer to call unimobs.petz_api.spawn_mob() at regular intervals

    spawn_timer = spawn_timer + dtime
    if spawn_timer > unimobs.petz_setting.spawn_interval then
        spawn_timer = 0
    else
        return
    end

    local abr = tonumber(core.get_mapgen_setting("active_block_range")) or 3
    local spawn_pos, liquid_flag = unimobs.mobkit_api.get_spawn_pos_kitz(abr)
    if spawn_pos then
        unimobs.petz_api.spawn_mob(spawn_pos, liquid_flag, abr, true)
    end

end

---------------------------------------------------------------------------------------------------
-- Shared API functions (from petz/petz/api/api_spawn.lua)
---------------------------------------------------------------------------------------------------

function unimobs.petz_api.check_mob_limit(pos, mob_type, optional_search_radius)

    -- From petz.limit_reached()
    -- Counts the number of mobs within the specified "optional_search_radius" (if not specified,
    --      then the search radius is 50)
    -- Returns true if the number of mobs is already at the maximum; false if we're still below the
    --      limits specified by settings
    -- There are two limits specified by settings: a maximum number of (all) mobs, and a maximum
    --      number of mobs of the same type; both limits are checked

    local mob_count, matching_mob_count =
            count_nearby_mobs(pos, optional_search_radius or default_search_radius, mob_type)

    if mob_count >= unimobs.petz_setting.spawn_max_mobs and
            matching_mob_count >= unimobs.petz_setting.spawn_max_mobs_of_matching_type then
        return true
    else
        return false
    end

end

function unimobs.petz_api.refine_spawn_position(mob_type, pos)

    -- From petz.pos_to_spawn()
    -- When a mob is due to be spawn at position "pos", tweak the y component of the position,
    --      hoping to make the mob spawn just above the surface, regardless of its size
    -- N.B. The original code used the mob's .visual_size directly. That is no longer possible,
    --      although we can retrieve the value from global variables. However, we get better results
    --      using the mob's collisionbox anyway

    local data_table = unimobs.petz_global.mob_table[mob_type]
    if not data_table then
        return pos
    end

    local collisionbox = data_table.collisionbox or {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5, rotate = true}
    local visual_size = data_table.visual_size or 1

    local cbox_height = collisionbox[5] - collisionbox[2]   -- ymax - ymin
    local spawn_pos = {x = pos.x, y = pos.y + cbox_height, z = pos.z}

    -- Sanity check - don't spawn inside a solid node
    if not unimobs.kitz_api.is_air(spawn_pos) and not unimobs.kitz_api.is_liquid(spawn_pos) then
        return pos
    else
        return spawn_pos
    end

end

function unimobs.petz_api.spawn_mob(spawn_pos, liquid_flag, abr, check_limits_flag)

    -- From petz.spawn_mob()
    -- Spawns one or more mobs, at or near the specified "spawn_pos"
    -- Usually called by the core.register_globalstep() below, but is available to be called by
    --      other code, when appropriate
    -- Returns a list of spawned entities (may be an empty list)
    --
    -- "liquid_flag" should be true if "spawn_pos" is in a liquid
    -- If "check_limits_flag" is true, check the population limits specified by settings, before
    --      spawning mobs

    local spawned_list = {}

    -- Prevent spawning in protected areas, if required
    if unimobs.petz_setting.disable_spawn_in_protected_areas_flag and
            core.is_protected(spawn_pos, "") then
        return spawned_list
    end

    -- In water, we test the node at "spawn_pos"; on land, we test the node just below "spawn_pos"
    local spawn_node
    if not liquid_flag then

        -- The node below "spawn_pos"
        spawn_node = get_below_node(spawn_pos)

    else

        -- In a liquid, so spawn only when the nodes above are also liquids
        if not is_deep_in_liquid(spawn_pos) then
            return spawned_list
        else
            spawn_node = core.get_node(spawn_pos)
        end

    end

    -- Get the biome for "spawn_pos"
    local spawn_biome = core.get_biome_name(core.get_biome_data(spawn_pos).biome)

    -- Create a list of the mobs that can spawn at this location (taking into account "spawn_node",
    --      minimum/maximum height, light levels and so on)
    local candidate_list = {}
    for _, mob_type in ipairs(unimobs.petz_global.mob_list) do

        if can_mob_spawn_here(mob_type, spawn_biome, spawn_pos, spawn_node) then
            table.insert(candidate_list, mob_type)
        end

    end

    -- We can give up now, if no candidates were found
    if #candidate_list < 1 then
        return spawned_list
    end

    -- Select a candidate at random
    local random_mob_type = candidate_list[random(1, #candidate_list)]
    local random_mob_name = "unilib:mob_" .. random_mob_type

    -- Check the probability of it spawning
    local spawn_probability = unimobs.kitz_api.clamp_value_in_range(
        (unimobs.petz_api.get_msetting(random_mob_type, "custom_spawn_probability") or 0), 0, 1
    )

    if random(1, floor((1 / spawn_probability) + 0.5)) ~= 1 then
        return spawned_list
    end

    -- Limit the total number of mobs in any area, and the number of mobs of the same species
    if check_limits_flag and
            unimobs.petz_api.check_mob_limit(spawn_pos, random_mob_type, (abr * 16) + 5) then
        return spawned_list
    end

    -- Spawn in herds, if permitted
    local spawn_herd_size = unimobs.petz_api.get_msetting(random_mob_type, "spawn_herd_size")
    if spawn_herd_size then

        if spawn_herd_size == 0 then
            spawn_herd_size = 1
        elseif spawn_herd_size > unimobs.petz_setting.max_spawn_herd_size then
            spawn_herd_size = unimobs.petz_setting.max_spawn_herd_size
        end

    else

        spawn_herd_size = 1

    end

    -- N.B. Our version of this code block fixes a bug, in which herds never spawn (only individual
    --      mobs, one for each call to this function)
    for i = 1, random(1, spawn_herd_size) do

        -- Offset the position of each spawned mob, so that they're not all in the same place
        -- (If the user has increased the maximum herd size above the original value of 5, then any
        --      additional mobs are not offset)
        if i <= unimobs.petz_setting.max_spawn_herd_size then

            spawn_pos.x = spawn_pos.x + herd_offset_list[i].x
            spawn_pos.z = spawn_pos.z + herd_offset_list[i].z

        end

        -- Recalculate pos.y for bigger mobs
        spawn_pos = unimobs.petz_api.refine_spawn_position(random_mob_type, spawn_pos)
        if not spawn_pos then

            -- On failure, stop spawning members of the herd
            return spawned_list

        end

        local obj = core.add_entity(spawn_pos, random_mob_name)
        if not obj then

            -- On failure, stop spawning members of the herd
            return spawned_list

        else

            table.insert(spawned_list, obj)

            -- N.B. Original code did not write a log message for every mob spawned
            local luaent = obj:get_luaentity()
            if luaent then

                unilib.utils.log(
                    "action",
                    string.format(
                        "[unimobs] Spawned %s at %s",
                        luaent.name,
                        unimobs.petz_api.pos_to_string(vector.round(obj:get_pos()))
                    )
                )

                --[[
                core.log(
                    string.format(
                        "Spawned %s at %s",
                        luaent.name,
                        unimobs.petz_api.pos_to_string(vector.round(obj:get_pos()))
                    )
                )
                ]]--

            end

        end

    end

    -- Individual mob (or herd of mobs) has been spawned
    return spawned_list

end

---------------------------------------------------------------------------------------------------
-- Setup code (from petz/petz/api/api_spawn.lua)
---------------------------------------------------------------------------------------------------

core.register_globalstep(function(dtime)
    do_timer(dtime)
end)
