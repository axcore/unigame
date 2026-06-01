---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- awards_utils.lua
--      Utility functions for player awards
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions (filters)
---------------------------------------------------------------------------------------------------

function unilib.awards.apply_filter(achievement_name, val)

    -- Can be called for the specified achievement, when the trigger's .filter_list is a list of
    --      simple values
    -- Returns true if .filter_list is nil, or if "val" appears in the trigger's .filter_list (in
    --      which case, this event should be handled)
    -- Otherwise returns false (in which case, this event should be ignored). If .filter_list is
    --      specified but empty (for some reason), then we return false

    local filter_list =
            unilib.global.awards_achievement_table[achievement_name]["trigger_table"]["filter_list"]

    if filter_list == nil or unilib.utils.is_value_in_list(val, filter_list) then
        return true
    else
        return false
    end

end

function unilib.awards.apply_filter_as_regex(achievement_name, val)

    -- Can be called for the specified achievement, when the trigger's .filter_list is a list of
    --      regexes
    -- Returns true if .filter_list is nil, or if "val" matches any of the regexes in the trigger's
    --      .filter_list (in which case, this event should be handled)
    -- Otherwise returns false (in which case, this event should be ignored). If .filter_list is
    --      specified but empty (for some reason), then we return false

    local filter_list =
            unilib.global.awards_achievement_table[achievement_name]["trigger_table"]["filter_list"]

    if filter_list == nil then
        return true
    end

    for _, regex in ipairs(filter_list) do

        if string.find(val, regex) then
            return true
        end

    end

    return false

end

---------------------------------------------------------------------------------------------------
-- Shared functions ("simple" triggers)
---------------------------------------------------------------------------------------------------

function unilib.awards.handle_simple_trigger(player, trigger_prototype, multiple)

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, trigger_prototype)
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        if achievement_table["trigger_table"]["prototype"] == trigger_prototype then
            unilib.awards.increment_achievement_counter(player, achievement_name, (multiple or 1))
        end

    end

end

function unilib.awards.handle_simple_filter_trigger(player, trigger_prototype, item, multiple)

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, trigger_prototype)
    ) do

        if unilib.awards.apply_filter(achievement_name, item) then
            unilib.awards.increment_achievement_counter(player, achievement_name, (multiple or 1))
        end

    end

end

function unilib.awards.handle_simple_filter_as_regex_trigger(
    player, trigger_prototype, item, multiple
)
    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_simple_watch_table(player, trigger_prototype)
    ) do

        if unilib.awards.apply_filter_as_regex(achievement_name, item) then
            unilib.awards.increment_achievement_counter(player, achievement_name, (multiple or 1))
        end

    end

end

function unilib.awards.handle_complex_trigger(player, trigger_prototype, item, multiple)

    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_complex_watch_table(player, trigger_prototype, item)
    ) do

        local achievement_table = unilib.global.awards_achievement_table[achievement_name]
        if achievement_table["trigger_table"]["prototype"] == trigger_prototype then
            unilib.awards.increment_achievement_counter(player, achievement_name, (multiple or 1))
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions ("custom" triggers)
---------------------------------------------------------------------------------------------------

function unilib.awards.unlock_collection_achievement(player, achievement_name, count)

    -- This award is locked; unlock, if enough distinct types of item have been "collected";
    --      otherwise, store the number of distinct items as an indication of the player's progress
    --      towards the target
    local trigger_table = unilib.global.awards_achievement_table[achievement_name]["trigger_table"]
    if count >= trigger_table.target then

        unilib.awards.unlock_achievement(player, achievement_name)

    else

        local pname = player:get_player_name()
        local awards_table = unilib.global.awards_player_table[pname]

        if awards_table["current_table"][achievement_name] == nil or
                awards_table["current_table"][achievement_name] > count then
            awards_table["current_table"][achievement_name] = count
        end

    end

end

function unilib.awards.add_item_to_collection(player, main_achievement, item)

    -- The player data table has a key-value pair for every distinct "item" collected; it can be
    --      any string, including full node names or just arbitrary text

    local pname = player:get_player_name()
    local awards_table = unilib.global.awards_player_table[pname]

    -- Check that "main_achievement" has an entry in the player data table and, if not, initialise
    --      it
    if awards_table["data_table"][main_achievement] == nil then
        awards_table["data_table"][main_achievement] = {}
    end

    -- Check that the "item" has not already been added to this achievement's collection
    if awards_table["data_table"][main_achievement][item] ~= nil then
        return
    end

    -- New item has been collected; return the total distinct items collected
    awards_table["data_table"][main_achievement][item] = true
    return unilib.utils.get_table_size(awards_table["data_table"][main_achievement])

end

function unilib.awards.handle_collection_trigger(player, trigger_prototype, main_achievement, item)

    local pname = player:get_player_name()
    local awards_table = unilib.global.awards_player_table[pname]

    -- Called for custom triggers which "collect" items (how many different types of stone have been
    --      broken by the player, ignoring how many of each type has been broken)
    -- The player data table has a key-value pair for every distinct "item" collected; it can be
    --      any string, including full node names or just arbitrary text
    local count = unilib.awards.add_item_to_collection(player, main_achievement, item)
    if count == nil then
        return
    end

    -- Now we can check achievements individually
    for _, achievement_name in ipairs(
        unilib.awards.retrieve_data_from_custom_watch_table(player, trigger_prototype)
    ) do

        if awards_table["unlock_table"][achievement_name] == nil then
            unilib.awards.unlock_collection_achievement(player, achievement_name, count)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (miscellaneous)
---------------------------------------------------------------------------------------------------

function unilib.awards.check_argument(val)

    -- A function that checks a value to be used as an achievement's .item_list or .filter_list
    -- When "val" specifies one or more nodes, craftitems or tools, we need to check whether at
    --      least one of those items actually exists in the game; if not, then the achievement
    --      doesn't need to be registered
    --
    -- Return true if the achievement can be registered, because:
    --      - "val" is nil
    --      - "val" is a string, and
    --          - "val" matches the name of a registered node, craftitem or tool, or
    --          - "val" in the form "group:X"
    --      - "val" is a list, and
    --          - At least one item in the list is the name of a registered node, craftitem or tool,
    --              or
    --          - At least one item in the list is in the form "group:X"
    -- Otherwise, return false meaning that the achievement should not be registered

    if val == nil then

        return true

    elseif type(val) ~= "table" then

        if string.sub(val, 1, 6) == "group:" or core.registered_items[val] ~= nil then
            return true
        end

    else

        for _, item in ipairs(val) do

            if string.sub(item, 1, 6) == "group:" or core.registered_items[item] ~= nil then
                return true
            end

        end

    end

    return false

end
