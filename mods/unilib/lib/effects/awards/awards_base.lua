---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- awards_base.lua
--      Set up player awards (original to unilib)
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- A table of "simple" trigger prototypes, and all achievements that depend on them
-- Table in the form
--      simple_watch_table[prototype_name] = list_of_achievement_names
local simple_watch_table = {}
-- For "complex" triggers, a table of full item names (nodes, craftitems, tools), and all
---     achievements that depend on them
-- Table in the form
--      complex_watch_table[full_name] = list_of_achievement_names
local complex_watch_table = {}
-- For "complex" triggers, a table of group names (e.g. "stone"), and all achievements that depend
--      on them
-- Table in the form
--      group_watch_table[group_name] = list_of_achievement_names
local group_watch_table = {}
-- For "complex" triggers that don't specify an .item_list, a table of "complex" trigger prototypes,
--      and all achievements that depend on them
-- Table in the form
--      universal_watch_table[prototype_name] = list_of_achievement_names
local universal_watch_table = {}
-- A table of "custom" trigger prototypes, and all achievements that depend on them
-- Table in the form
--      custom_watch_table[prototype_name] = list_of_achievement_names
local custom_watch_table = {}

-- Vocations can specify a .requires_list - a list of achievements that must be unlocked, before
--      levels in the vocation can be unlocked
-- A reverse lookup table, matching an achievement with the vocations that require it
-- Table in the form
--      vocation_parent_table[achievement_name] = list_of_vocation_names
local vocation_parent_table = {}
-- Achievements can themselves specify a .requires_list - a list of (other) achievements that must
--      be unlocked, before this achievement can be unlocked
-- A reverse lookup table, matching one of the "other" achievements, with the achievements that
--      require it
-- Table in the form
--      achievement_parent_table[achievement_name] = list_of_achievement_names
-- N.B. An achievement cannot require itself
local achievement_parent_table = {}
-- Achievements can specify a .vocation_list - a list of vocations whose levels can be unlocked with
--      this achievement
-- A reverse lookup table, matching a vocation with the achievements that affect it
-- Table in the form
--      vocation_child_table[vocation_name] = list_of_achievement_names
local vocation_child_table = {}
-- A list of achievements which do not contribute to a vocation
local homeless_achievement_list = {}

-- Prize lists populated by the shared functions below
-- A list of prizes awarded to a player unlocking a level in any vocation, which does NOT specify
--      its own .prize_list
local standard_level_prize_list = {}
-- A list of prizes awarded to a player unlocking the top level in any vocation, which does NOT
--      specify its own .prize_list. If specified, these prizes are awarded after any specified in
--      "standard_level_prize_list"
local standard_vocation_prize_list = {}
-- A list of prizes awarded to a player unlocking any achievement, which does NOT specify its own
--      .prize_list
local standard_achievement_prize_list = {}

-- Callback lists populated by the shared functions below
-- A list of callback functions called when a player unlocks any level in a vocation, which does NOT
--      specify its own .unlock_func
local standard_level_callback_list = {}
-- A list of callback functions called when a player unlocks the top level in any vocation, which
--      does NOT specify its own .unlock_func. If specified, these callbacks are called after any
--      specified in "standard_level_callback_list"
local standard_vocation_callback_list = {}
-- A list of callback functions called when a player unlocks any achievement, which does NOT specify
--      its own .unlock_func
local standard_achievement_callback_list = {}

-- Lookup table to check for duplicate level titles
local level_check_table = {}

-- Default sounds for vocation levels/achievements
local achievement_sound = "unilib_award_achievement"
local trophy_sound = "unilib_award_trophy"
local vocation_sound = "unilib_award_vocation"

---------------------------------------------------------------------------------------------------
-- Local functions (misc)
---------------------------------------------------------------------------------------------------

local function give_item_to_player(player, item)

    -- Called by distribute_level_prizes() and distribute_achievement_prizes()
    -- Gives "player" the "item", which is a string used to create an ItemStack, e.g.
    --      "unilib:dye_red 2"

    local inv = player:get_inventory()
    local leftover = inv:add_item("main", ItemStack(item))
    if leftover:get_count() > 0 then
        core.add_item(player:get_pos(), leftover)
    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (vocations)
---------------------------------------------------------------------------------------------------

local function get_duplicate_level_titles(level_list)

    -- Called by unilib.awards.register_vocation()
    -- "level_list" is a list of mini-tables for a single vocation, in the form described in that
    --      function

    local return_list = {}
    for _, mini_table in ipairs(level_list) do

        if mini_table.title ~= nil then

            local lc_title = string.lower(mini_table.title)
            if level_check_table[lc_title] then
                table.insert(return_list, mini_table.title)
            else
                level_check_table[lc_title] = true
            end

        end

    end

    return return_list

end

local function is_vocation_blocked(player, vocation_name)

    -- Called by can_unlock_level() and do_unlock_achievement()
    -- The specified vocation may be "blocked" if it specifies a .requires_list - a list of
    --      achievement names which must be unlocked, before any of this vocation's levels can be
    --      unlocked
    -- Returns true if "player" has not yet unlocked any of the required achievements, or false if
    --      they player has unlocked all of them (or if no achievements are required)

    local pname = player:get_player_name()
    local level_table = unilib.global.awards_player_table[pname]["level_table"]
    local requires_list = unilib.global.awards_vocation_table[vocation_name]["requires_list"]

    -- (Don't bother checking if some levels have already been unlocked)
    if (level_table[vocation_name] == nil or level_table[vocation_name] == 0) and
            requires_list ~= nil and
            #requires_list > 0 then

        local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
        for _, other_achievement in ipairs(requires_list) do

            if unlock_table[other_achievement] ~= true then
                return true
            end

        end

    end

    return false

end

local function distribute_level_prizes(player, vocation_name, new_level)

    -- Called by do_unlock_level() when "player" unlocks a "new_level" in the specified vocation
    -- Adds prizes to the player's inventory, if possible

    local level_list = unilib.global.awards_vocation_table[vocation_name]["level_list"]
    local mini_table = level_list[new_level]

    if mini_table ~= nil and mini_table.prize_list ~= nil and #mini_table.prize_list > 0 then

        for _, item in ipairs(mini_table.prize_list) do
            give_item_to_player(player, item)
        end

    else

        -- All levels
        for _, item in ipairs(standard_level_prize_list) do
            give_item_to_player(player, item)
        end

        -- Final level
        if new_level >= #level_list then

            for _, item in ipairs(standard_vocation_prize_list) do
                give_item_to_player(player, item)
            end

        end

    end

end

local function display_unlock_level(player, vocation_name, new_level)

    -- Called by do_unlock_level() when "player" unlocks a "new_level" in the specified vocation

    local pname = player:get_player_name()
    local vocation_table = unilib.global.awards_vocation_table[vocation_name]

    -- Displays a message in the chat window
    if unilib.setting.awards_text_flag then

        unilib.utils.chat_send_player(
            pname,
            S(
                "Level unlocked: [@1 @2] @3",
                vocation_table["title"],
                new_level,
                vocation_table["level_list"][new_level]["title"]
            )
        )

    end

    local max_levels = #vocation_table["level_list"]
    if unilib.setting.awards_notify_flag and new_level >= max_levels then

        for _, other_player in ipairs(core.get_connected_players()) do

            local opname = other_player:get_player_name()
            if opname ~= pname then

                unilib.utils.chat_send_player(
                    opname,
                    S("@1 unlocked the final level in \"@2\".", opname, vocation_table["title"])
                )

            end

        end

    end

    -- Display a HUD announcement
    if unilib.setting.awards_announce_flag then

        -- When unilib.setting.announce_hud_mode is "fixed", award announcements are crowded on the
        --      left-side of the screen ("fixed" works well for identify announcements, though)
        local hud_mode = unilib.setting.announce_hud_mode
        if hud_mode == "fixed" then
            hud_mode = "middle"
        end

        -- Select a border colour
        local border_colour = "orange"
        if new_level >= (max_levels - 2) then
            border_colour = "violet"
        end

        -- Select an image
        local img = "unilib_gui_trophy_comb.png"
        if new_level == max_levels then
            img = "unilib_gui_trophy_gold.png"
        elseif new_level == (max_levels - 1) then
            img = "unilib_gui_trophy_silver.png"
        elseif new_level == (max_levels - 2) then
            img = "unilib_gui_trophy_bronze.png"
        elseif vocation_table.icon then
            img = vocation_table.icon
        end

        -- Select a sound effect
        local sound
        if unilib.setting.awards_sound_flag then

            if vocation_table.sound then
                sound = vocation_table.sound
            elseif new_level >= (max_levels - 2) then
                sound = trophy_sound
            else
                sound = vocation_sound
            end

        end

        -- Display the announcement
        unilib.announce.add_long_announcement(pname, {
            category = "awards_vocation",
            hud_mode = hud_mode,
            border_colour = border_colour,
            img = img,
            -- Assumes a 48x48 texture; standard scale is 2.4 for a 16x16 texture
            img_scale = 0.8,
            sound = sound,
            text_top = S("Level unlocked: @1", vocation_table["level_list"][new_level]["title"]),
            text_bottom = S("@1 (@2)", vocation_table.title, new_level),
        })

    end

end

local function check_level(vocation_name, score)

    -- Called by can_unlock_level() to find the highest level in the specified vocation that can be
    --      unlocked with the player's cumulative "score" in this vocation
    -- Returns the level number; the calling code should check whether this is higher than before,
    --      and respond if so
    --
    -- Note that this function may skip levels; e.g. if the player has just unlocked an achievement
    --      and their score has increased from 20 to 100, then a level whose score is 50 is skipped,
    --      and the level whose score is 100 is return instead
    -- Note that this function will not return a lower level than has already been awarded (so if
    --      the vocation has been tweaked, the player keeps their current level, even if another
    --      player with the same "score" could not unlock that level

    local level_list = unilib.global.awards_vocation_table[vocation_name]["level_list"]

    for level, mini_table in ipairs(level_list) do

        if mini_table.score > score then
            return level - 1
        end

    end

    -- Failsafe: return the maximum level (in case the player's score has exceeded it)
    return #level_list

end

local function can_unlock_level(player, vocation_name)

    -- Called by update_vocations()
    -- Tests whether "player" can unlock a new level in the specified vocation
    -- If so, returns the number of the unlockable level; otherwise returns nil

    local pname = player:get_player_name()

    -- Check whether the vocation is blocked (some achievements must be unlocked, before any of the
    --      vocation's levels can be unlocked)
    if is_vocation_blocked(player, vocation_name) then
        return nil
    end

    -- Check the player's cumulative score against each level, until we find out if it's time to
    --      unlock a new level
    local score_table = unilib.global.awards_player_table[pname]["score_table"]
    local level_table = unilib.global.awards_player_table[pname]["level_table"]

    local new_level = check_level(vocation_name, score_table[vocation_name])
    if new_level > level_table[vocation_name] then
        return new_level
    else
        return nil
    end

end

local function do_unlock_level(player, vocation_name, new_level)

    -- Called by update_vocations() and unilib.awards.unlock_level()
    -- Unlocks the specified level in the specified vocation for "player"

    -- Update global variables
    local pname = player:get_player_name()
    
    unilib.global.awards_player_table[pname]["level_table"][vocation_name] = new_level

    table.insert(
        unilib.global.awards_player_table[pname]["progress_list"],
        {
            level_flag = true,
            name = vocation_name,
            level = new_level,
            time = os.time(),
        }
    )
    
    -- Execute responses
    display_unlock_level(player, vocation_name, new_level)
    distribute_level_prizes(player, vocation_name, new_level)

    local vocation_table = unilib.global.awards_vocation_table[vocation_name]
    local max_levels = #vocation_table.level_list
    if vocation_table.unlock_func ~= nil then

        vocation_table.unlock_func(player, vocation_name, new_level, max_levels)

    else

        -- All levels
        for _, unlock_func in ipairs(standard_level_callback_list) do
            unlock_func(player, vocation_name, new_level, max_levels)
        end

        -- Final level
        if new_level >= max_levels then

            for _, unlock_func in ipairs(standard_vocation_callback_list) do
                unlock_func(player, vocation_name, new_level, max_levels)
            end

        end

    end

end

local function update_vocations(player, achievement_name)

    -- Called by do_unlock_achievement() when "player" unlocks the specified achievement
    -- Unlocks levels in all related vocations, if possible

    local pname = player:get_player_name()
    local score = unilib.global.awards_achievement_table[achievement_name]["score"]

    for _, vocation_name in ipairs(
        unilib.global.awards_achievement_table[achievement_name]["vocation_list"]
    ) do

        local level_table = unilib.global.awards_player_table[pname]["level_table"]
        if level_table[vocation_name] == nil then

            -- Level 0 means no levels unlocked yet
            level_table[vocation_name] = 0

        end

        local score_table = unilib.global.awards_player_table[pname]["score_table"]
        if score_table[vocation_name] == nil then
            score_table[vocation_name] = score
        else
            score_table[vocation_name] = score_table[vocation_name] + score
        end

        local new_level = can_unlock_level(player, vocation_name)
        if new_level ~= nil then
            do_unlock_level(player, vocation_name, new_level)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (achievements)
---------------------------------------------------------------------------------------------------

local function distribute_achievement_prizes(player, achievement_name)

    -- Called by do_unlock_achievement() when "player" unlocks the specified achievement
    -- Adds prizes to the player's inventory, if possible

    local prize_list = unilib.global.awards_achievement_table[achievement_name]["prize_list"]
    if prize_list ~= nil and #prize_list > 0 then

        for _, item in ipairs(prize_list) do
            give_item_to_player(player, item)
        end

    else

        -- Use the "standard" prize list, only when the achievement doesn't specify its own prize
        --      list
        for _, item in ipairs(standard_achievement_prize_list) do
            give_item_to_player(player, item)
        end

    end

end

local function display_unlock_achievement(player, achievement_name)

    -- Called by do_unlock_achievement() when "player" unlocks the specified achievement

    local pname = player:get_player_name()
    local achievement_table = unilib.global.awards_achievement_table[achievement_name]

    -- Display a message in the chat window
    if unilib.setting.awards_text_flag then

        unilib.utils.chat_send_player(
            pname,
            S(
                "Achievement unlocked: @1 (@2)",
                achievement_table["title"],
                achievement_table["description"]
            )
        )

    end

    -- Display a HUD announcement
    if unilib.setting.awards_announce_flag then

        -- When unilib.setting.announce_hud_mode is "fixed", award announcements are crowded on the
        --      left-side of the screen ("fixed" works well for identify announcements, though)
        local hud_mode = unilib.setting.announce_hud_mode
        if hud_mode == "fixed" then
            hud_mode = "middle"
        end

        -- Select an image
        local img, img_scale
        if achievement_table.icon then

            img = achievement_table.icon
            -- Assumes a 48x48 texture; standard scale is 2.4 for a 16x16 texture
            img_scale = 0.8

        else

            img = "unilib_gui_emoticon_" .. math.random(1, 5) .. ".png"
            -- Assumes a 32x32 texture; make it a bit smaller than the maximum 1.6
            img_scale = 1.2

        end

        -- Select a sound effect
        local sound
        if unilib.setting.awards_sound_flag then

            if achievement_table.sound then
                sound = achievement_table.sound
            else
                sound = achievement_sound
            end

        end

        -- Display the announcement
        unilib.announce.add_long_announcement(pname, {
            category = "awards_achievement",
            hud_mode = hud_mode,
            border_colour = "yellow",
            img = img,
            img_scale = img_scale,
            sound = sound,
            text_top = S("Achievement unlocked: @1", achievement_table.title),
            text_bottom = achievement_table.description,
        })

    end

end

local function can_unlock_achievement(player, achievement_name)

    -- Called by do_unlock_achievement() and unilib.awards.increment_achievement_counter()
    -- Tests whether "player" can unlock the specified achievement
    -- If so, returns true; if not, returns false

    local pname = player:get_player_name()

    -- If this achievement can't be unlocked until other achievements have been unlocked, then
    --      check the others
    local achievement_table = unilib.global.awards_achievement_table[achievement_name]
    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    if achievement_table.requires_list ~= nil then

        for _, other_achievement in ipairs(achievement_table.requires_list) do

            if unlock_table[other_achievement] ~= true then
                return false
            end

        end

    end

    -- Check the player's current score against the achievement's target
    local current_table = unilib.global.awards_player_table[pname]["current_table"]
    -- N.B. Calling code should have already checked that the achievement is not already unlocked;
    --      do this extra check anyway, in case this function is called by new code in the future
    if not unlock_table[achievement_name] then

        local target = achievement_table["trigger_table"]["target"]
        if target <= current_table[achievement_name] then
            return true
        end

    end

    return false

end

local function do_unlock_achievement(player, achievement_name)

    -- Called by unilib.awards.unlock_achievement(), unilib.awards.increment_achievement_counter()
    --      and by this function recursively
    -- Unlocks the specified achievement for "player"

    -- Update global variables
    local pname = player:get_player_name()
    
    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    unlock_table[achievement_name] = true

    table.insert(
        unilib.global.awards_player_table[pname]["progress_list"],
        {
            level_flag = false,
            name = achievement_name,
            time = os.time(),
        }
    )
    
    -- Execute responses
    display_unlock_achievement(player, achievement_name)
    distribute_achievement_prizes(player, achievement_name)

    local unlock_func = unilib.global.awards_achievement_table[achievement_name]["unlock_func"]
    if unlock_func ~= nil then

        unlock_func(player, achievement_name)

    else

        for _, unlock_func in ipairs(standard_achievement_callback_list) do
            unlock_func(player, achievement_name)
        end

    end

    -- Check whether the player's vocations need to be updated
    update_vocations(player, achievement_name)

    -- If other achievements/vocations depend on this one, check whether they need to be auto-
    --      unlocked too
    if achievement_parent_table[achievement_name] ~= nil then

        for _, other_achievement in ipairs(achievement_parent_table[achievement_name]) do

            if not unlock_table[achievement_name] and
                    can_unlock_achievement(player, other_achievement) then
                do_unlock_achievement(player, other_achievement)
            end

        end

    end

    if vocation_parent_table[achievement_name] ~= nil then

        for _, other_vocation in ipairs(vocation_parent_table[achievement_name]) do

            -- "achievement_name" had to be unlocked, before "other_vocation" levels can be unlocked
            -- First check that there aren't other achievements still to unlock, before we can
            --      unlock "other_vocation" levels
            if not is_vocation_blocked(player, other_vocation) then

                local child_list = vocation_child_table[other_vocation]
                if child_list ~= nil then

                    for _, other_achievement in ipairs(child_list) do
                        update_vocations(player, other_achievement)
                    end

                end

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (registry functions)
---------------------------------------------------------------------------------------------------

function unilib.awards.register_vocation(data_table)

    -- Registers a vocation in global variables
    -- A vocation is a collection of related achievements, e.g. "lumberjack", "fisherman" and so on
    -- Each vocation has multiple levels; the more achievements the player unlocks, the higher the
    --      player's level in the vocation
    -- The aim is for the player to reach the top level. Typically, some kind of reward is granted
    --      on reaching the top level, but rewards can be granted at any level
    --
    -- data_table compulsory fields:
    --      name (str): e.g. "lumberjack", matches a key in unilib.global.awards_vocation_table.
    --          Not visible to the player (unless the .title field is unspecified)
    --
    -- data_table optional fields:
    --      title (str): e.g. "Lumberjack"
    --      description (str): e.g. "Cut down trees and plant saplings"
    --      icon (str): Icon to use for this vocation; if not specified, a default texture is used
    --      level_list (list): A list of mini-tables, defining each level. Mini-tables in the form
    --          title (str): e.g. "Amateur Lumberjack". You'll see a warning about duplicated level
    --              titles, but it's not a fatal error
    --          score (int): The cumulative score required to unlock the level, e.g. 100
    --          prize_list (list): [optional] Item(s) to be awarded to a player unlocking this
    --              level. Each item in the list is a string used to create an ItemStack, e.g.
    --              "unilib:dye_red 2"
    --      requires_list (list): A list of achievement names (matching keys in
    --          unilib.global.awards_achievement_table). If not empty, this vocation is hidden and
    --          its levels cannot be unlocked until the player unlocks those achievements
    --      secret_flag (bool): If true, this vocation is hidden until the player unlocks the first
    --          level
    --      sound (str): If specified, the sound to play when a level is unlocked; otherwise, a
    --          default sound is played (if settings are enabled)
    --      unlock_func (func): Callback called when a level is unlocked. The callback receives the
    --          arguments (player, vocation_name, new_level)

    local name = data_table.name

    local title = data_table.title or name
    local description = data_table.description or S("Vocation")
    local icon = data_table.icon or nil
    local level_list = data_table.level_list or {}
    local requires_list = data_table.requires_list or {}
    local secret_flag = data_table.secret_flag or false
    local sound = data_table.sound or nil
    local unlock_func = data_table.unlock_func or nil

    -- Basic checks
    if unilib.global.awards_vocation_table[data_table.name] ~= nil then

        unilib.utils.show_warning(
            "unilib.awards.register_vocation(): Duplicate vocation", data_table.name
        )

        return false

    end

    for _, duplicate in ipairs(get_duplicate_level_titles(level_list)) do

        -- (Not a fatal error)
        unilib.utils.show_warning(
            "unilib.awards.register_vocation(): Duplicate level title", data_table.name, duplicate
        )

    end

    -- Register the vocation
    unilib.global.awards_vocation_table[data_table.name] = {
        title = title,
        description = description,
        icon = icon,
        level_list = level_list,
        requires_list = requires_list,
        secret_flag = secret_flag,
        sound = sound,
        unlock_func = unlock_func,
    }

    if requires_list ~= nil then

        for _, other_achievement in ipairs(requires_list) do

            if vocation_parent_table[other_achievement] == nil then
                vocation_parent_table[other_achievement] = {name}
            else
                table.insert(vocation_parent_table[other_achievement], name)
            end

        end

    end

    return true

end

function unilib.awards.register_achievement(data_table)

    -- Registers an achievement in global variables
    -- An achievement can be "unlocked" (awarded to the player) in two ways:
    --      - When the shared function, unilib.awards.unlock_achievement(), is called
    --      - When an event takes place (once, or multiple times). An event can be a direct player
    --          action (e.g. breaking, placing or crafting a node), or some other kind of event
    --          (e.g. joining the server or dying)
    --
    -- data_table compulsory fields:
    --      name (str): e.g. "better_lighting", matches a key in
    --          unilib.global.awards_achievement_table. Not visible to the player (unless the .title
    --          field is unspecified)
    --      trigger_table (str): A trigger describes the conditions under which an achievement is
    --          unlocked. A table in the form:
    --              prototype (str): The name of the trigger prototype (matches a key in
    --                  unilib.global.awards_trigger_prototype_table)
    --              target (int): [optional] The number of events that must occur in order to
    --                  unlock the achievement. If not specified, 1 is used. "custom" triggers may
    --                  use this field, if they need it
    --              filter_list (list): [optional] Used with "simple" triggers, ignored for
    --                  "complex" triggers. "custom" triggers may use this field, if they need it.
    --                  Items used by some triggers to filter out certain events. The items in
    --                  .filter_list can be simple values or regexes. For example, the event
    --                  callback unilib.awards.on_die() uses it to filter out player deaths whose
    --                  reason doesn't appear in the list (exactly); on the other hand,
    --                  unilib.awards.on_chat() uses it to filter out chat messages which don't
    --                  match any of the regexes in the list. By default, if  .filter_list is not
    --                  specified at all, nothing is filtered out; but if it is an empty list, then
    --                  all events are filtered out. Note that certain awards packages may use a
    --                  different default behaviour, filtering out all events if .filter_list is not
    --                  specified at all (see the "award_daredevil" package for a working example)
    --              item_list (list): [optional] Used with "complex" triggers, ignored for "simple"
    --                  triggers. "custom" triggers may use this field, if they need it. The full
    --                  names of items (e.g. nodes), or aliases to items (e.g. nodes), or group
    --                  names (e.g. "group:stone"), or a combination of all three. Most "complex"
    --                  triggers specify an .item_list, but if it's not specified then the event
    --                  applies to all items (e.g. a trigger to count the total number of blocks of
    --                  all types that the player has broken)
    --
    -- data_table optional fields:
    --      title (str): e.g. "Better Lighting"
    --      description (str): e.g. "Place 50 torches". If not specified, a string provided by the
    --          trigger prototype is used
    --      icon (str): Icon to use for this achievement; if not specified, a default texture is
    --          used
    --      prize_list (list): Item(s) to be awarded to a player unlocking this achievement. Each
    --          item in the list is a string used to create an ItemStack, e.g. "unilib:dye_red 2"
    --      requires_list (list): A list of achievement names (matching keys in
    --          unilib.global.awards_achievement_table). If not empty, this achievement is hidden
    --          and cannot be unlocked until the player unlocks those achievements. An achievement
    --          cannot require itself
    --      secret_flag (bool): If true, this achievement is hidden until the player unlocks it
    --      score (int): A score (e.g. 10) representing the relative difficulty of this achievement.
    --          When the achievement is unlocked, the score is passed to all vocations in
    --          .vocation_list, allowing the player to advance their level in that vocation. If not
    --          specified, a default value of 10 is used
    --      sound (str): If specified, the sound to play when an achievement is unlocked; otherwise,
    --          a default sound is played (if settings are enabled)
    --      unlock_func (func): Callback called when the achievement is unlocked. The callback
    --          receives the arguments (player, achievement_name)
    --      vocation_list (list): A list of vocations which are dependent on this achievement. If
    --          not specified (or empty), the achievement is independent of any vocation. Otherwise,
    --          unlocking the achievement advances the player's level in the specified vocations

    local name = data_table.name
    local trigger_table = data_table.trigger_table

    local title = data_table.title or name
    local description = data_table.description or nil
    local icon = data_table.icon or nil
    local prize_list = data_table.prize_list or {}
    local requires_list = data_table.requires_list or {}
    local secret_flag = data_table.secret_flag or false
    local score = data_table.score or 10
    local sound = data_table.sound or nil
    local unlock_func = data_table.unlock_func or nil
    local vocation_list = data_table.vocation_list or {}

    -- Basic checks
    if name == nil or trigger_table == nil then

        unilib.utils.show_warning(
            "unilib.awards.register_achievement(): Invalid achievement definition",
            name
        )

        return false

    elseif trigger_table.prototype == nil then

        unilib.utils.show_warning(
            "unilib.awards.register_achievement(): Unspecified trigger prototype",
            name
        )

        return false

    end

    local prototype_table = unilib.global.awards_trigger_prototype_table[trigger_table.prototype]
    if prototype_table == nil then

        unilib.utils.show_warning(
            "unilib.awards.register_achievement(): Non-existent trigger prototype",
            name,
            trigger_table.prototype
        )

        return false

    end

    if trigger_table.target == nil then
        trigger_table.target = 1
    end

    local trigger_type = prototype_table.trigger_type or "simple"
    if trigger_type ~= "simple" then
        trigger_table.filter_list = nil
    end

    if trigger_type == "complex" and trigger_table.item_list == nil then
        trigger_table.item_list = {}
    elseif trigger_type ~= "complex" then
        trigger_table.item_list = nil
    end

    if unilib.global.awards_achievement_table[data_table.name] ~= nil then

        unilib.utils.show_warning(
            "unilib.awards.register_achievement(): Duplicate achievement", data_table.name
        )

        return false

    elseif requires_list ~= nil and
            unilib.utils.is_value_in_list(data_table.name, requires_list) then

        unilib.utils.show_warning(
            "unilib.awards.register_achievement(): Achievements must not require themselves"
        )

        return false

    end

    -- Register the achievement
    unilib.global.awards_achievement_table[data_table.name] = {
        title = title,
        trigger_table = trigger_table,

        description = description,
        icon = icon,
        prize_list = prize_list,
        requires_list = requires_list,
        secret_flag = secret_flag,
        score = score,
        sound = sound,
        unlock_func = unlock_func,
        vocation_list = vocation_list,
    }

    -- Update watch tables
    if trigger_type == "simple" then

        if simple_watch_table[trigger_table.prototype] == nil then
            simple_watch_table[trigger_table.prototype] = {name}
        else
            table.insert(simple_watch_table[trigger_table.prototype], name)
        end

    elseif trigger_type == "complex" then

        if #trigger_table.item_list == 0 then

            if universal_watch_table[trigger_table.prototype] == nil then
                universal_watch_table[trigger_table.prototype] = {name}
            else
                table.insert(universal_watch_table[trigger_table.prototype], name)
            end

        else

            for _, full_name in ipairs(trigger_table.item_list) do

                if string.sub(full_name, 1, 6) == "group:" then

                    local group = string.sub(full_name, 7)
                    if group_watch_table[group] == nil then
                        group_watch_table[group] = {name}
                    else
                        table.insert(group_watch_table[group], name)
                    end

                else

                    -- (Convert alias to original name; this handles all alias problems)
                    full_name = core.registered_aliases[full_name] or full_name

                    if complex_watch_table[full_name] == nil then
                        complex_watch_table[full_name] = {name}
                    else
                        table.insert(complex_watch_table[full_name], name)
                    end

                end

            end

        end

    elseif trigger_type == "custom" then

        if custom_watch_table[trigger_table.prototype] == nil then
            custom_watch_table[trigger_table.prototype] = {name}
        else
            table.insert(custom_watch_table[trigger_table.prototype], name)
        end

    end

    -- Update other tables/lists
    if #vocation_list == 0 then

        table.insert(homeless_achievement_list, name)

    else

        for _, other_vocation in ipairs(vocation_list) do

            if vocation_child_table[other_vocation] == nil then
                vocation_child_table[other_vocation] = {name}
            else
                table.insert(vocation_child_table[other_vocation], name)
            end

        end

    end

    for _, other_achievement in ipairs(requires_list) do

        if achievement_parent_table[other_achievement] == nil then
            achievement_parent_table[other_achievement] = {name}
        else
            table.insert(achievement_parent_table[other_achievement], name)
        end

    end

    return true

end

function unilib.awards.register_trigger_prototype(data_table)

    -- Registers the trigger prototype in global variables
    -- A trigger describes the conditions under which an achievement is unlocked (awarded to the
    --      player)
    -- Triggers belong to one of a number of trigger types; each type is defined by a trigger
    --      prototype
    -- unilib provides several trigger prototypes; packages can call this function to create new
    --      ones, as required
    --
    -- data_table compulsory fields:
    --      name (str): e.g. "unilib_break", matches a key in
    --          unilib.global.awards_trigger_prototype_table
    --
    -- data_table optional fields:
    --      trigger_type (str): "simple", "complex" or "custom". An achievement can be unlocked when
    --          an event takes place (once, or multiple times). An event can be a direct player
    --          action (e.g. breaking, placing or crafting a node), or some other kind of event
    --          (e.g. joining the server). "simple" triggers define only a target (the number of
    --          events required to unlock the achievement). "complex" triggers define both a target,
    --          and associated items (e.g. the full name of a block that must be broken, placed or
    --          crafted). "custom" triggers define only a target, which can be 1 if no particular
    --          count is required. If not specified, the default value is "simple"
    --      hint_list (list): If specified, a list of two items, messages to display for an
    --          achievement that doesn't specify a .description. The first item is singular, the
    --          second plural, e.g. {"Break one block", "Break @1 blocks"}
    --      progress_list - If specified, a list of two items, messages to display next to the
    --          achievement's progress bar. The first item is singular, the second plural, e.g.
    --          {"Break one block", "Break @1/@2 blocks"}

    local name = data_table.name

    local trigger_type = data_table.trigger_type or "simple"
    local hint_list = data_table.hint_list or {}
    local progress_list = data_table.progress_list or {}

    if unilib.global.awards_trigger_prototype_table[data_table.name] ~= nil then

        unilib.utils.show_warning(
            "unilib.awards.register_trigger_prototype(): Duplicate trigger prototype",
            data_table.name
        )

        return false

    else

        unilib.global.awards_trigger_prototype_table[data_table.name] = {
            trigger_type = trigger_type,
            hint_list = hint_list,
            progress_list = progress_list,
        }

        return true

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (shared API functions)
---------------------------------------------------------------------------------------------------

function unilib.awards.add_standard_achievement_callback(func)

    -- Adds a callback function to be called when a player unlocks any achievement (unless the
    --      achievement specifies its own callback function)

    table.insert(standard_achievement_callback_list, func)

end

function unilib.awards.add_standard_level_callback(func)

    -- Adds a callback function to be called when a player unlocks any level in any vocation (unless
    --      the vocation specifies its own callback function)

    table.insert(standard_level_callback_list, func)

end

function unilib.awards.add_standard_vocation_prize(item)

    -- Adds a callback function to be called when a player unlocks the top level in any vocation
    --      (unless the vocation specifies its own callback function)

    table.insert(standard_vocation_callback_list, func)

end

function unilib.awards.add_standard_achievement_prize(item)

    -- Adds a prize to be awarded when a player unlocks any achievement (unless the achievement
    --      specifies its own prize(s) )
    -- (See also unilib.awards.insert_achievement_prize() )
    --
    -- "item" is a string used to create an itemstack, e.g. "unilib:dye_red 2"

    table.insert(standard_achievement_prize_list, item)

end

function unilib.awards.add_standard_level_prize(item)

    -- Adds a prize to be awarded when a player unlocks any level (including the top one) in any
    --      vocation (unless the vocation specifies its own prize(s) for that level)
    -- (See also unilib.awards.insert_vocation_prize() )
    --
    -- "item" is a string used to create an itemstack, e.g. "unilib:dye_red 2"

    table.insert(standard_level_prize_list, item)

end

function unilib.awards.add_standard_vocation_prize(item)

    -- Adds a prize to be awarded when a player unlocks the top level in any vocation (unless the
    --      vocation specifies its own prize(s) for that level)
    -- (See also unilib.awards.insert_vocation_prize() )
    --
    -- "item" is a string used to create an itemstack, e.g. "unilib:dye_red 2"

    table.insert(standard_vocation_prize_list, item)

end

function unilib.awards.get_achievements_by_vocation(vocation_name)

    -- Returns a list of achievements that can be used to unlock levels in the specified vocation

    return vocation_child_table[vocation_name] or {}

end

function unilib.awards.get_homeless_achievements()

    -- Returns a list of acheivements that do not contribute to any vocation

    return homeless_achievement_list

end

function unilib.awards.insert_achievement_prize(achievement_name, item_str)

    -- unilib's built-in award packages do not award prizes for unlocking achievements
    -- This function can be called by remix/package writers who want to add prizes for their own
    --      games, with the items that are actually available in that game
    -- (See also unilib.awards.add_standard_achievement_prize() )
    --
    -- "vocation_name" should be a key in unilib.global.awards_achievement_table
    -- "item_str" is a string used to create an Itemstack, e.g. "unilib:dye_red 2"; note that
    --      duplicates are NOT ignored
    --
    -- Returns true on success, false on failure

    local achievement_table = unilib.global.awards_achievement_table[achievement_name]
    if vocation_table == nil then

        unilib.utils.show_warning(
            "unilib.awards.insert_achievement_prize(): Unregistered achievement", achievement_name
        )

        return false

    else

        table.insert(achievement_table.prize_list, item_str)
        return true

    end

end

function unilib.awards.insert_vocation_prize(vocation_name, level, item_str)

    -- unilib's built-in award packages do not award prizes for unlocking levels
    -- This function can be called by remix/package writers who want to add prizes for their own
    --      games, with the items that are actually available in that game
    -- (See also unilib.awards.add_standard_vocation_prize() and
    --      unilib.awards.add_standard_level_prize() )
    --
    -- "vocation_name" should be a key in unilib.global.awards_vocation_table
    -- "level" should be an index in the vocation's .level_list
    -- "item_str" is a string used to create an Itemstack, e.g. "unilib:dye_red 2"; note that
    --      duplicates are NOT ignored
    --
    -- Returns true on success, false on failure

    local vocation_table = unilib.global.awards_vocation_table[vocation_name]
    if vocation_table == nil then

        unilib.utils.show_warning(
            "unilib.awards.insert_vocation_prize(): Unregistered vocation", vocation_name
        )

        return false

    elseif vocation_table.level_list[level] == nil then

        unilib.utils.show_warning(
            "unilib.awards.insert_vocation_prize(): Non-existent level", vocation_name, level
        )

        return false

    else

        table.insert(vocation_table.level_list[level]["prize_list"], item_str)
        return true

    end

end

function unilib.awards.lock_achievement(player, achievement_name)

    -- Called only by the chat command in the "chat_unlock_achievement" package
    -- Re-locks the specified achievement for "player"
    -- N.B. This counts as an artificial re-lock; any related vocations are not modified (so the
    --      player's cumulative score and level in those vocations will not decrease)

    local pname = player:get_player_name()
    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    if not unlock_table[achievement_name] then

        return false

    else

        unlock_table[achievement_name] = nil
        return true

    end

end

function unilib.awards.reset_level(player, vocation_name)

    -- Resets "player"'s level in the specified vocation back to 0, effectively "re-locking" the
    --      vocation for that player

    local pname = player:get_player_name()
    unilib.global.awards_player_table[pname]["level_table"][vocation_name] = 0

end

function unilib.awards.reset_achievement(player, achievement_name)

    -- "Re-locks" the specified achievement for "player"
    -- N.B. Any other achievements/vocations, which can only be unlocked when this achievement is
    --      unlocked, are not affected

    local pname = player:get_player_name()
    unilib.global.awards_player_table[pname]["unlock_table"][achievement_name] = nil

end

function unilib.awards.unlock_level(player, vocation_name, new_level)

    -- Adapted from update_vocations()
    -- Unlocks the specified level in the specified vocation for "player"
    -- N.B. This counts as a forced unlock; we don't call can_unlock_level() first

    local pname = player:get_player_name()
    local level_table = unilib.global.awards_player_table[pname]["level_table"]
    if new_level > level_table[vocation_name] then

        do_unlock_level(player, vocation_name, new_level)
        return true

    else

        return false

    end

end

function unilib.awards.unlock_achievement(player, achievement_name)

    -- Adapted from unilib.awards.increment_achievement_counter()
    -- Unlocks the specified achievement for "player"
    -- N.B. This counts as a forced unlock; we don't call can_unlock_achievement() first

    local pname = player:get_player_name()
    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    if not unlock_table[achievement_name] then

        do_unlock_achievement(player, achievement_name)
        return true

    else

        return false

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (other shared functions)
---------------------------------------------------------------------------------------------------

function unilib.awards.increment_achievement_counter(player, achievement_name, multiple)

    -- Called by the event callbacks for a trigger prototype (see
    --      ../lib/effects/awards/awards_triggers.lua for unilib's built-in trigger prototypes)
    -- Because of the event, the specified achievement's counter must be increased (e.g. if the
    --      player digs a dirt block, update the counters for all achievements that track the number
    --      of dirt blocks dug by a player)
    -- If the achievement can be unlocked as a result, then unlock it (and also check related
    --      vocations)

    local pname = player:get_player_name()
    if not pname then
        return
    end

    -- Sanity check: if the named achievement doesn't exist (probably because the package that
    --      provides has not been loaded), then don't update player awards data, retaining the
    --      existing data in case the achievement is re-enabled later
    if not unilib.global.awards_achievement_table[achievement_name] then
        return
    end

    -- Sanity check: do nothing if the achievement is already unlocked
    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    if unlock_table[achievement_name] then
        return
    end

    -- Update player awards data
    local current_table = unilib.global.awards_player_table[pname]["current_table"]
    if current_table[achievement_name] == nil then
        current_table[achievement_name] = multiple
    else
        current_table[achievement_name] = current_table[achievement_name] + multiple
    end

    -- Unlock the achievement, if possible
    if can_unlock_achievement(player, achievement_name) then
        do_unlock_achievement(player, achievement_name)
    end

end

function unilib.awards.retrieve_data_from_simple_watch_table(player, prototype_name)

    -- Called by the event callbacks for a trigger prototype (or by any other code)
    -- For the specified "simple" trigger prototype, returns a list of achievements that depend on
    --      them, filtering out any achievements that "player" has already unlocked

    local pname = player:get_player_name()
    if not pname or not unilib.global.awards_player_table[pname] then
        return {}
    end

    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    local return_list = {}

    if simple_watch_table[prototype_name] ~= nil then

        for _, achievement_name in ipairs(simple_watch_table[prototype_name]) do

            if not unlock_table[achievement_name] then
                table.insert(return_list, achievement_name)
            end

        end

    end

    return return_list

end

function unilib.awards.retrieve_data_from_complex_watch_table(player, prototype_name, full_name)

    -- Called by the event callbacks for a trigger prototype (or by any other code)
    -- For the specified item (node, craftitem or tool), returns a list of achievements that depend
    --      on them, taking into account not just the item's "full_name", but also group names and
    --      aliases, when necessary. Filter out any achiements that "player" has already unlocked

    local pname = player:get_player_name()
    if not pname or not unilib.global.awards_player_table[pname] then
        return {}
    end

    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    local return_list = {}

    if universal_watch_table[prototype_name] ~= nil then

        for _, achievement_name in ipairs(universal_watch_table[prototype_name]) do

            if not unlock_table[achievement_name] then
                table.insert(return_list, achievement_name)
            end

        end

    end

    if complex_watch_table[full_name] ~= nil then

        for _, achievement_name in ipairs(complex_watch_table[full_name]) do

            if not unlock_table[achievement_name] then
                table.insert(return_list, achievement_name)
            end

        end

    else

        local defn_table = core.registered_items[full_name]
        if defn_table and defn_table.groups then

            for group, _ in pairs(defn_table.groups) do

                if group_watch_table[group] ~= nil then

                    for _, achievement_name in ipairs(group_watch_table[group]) do

                        if not unlock_table[achievement_name] then
                            table.insert(return_list, achievement_name)
                        end

                    end

                    break

                end

            end

        end

    end

    return return_list

end

function unilib.awards.retrieve_data_from_custom_watch_table(player, prototype_name)

    -- Called by the event callbacks for a trigger prototype (or by any other code)
    -- For the specified "custom" trigger prototype, returns a list of achievements that depend on
    --      them (may be an empty list)

    local pname = player:get_player_name()
    if not pname or not unilib.global.awards_player_table[pname] then
        return {}
    end

    local unlock_table = unilib.global.awards_player_table[pname]["unlock_table"]
    local return_list = {}

    if custom_watch_table[prototype_name] ~= nil then

        for _, achievement_name in ipairs(custom_watch_table[prototype_name]) do

            if not unlock_table[achievement_name] then
                table.insert(return_list, achievement_name)
            end

        end

    end

    return return_list

end

function unilib.awards.save_player_data()

    -- Called by the timer in ../lib/effects/awards/awards_timer.lua
    -- Serialise the player's progress in vocations and achievements as player attribute data

    for pname, data_table in pairs(unilib.global.awards_player_table) do

        local player = core.get_player_by_name(pname)
        if player then
            unilib.utils.serialise_player_attribute(player, "awards_table", data_table)
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Serialise/deserialise when player joins/player leaves/on shutdown
core.register_on_joinplayer(function(player, last_login)

    local pname = player:get_player_name()
    unilib.global.awards_player_table[pname] =
            unilib.utils.deserialise_player_attribute(player, "awards_table")

    if unilib.global.awards_player_table[pname] == nil or
            unilib.utils.is_table_empty(unilib.global.awards_player_table[pname]) then

        -- Initialise player awards data
        unilib.global.awards_player_table[pname] = {
            level_table = {},
            score_table = {},
            current_table = {},
            unlock_table = {},
            data_table = {},
            monitor_table = {},
            progress_list = {}
        }

    end

    -- This call occurs here, rather than in the usual place in
    --      ../lib/effects/awards/awards_triggers.lua
    -- Otherwise the two core.register_on_joinplayer() functions could be called in the wrong order
    unilib.awards.on_join(player)

end)

core.register_on_leaveplayer(function(player, timed_out)

    local pname = player:get_player_name()
    if unilib.global.awards_player_table[pname] ~= nil then

        unilib.utils.serialise_player_attribute(
            player, "awards_table", unilib.global.awards_player_table[pname]
        )
        unilib.global.awards_player_table[pname] = nil

    end

end)

core.register_on_shutdown(function()
    unilib.awards.save_player_data()
end)
