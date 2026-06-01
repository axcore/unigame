---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- announce_base.lua
--      Set up the HUD window for making announcements. Code adapted from the
--          "what_is_this_uwu"/"what_is_this_owo" mods, but includes a lot of original code
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of players and the HUD element IDs created for them, in the form
--      hud_id_table[pname] = data_table
-- ...where "data_table" is in the form
--      data_table[element_name] = element_id
local hud_id_table = {}

-- Tables of (queued) "long" announcements
-- When a long announcement is generated via a call to unilib.announce.add_long_announcement(), it
--      is added to the queue for the specified player
-- Whenever that queue is not empty, the first announcement in the queue is made visible, and
--      auto-removed some time later, at which time the next long announcement in the queue (if any)
--      is made visible
-- Table in the form
--      long_queue_table[pname] = long_queue_list
-- ...where "long_queue_list" is a list of mini-tables (one for each announcement) in the form
--      category (str): [compulsory] Any string; identifies the code that generated the announcement
--      hud_mode (str): If specified, overrides the value of unilib.setting.announce_hud_mode; valid
--          values are "corner", "middle" and "fixed"
--      border_colour (str): A limited number of border colours are available (by default, "red",
--          "orange", "yellow", "violet"); if none of those values are specified, "red" is used by
--          default
--      img (str): Either a texture filename (e.g. "unilib_dirt_ordinary.png" or a formspec portion
--          in the form "inventorycube[...]"
--      img_scale (float): A value used to set the size of the visible image, taking into account
--          the size of the texture itself. If not specified, the value for ordinary 16x16 images
--          (.img_scale = 2.4) is used
--      sound (str): If specified, the sound to play when the announcement becomes visible
--      text_top (str): Text to show in the top label; if not specified, no text is shown
--      text_top_colour (str): Hex colour for the top label; if not specified, a default colour is
--          used
--      text_bottom (str): Text to show in the bottom label; if not specified, no text is shown
--      text_bottom_colour (str): Hex colour for the bottom label; if not specified, a default
--          colour is used
--      interval (int): Length of the announcement, in seconds. If not specified, a default interval
--          is used
local long_queue_table = {}
-- Table of times (matches core.get_gametime() ) at which the currently-visible long announcement
--      expires
-- Table in the form
--      long_expire_table[pname] = expire_time
local long_expire_table = {}
-- Timer to handle long announcement expiry times
local long_timer = 0
local long_timer_tick = 1

-- Table of (queued) "short" announcements
-- When a short announcement is generated via a call to unilib.announce.add_short_announcement(), it
--      is ignored if the long queue for the specified player is not empty
-- Otherwise, it is added to the short queue for the specified player, replacing any short
--      announcement that is already there (the maximum queue length is 1), and is made visibile
--      immediately, remaining visible until the next call to .add_long_announcement(),
--      .announce.add_short_announcement() or .announce.remove_short_announcement()
-- Table in the form
--      short_queue_table[pname] = short_queue_list
-- ...where "short_queue_list" is a list of mini-tables (one for each announcement) in the same
--      form as described above, except that .interval (if specified) is ignored
local short_queue_table = {}

-- Need to define the width of each character, so we can set the size of visible HUD
local char_width_table = {
    A = 12, B = 10, C = 13, D = 12, E = 11, F = 9, G = 13, H = 12, I = 3, J = 9,
    K = 11, L = 9, M = 13, N = 11, O = 13, P = 10, Q = 13, R = 12, S = 10, T = 11,
    U = 11, V = 10, W = 15, X = 11, Y = 11, Z = 10,
    a = 10, b = 8, c = 8, d = 9, e = 9, f = 5, g = 9, h = 9, i = 2, j = 6,
    k = 8, l = 4, m = 13, n = 8, o = 10, p = 8, q = 10, r = 4, s = 8, t = 5,
    u = 8, v = 8, w = 12, x = 8, y = 8, z = 8,
    [" "] = 5,
    ["_"] = 9,
    -- (Not in original code, but reasonable)
    ["("] = 5,
    [")"] = 5,
    ["["] = 5,
    ["]"] = 5,
    [":"] = 5,
    [","] = 5,
    ["."] = 5,
}

-- Default values for announcements that don't specify them
local default_img_scale = 2.4           -- Assumes a 16x16 texture
local default_top_colour = 0xffffff     -- white
local default_bottom_colour = 0xff3c0a  -- red
local default_interval = 5

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function string_to_pixels(str)

    local size = 0

    str:gsub(".", function(char)

        local pixels = char_width_table[char]

        if pixels then
            size = size + pixels
        else
            size = size + 14
        end

    end)

    return size

end

local function does_string_contain_escape(str)

    for char in str:gmatch "." do

--      if char == "" then
        if char == string.char(27) then
            return true
        end
    end

    return false

end

local function make_string_displayable(str)

    -- N.B. Original code (in both source mods) does not correctly handle multi-line descriptions
    str = unilib.utils.get_first_line(str)

    -- De-strange the specified string
    if not unilib.setting.announce_optimise_flag then

        -- Non-optimised code, from "what_is_this_uwu" mod

        local temp_str
        if does_string_contain_escape(str) then

            local temp_str = ""
            local reading_flag = true
            local brackets_flag = false

            --[[
            for char in str:gmatch "." do

                if char == "" then
                    reading_flag = false
                elseif reading_flag and not brackets_flag then
                    temp_str = temp_str .. char
                else
                    reading_flag = true
                end

                if brackets_flag then

                    if char == ")" then
                        brackets_flag = false
                    end

                else

                    if char == "(" then
                        brackets_flag = true
                    end

                end

            end
            ]]--
            for char in str:gmatch "." do

                -- Must remove "ESC(aaa)" sequences, as well as "ESCb" sequences (where aaa is any
                --      number of characters, and b is a single character)
                if char == "" then

                    reading_flag = false

                elseif not reading_flag then

                    if char == "(" then

                        brackets_flag = true

                    elseif char == ")" then

                        brackets_flag = false
                        reading_flag = true

                    elseif not brackets_flag then

                        reading_flag = true

                    end

                else

                    temp_str = temp_str .. char

                end

            end

            return temp_str

        else

            return str

        end

    else

        -- Code optimised for servers, from "what_is_this_owo" mod

        local ignore_flag = true

        local temp_str
        if does_string_contain_escape(str) then
            temp_str = str:sub(2, #str - 2)
        else
            return str
        end

        str = ""
        temp_str:gsub(".", function(char)

            if not ignore_flag then
                str = str..char
            end

            if char == ")" then
                ignore_flag = false
            end

        end)

        return str

    end

end

local function register_hud(player)

    -- Sanity check
    local pname = player:get_player_name()
    if hud_id_table[pname] ~= nil then
        return
    end

    -- Set the position of the announcement HUD, depending on settings
    local posn_table
    if unilib.setting.announce_hud_mode == "corner" then
        posn_table = {x = 0.06, y = 0}
    else
        posn_table = {x = 0.5, y = 0}
    end

    -- The announcement HUD is made up of 6 elements; create them for the new player
    local id_table = {}
    id_table.bg_left = player:hud_add({
        name = "unilib:hud_effects_announce_1",
        type = "image",

        offset = {x = -50, y = 35},
        position = posn_table,
        scale = {x = 2, y = 2},
        text = "",
    })

    id_table.bg_middle = player:hud_add({
        name = "unilib:hud_effects_announce_2",
        type = "image",

        alignment = {x = 1, y = 0},
        offset = {x = -37.5, y = 35},
        position = posn_table,
        scale = {x = 2, y = 2},
        text = "",
    })

    id_table.bg_right = player:hud_add({
        name = "unilib:hud_effects_announce_3",
        type = "image",

        offset = {x = 0, y = 35},
        position = posn_table,
        scale = {x = 2, y = 2},
        text = "",
    })

    id_table.img = player:hud_add({
        name = "unilib:hud_effects_announce_4",
        type = "image",

        offset = {x = -35, y = 35},
        position = posn_table,
        scale = {x = 0.3, y = 0.3},
    })

    id_table.text_top = player:hud_add({
        name = "unilib:hud_effects_announce_5",
        type = "text",

        alignment = {x = 1, y = 0},
        number = default_top_colour,
        offset = {x = 0, y = 29},
        position = posn_table,
        scale = {x = 0.3, y = 0.3},
    })

    id_table.text_bottom = player:hud_add({
        name = "unilib:hud_effects_announce_6",
        type = "text",

        alignment = {x = 1, y = 0},
        number = default_bottom_colour,
        offset = {x = 0, y = 46},
        position = posn_table,
        scale = {x = 0.3, y = 0.3},
    })

    -- Store IDs for the HUD elements
    hud_id_table[pname] = id_table

end

local function unregister_hud(player)

    local pname = player:get_player_name()
    hud_id_table[pname] = nil

end

local function register_player(pname)

    -- Sanity check
    if long_queue_table[pname] ~= nil then
        return
    end

    -- Initialise queues
    long_queue_table[pname] = {}
    short_queue_table[pname] = {}

end

local function unregister_player(pname)

    long_queue_table[pname] = nil
    short_queue_table[pname] = nil

end

local function show_next_announcement(pname)

    -- Get the data_table representing the next announcement to show
    local data_table = long_queue_table[pname][1]
    if data_table == nil then
        data_table = short_queue_table[pname][1]
    end

    if data_table == nil then
        return
    end

    -- Set the actual announcement data to use, using default values if none are specified
    local announce_table = {}
    announce_table.category = data_table.category
    announce_table.hud_mode = data_table.hud_mode or unilib.setting.announce_hud_mode
    announce_table.border_colour = data_table.border_colour or "red"
    announce_table.img = data_table.img or ""
    announce_table.img_scale = data_table.img_scale or default_img_scale
    announce_table.sound = data_table.sound or nil
    announce_table.text_top = make_string_displayable(data_table.text_top) or ""
    announce_table.text_top_colour = data_table.text_top_colour or default_top_colour
    announce_table.text_bottom = make_string_displayable(data_table.text_bottom) or ""
    announce_table.text_bottom_colour = data_table.text_bottom_colour or default_bottom_colour
    announce_table.interval = data_table.interval or default_interval

    -- Set the overall size
    local size
    if #announce_table.text_top >= #announce_table.text_bottom then
        size = string_to_pixels(announce_table.text_top)
    else
        size = string_to_pixels(announce_table.text_bottom)
    end

    -- Update HUD elements, making the announcement visible
    local player = core.get_player_by_name(pname)

    -- .bg_left
    player:hud_change(
        hud_id_table[pname]["bg_left"],
        "text",
        "unilib_hud_announce_" .. announce_table.border_colour .. "_left.png"
    )

    if announce_table.hud_mode == "middle" then

        player:hud_change(
            hud_id_table[pname]["bg_left"],
            "offset",
            {x = ((size / -2) - 25), y = 35}
        )

    else

        player:hud_change(
            hud_id_table[pname]["bg_left"],
            "offset",
            {x = -50, y = 35}
        )

    end

    -- .bg_middle
    player:hud_change(
        hud_id_table[pname]["bg_middle"],
        "text",
        "unilib_hud_announce_" .. announce_table.border_colour .. "_middle.png"
    )

    player:hud_change(
        hud_id_table[pname]["bg_middle"],
        "scale",
        {x = ((size / 16) + 2), y = 2}
    )

    if announce_table.hud_mode == "middle" then

        player:hud_change(
            hud_id_table[pname]["bg_middle"],
            "offset",
            {x = ((size / -2) - 12.5), y = 35}
        )

    else

        player:hud_change(
            hud_id_table[pname]["bg_middle"],
            "offset",
            {x = -37.5, y = 35}
        )

    end

    -- .bg_right
    player:hud_change(
        hud_id_table[pname]["bg_right"],
        "text",
        "unilib_hud_announce_" .. announce_table.border_colour .. "_right.png"
    )

    if announce_table.hud_mode == "middle" then

        player:hud_change(
            hud_id_table[pname]["bg_right"],
            "offset",
            {x = ((size / 2) + 25), y = 35}
        )

    else

        player:hud_change(
            hud_id_table[pname]["bg_right"],
            "offset",
            {x = size, y = 35}
        )

    end

    -- .img
    player:hud_change(
        hud_id_table[pname]["img"],
        "text",
        announce_table.img
    )

    player:hud_change(
        hud_id_table[pname]["img"],
        "scale",
        {x = announce_table.img_scale, y = announce_table.img_scale}
    )

    if announce_table.hud_mode == "middle" then

        player:hud_change(
            hud_id_table[pname]["img"],
            "offset",
            {x = ((size / -2) - 10), y = 35}
        )

    else

        player:hud_change(
            hud_id_table[pname]["img"],
            "offset",
            {x = -35, y = 35}
        )

    end

    -- .text_top
    player:hud_change(
        hud_id_table[pname]["text_top"],
        "text",
        announce_table.text_top
    )

    player:hud_change(
        hud_id_table[pname]["text_top"],
        "number",
        announce_table.text_top_colour
    )

    if announce_table.hud_mode == "middle" then

        player:hud_change(
            hud_id_table[pname]["text_top"],
            "offset",
            {x = ((size / -2) + 25), y = 29}
        )

    else

        player:hud_change(
            hud_id_table[pname]["text_top"],
            "offset",
            {x = 0, y = 29}
        )

    end

    -- .text_bottom
    player:hud_change(
        hud_id_table[pname]["text_bottom"],
        "text",
        announce_table.text_bottom
    )

    player:hud_change(
        hud_id_table[pname]["text_bottom"],
        "number",
        announce_table.text_bottom_colour
    )

    if announce_table.hud_mode == "middle" then

        player:hud_change(
            hud_id_table[pname]["text_bottom"],
            "offset",
            {x = ((size / -2) + 25), y = 46}
        )

    else

        player:hud_change(
            hud_id_table[pname]["text_bottom"],
            "offset",
            {x = 0, y = 46}
        )

    end

    -- Set the expiry time for "long" announcements
    if #long_queue_table[pname] > 0 then
        long_expire_table[pname] = core.get_gametime() + announce_table.interval
    end

    -- Play a sound effect, if specified
    if announce_table.sound then
        core.sound_play(announce_table.sound, {to_player = pname, gain = 1.0})
    end

end

local function remove_current_announcement(pname)

    local player = core.get_player_by_name(pname)

    for _, element in ipairs(
        {"bg_left", "bg_middle", "bg_right", "img", "text_top", "text_bottom"}
    ) do
        player:hud_change(hud_id_table[pname][element], "text", "")
    end

    -- Reset the expiry time for "long" announcements, if applicable
    long_expire_table[pname] = nil

end

local function do_loop()

    -- Loop, running once a second, to remove the currently-visible "long" announcement for every
    --      player, displaying the next one in the queue (if applicable)

    for pname, _ in pairs(long_queue_table) do

        if long_expire_table[pname] ~= nil and long_expire_table[pname] < core.get_gametime() then

            remove_current_announcement(pname)

            table.remove(long_queue_table[pname], 1)
            long_expire_table[pname] = nil

            if #long_queue_table[pname] > 0 then
                show_next_announcement(pname)
            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.announce.add_long_announcement(pname, data_table)

    -- Add a "long" announcement to the queue, displaying it immediately if the queue was empty

    -- Check the compulsory field
    if data_table == nil or data_table.category == nil then

        return unilib.utils.show_warning(
            "unilib.announce.add_long_announcement(): Missing compulsory fields in data table"
        )

    end

    -- Add the announcement to the queue, first checking that queues are initialised
    register_player(pname)
    table.insert(long_queue_table[pname], data_table)

    -- Show the announcement immediately, if the player's HUD has been initialised (otherwise it's
    --      shown in the call to core.register_on_joinplayer() )
    if #long_queue_table[pname] == 1 and hud_id_table[pname] ~= nil then
        show_next_announcement(pname)
    end

end

function unilib.announce.add_short_announcement(pname, data_table)

    -- Add a "short" announcement to the "queue" (which has a maximum length of 1, so any previous
    --      announcement is replaced)

    -- Check the compulsory field
    if data_table == nil or data_table.category == nil then

        return unilib.utils.show_warning(
            "unilib.announce.add_short_announcement(): Missing compulsory fields in data table"
        )

    end

    -- Check that queues are initialised
    register_player(pname)

    -- Ignore the short announcement, if a long announcement is already visible
    if #long_queue_table[pname] > 0 then
        return
    end

    -- Add the announcement to the queue; as the maximum queue length is 1, it displaces any
    --      announcement already in the queue
    short_queue_table[pname] = {data_table}

    -- Show the announcement immediately, if the player's HUD has been initialised (otherwise it's
    --      shown in the call to core.register_on_joinplayer() )
    if hud_id_table[pname] ~= nil then
        show_next_announcement(pname)
    end

end

function unilib.announce.remove_short_announcement(pname, category)

    -- Removes the "short" announcement from the queue, also removing it from view
    -- "category" is optional; if specified, it only removes the "short" announcement if it matches

    -- Check that queues are initialised
    register_player(pname)

    -- Check there's a short announcment to remove
    if #long_queue_table[pname] > 0 or #short_queue_table[pname] == 0 then
        return
    end

    -- Check "category", if specified
    if category ~= nil then

        local data_table = short_queue_table[pname][1]
        if data_table.category ~= category then
            return
        end

    end

    -- Remove the announcement from the queue
    short_queue_table[pname] = {}

    -- Reset any visible announcement, if the player's HUD has been initialised
    if hud_id_table[pname] ~= nil then
        remove_current_announcement(pname)
    end

end

function unilib.announce.is_long_announcement_visible(pname)

    -- Can be called by any code that wants to register "short" announcements (which are ignored
    --      when the long announcement queue is not empty)

    if #long_queue_table[pname] > 0 then
        return true
    else
        return false
    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

core.register_on_joinplayer(function(player)

    local pname = player:get_player_name()
    register_hud(player)
    register_player(pname)

    -- If the first announcement is waiting to be shown, then show it
    if #long_queue_table[pname] > 0 or #short_queue_table[pname] > 0 then
        show_next_announcement(pname)
    end

end)

core.register_on_leaveplayer(function(player)

    unregister_hud(player)
    unregister_player(player:get_player_name())

end)

core.register_globalstep(function(dtime)

    long_timer = long_timer + dtime
    if long_timer >= long_timer_tick then

        do_loop()
        long_timer = 0

    end

end)
