---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- identify_base.lua
--      Set up the HUD window identifying the pointed-at node. Code adapted from
--          "what_is_this_uwu" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local identify_table = {
    player_table = {},
    player_set_table = {}
}

local char_width_table = {
    A = 12, B = 10, C = 13, D = 12, E = 11, F = 9, G = 13, H = 12, I = 3, J = 9,
    K = 11, L = 9, M = 13, N = 11, O = 13, P = 10, Q = 13, R = 12, S = 10, T = 11,
    U = 11, V = 10, W = 15, X = 11, Y = 11, Z = 10,
    a = 10, b = 8, c = 8, d = 9, e = 9, f = 5, g = 9, h = 9, i = 2, j = 6,
    k = 8, l = 4, m = 13, n = 8, o = 10, p = 8, q = 10, r = 4, s = 8, t = 5,
    u = 8, v = 8, w = 12, x = 8, y = 8, z = 8,
    [" "] = 5,
    ["_"] = 9,
}

-- Standard label colours
local colour_red = 0xff3c0a
local colour_white = 0xffffff
local colour_yellow = 0xd0c526

---------------------------------------------------------------------------------------------------
-- Local functions (originally local)
---------------------------------------------------------------------------------------------------

local function is_strange(str)

    for char in str:gmatch "." do

--        if char == "" then
        if char == string.char(27) then
            return true
        end
    end

    return false

end

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

local function inventorycube(img1, img2, img3)

    if not img1 then
        return ""
    end

    img2 = img2 or img1
    img3 = img3 or img1

    img1 = img1 .. "^[resize:16x16"
    img2 = img2 .. "^[resize:16x16"
    img3 = img3 .. "^[resize:16x16"

    return "[inventorycube" ..
        "{" .. img1:gsub("%^","&") ..
        "{" .. img2:gsub("%^","&") ..
        "{" .. img3:gsub("%^","&")

end

---------------------------------------------------------------------------------------------------
-- Local functions (originally global)
---------------------------------------------------------------------------------------------------

local function destrange(str)

    -- Was what_is_this_uwu.destrange()

    if not unilib.setting.identify_optimise_hud_flag then

        -- Non-optimised code, from "what_is_this_uwu" mod

        local temp_str
        if is_strange(str) then

            local temp_str = ""
            local reading = true
            local is_special = false
            local between_parenthesis = false

            for char in str:gmatch "." do

                -- N.B. Original code does not handle multi-line descriptions
                --[[
                if char == "" then
                    reading = false
                elseif reading and not between_parenthesis then
                    temp_str = temp_str .. char
                else
                    reading = true
                end
                ]]--
                if char == string.char(27) then
                    reading = false
                elseif char == "\n" then
                    return temp_str
                elseif reading and not between_parenthesis then
                    temp_str = temp_str .. char
                else
                    reading = true
                end

                if between_parenthesis then

                    if char == ")" then
                        between_parenthesis = false
                    end

                else

                    if char == "(" then
                        between_parenthesis = true
                    end

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
        if is_strange(str) then
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

local function register_player(player, name)

    -- Was what_is_this_uwu.register_player()

    if not unilib.setting.identify_optimise_hud_flag then

        -- Non-optimised code, from "what_is_this_uwu" mod

        if not identify_table.player_set_table[name] then

            table.insert(identify_table.player_table, player)
            identify_table.player_set_table[name] = true

        end

    else

        -- Code optimised for servers, from "what_is_this_owo" mod

        if not identify_table.player_set_table[name] then
            identify_table.player_set_table[name] = true
        end

    end

end

local function remove_player(name)

    -- Was what_is_this_uwu.remove_player()

    if not unilib.setting.identify_optimise_hud_flag then

        -- Non-optimised code, from "what_is_this_uwu" mod

        if identify_table.player_set_table[name] then

            identify_table.player_set_table[name] = false
            for i, player in ipairs(identify_table.player_table) do

                if player == name then

                    table.remove(identify_table.player_table, i)
                    break

                end

            end

        end

    else

        -- Code optimised for servers, from "what_is_this_owo" mod

        if identify_table.player_set_table[name] then
            identify_table.player_set_table[name] = nil
        end

    end

end

local function get_node_tiles(node_name)

    -- Was what_is_this_uwu.get_node_tiles()

    local node_def_table = core.registered_nodes[node_name]
    local orig_def_table = node_def_table
    if not orig_def_table then
        return "ignore", "node", false
    end

    if not unilib.setting.identify_optimise_hud_flag then

        -- Non-optimised code, from "what_is_this_uwu" mod

        if node_def_table.groups["not_in_creative_inventory"] then

            local drop = node_def_table.drop
            -- N.B. Fix for original code, which shows an "Unknown object" for any node which has
            --      'drop = "" '
--          if drop and type(drop) == "string" then
            if drop and type(drop) == "string" and drop ~= "" then

                node_name = drop
                node_def_table = core.registered_nodes[drop]
                if not node_def_table then
                    node_def_table = core.registered_craftitems[drop]
                end

            end

        end

        if not node_def_table or not node_def_table.tiles and not node_def_table.inventory_image then
            return "ignore", "node", false
        end

        local tiles = node_def_table.tiles
        local mod_name, item_name = unilib.utils.split_name(node_name)

        if node_def_table.inventory_image:sub(1, 14) == "[inventorycube" then

            return node_def_table.inventory_image .. "^[resize:146x146",
                    "node",
                    orig_def_table

        elseif node_def_table.inventory_image ~= "" then

            return node_def_table.inventory_image .. "^[resize:16x16",
                    "craft_item",
                    orig_def_table

        else

            if not tiles[1] then
                return "", "node", orig_def_table
            end

            tiles[3] = tiles[3] or tiles[1]
            tiles[6] = tiles[6] or tiles[3]

            if type(tiles[1]) == "table" then
                tiles[1] = tiles[1].name
            end

            if type(tiles[3]) == "table" then
                tiles[3] = tiles[3].name
            end

            if type(tiles[6]) == "table" then
                tiles[6] = tiles[6].name
            end

            return inventorycube(tiles[1], tiles[6], tiles[3]),
                "node",
                orig_def_table

        end

    else

        -- Code optimised for servers, from "what_is_this_owo" mod

        local tiles = node_def_table.tiles
        local mod_name, item_name = unilib.utils.split_name(node_name)

        if node_def_table.inventory_image:sub(1, 14) == "[inventorycube" then

            return node_def_table.inventory_image .. "^[resize:146x146",
                    "node",
                    orig_def_table

        elseif node_def_table.inventory_image ~= "" then

            return node_def_table.inventory_image.."^[resize:16x16",
                    "craft_item",
                    orig_def_table

        elseif item_name:sub(-2) == "_a" or
                item_name:sub(-2) == "_b" or
                item_name:sub(-2) == "_c" then

            local temp = mod_name .. ":" .. item_name:sub(1, -3)
            local tile_temp = core.registered_craftitems[temp].inventory_image

            return tile_temp.."^[resize:16x16", "craft_item", orig_def_table

        else

            if not tiles[1] then
                return "", "node", orig_def_table
            end

            if not tiles[3] then
                tiles[3] = tiles[1]
            end

            if not tiles[6] then
                tiles[6] = tiles[3]
            end

            if type(tiles[1]) == "table" then
                tiles[1] = tiles[1].name
            end

            if type(tiles[3]) == "table" then
                tiles[3] = tiles[3].name
            end

            if type(tiles[6]) == "table" then
                tiles[6] = tiles[6].name
            end

            return inventorycube(tiles[1], tiles[6], tiles[3]),
                    "node",
                    orig_def_table

        end

    end

end

local function show_background(player)

    -- Was what_is_this_uwu.show_background()

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_left"),
        "text",
        "unilib_hud_identify_left.png"
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_middle"),
        "text",
        "unilib_hud_identify_middle.png"
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_right"),
        "text",
        "unilib_hud_identify_right.png"
    )

end

local function show(player, form_view, node_description, node_name, item_type, mod_name)

    -- Was what_is_this_uwu.show()

    if unilib.utils.get_player_attribute(player, "identify_pointed_thing") == "ignore" then
        show_background(player)
    end

    unilib.utils.set_player_attribute(player, "identify_pointed_thing", node_name)

    -- (Show the unilib package name rather than the mod name, if required)
    if unilib.setting.identify_package_name_flag and
            mod_name == unilib.core.name and
            unilib.global.node_parent_table[node_name] ~= nil then

        mod_name = unilib.global.node_parent_table[node_name]

        -- (Switch to yellow label)
        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_mod"),
            "number",
            colour_yellow
        )

    else

        -- (Restore original red label)
        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_mod"),
            "number",
            colour_red
        )

    end

    local size
    if #node_description >= #mod_name then
        size = string_to_pixels(node_description)
    else
        size = string_to_pixels(mod_name)
    end

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_middle"),
        "scale",
        {x = size / 16 + 2, y = 2}
    )

    if unilib.setting.identify_hud_mode ~= "middle" then

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_background_right"),
            "offset",
            {x = size, y = 35}
        )

    end

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_image"),
        "text",
        form_view
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_name"),
        "text",
        node_description
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_mod"),
        "text",
        mod_name
    )

    if unilib.setting.identify_hud_mode == "middle" then

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_background_left"),
            "offset",
            {x = size / -2 - 25, y = 35}
        )

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_background_middle"),
            "offset",
            {x = size / -2 - 12.5, y = 35}
        )

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_background_right"),
            "offset",
            {x = size / 2 + 25, y = 35}
        )

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_image"),
            "offset",
            {x = size / -2 - 10, y = 35}
        )

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_name"),
            "offset",
            {x = size / -2 + 25, y = 29}
        )

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_mod"),
            "offset",
            {x = size / -2 + 25, y = 46}
        )

    end

    if unilib.utils.get_player_attribute(player, "identify_item_type_in_pointer") ~= item_type then

        local scale = {}

        unilib.utils.set_player_attribute(player, "identify_item_type_in_pointer", item_type)

        if item_type == "node" then

            scale.x = 0.3
            scale.y = 0.3

        else

            scale.x = 2.5
            scale.y = 2.5

        end

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_image"),
            "scale",
            scale
        )

    end

end

local function show_unknown(player, node_name)

    -- Original to unilib, adapted from what_is_this_uwu.show()
    -- Code called when the mouse is pointing at an unknown node

    if unilib.utils.get_player_attribute(player, "identify_pointed_thing") == "ignore" then
        show_background(player)
    end

    unilib.utils.set_player_attribute(player, "identify_pointed_thing", "unknown")

    -- Show a description that matches what the player is seeing (but when we display the mod below,
    --      show its actual name)
    -- (Currently can't translate this string, as it messes up the width)
    local node_description = "Unknown node"
    local size = string_to_pixels(node_description)

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_middle"),
        "scale",
        {x = size / 16 + 2, y = 2}
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_right"),
        "offset",
        {x = size, y = 35}
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_image"),
        "text",
        inventorycube("unknown_node.png", "unknown_node.png", "unknown_node.png")
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_name"),
        "text",
        node_description
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_mod"),
        "text",
        unilib.utils.get_mod_name(node_name)
    )
    -- (Ensure the label is red, in case an earlier call to show() switched it to yellow)
    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_mod"),
        "number",
        colour_red
    )

    if unilib.utils.get_player_attribute(player, "identify_item_type_in_pointer") ~= "node" then

        local scale = {}

        unilib.utils.set_player_attribute(player, "identify_item_type_in_pointer", "node")

        if item_type == "node" then

            scale.x = 0.3
            scale.y = 0.3

        else

            scale.x = 2.5
            scale.y = 2.5

        end

        player:hud_change(
            unilib.utils.get_player_attribute(player, "identify_image"),
            "scale",
            scale
        )

    end

end

local function unshow(player)

    -- Was what_is_this_uwu.unshow()

    unilib.utils.set_player_attribute(player, "identify_pointed_thing", "ignore")

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_left"),
        "text",
        ""
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_middle"),
        "text",
        ""
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_background_right"),
        "text",
        ""
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_image"),
        "text",
        ""
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_name"),
        "text",
        ""
    )

    player:hud_change(
        unilib.utils.get_player_attribute(player, "identify_mod"),
        "text",
        ""
    )

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.identify.toggle_mode(name)

    -- Called from the chat command /what
    -- Enables or disables the HUD

    local player = core.get_player_by_name(name)

    if identify_table.player_set_table[name] then

        unilib.utils.set_player_attribute(player, "identify_enabled", "")

        remove_player(name)
        unshow(player)

        -- (When the HUD is only visible after punching, the confirm the change in the chat window;
        --      otherwise, don't bother)
        if unilib.setting.identify_optimise_hud_flag then
            return S("HUD disabled, punch an item to identify it")
        end

    else

        unilib.utils.set_player_attribute(player, "identify_enabled", "true")

        register_player(player, name)

        if unilib.setting.identify_optimise_hud_flag then
            return S("HUD enabled")
        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

core.register_on_joinplayer(function(player)

    local posn_table = {x = 0.5, y = 0}
    if unilib.setting.identify_hud_mode == "corner" then
        posn_table = {x = 0.06, y = 0}
    end

    local background_id_left = player:hud_add({
        type = "image",
        position = posn_table,
        scale = {x = 2, y = 2},
        text = "",
        offset = {x = -50, y = 35},
    })

    local background_id_middle = player:hud_add({
        type = "image",
        position = posn_table,
        scale = {x = 2, y = 2},
        text = "",
        alignment = {x = 1},
        offset = {x = -37.5, y = 35},
    })

    local background_id_right = player:hud_add({
        type = "image",
        position = posn_table,
        scale = {x = 2, y = 2},
        text = "",
        offset = {x = 0, y = 35},
    })

    local image_id = player:hud_add({
        type = "image",
        position = posn_table,
        scale = {x = 0.3, y = 0.3},
        offset = {x = -35, y = 35},
    })

    local name_id = player:hud_add({
        type = "text",
        position = posn_table,
        scale = {x = 0.3, y = 0.3},
        number = colour_white,
        alignment = {x = 1},
        offset = {x = 0, y = 29},
    })

    local mod_id = player:hud_add({
        type = "text",
        position = posn_table,
        scale = {x = 0.3, y = 0.3},
        number = colour_red,
        alignment = {x = 1},
        offset = {x = 0, y = 46},
    })

    unilib.utils.set_player_attribute(player, "identify_background_left", background_id_left)
    unilib.utils.set_player_attribute(player, "identify_background_middle", background_id_middle)
    unilib.utils.set_player_attribute(player, "identify_background_right", background_id_right)
    unilib.utils.set_player_attribute(player, "identify_image", image_id)
    unilib.utils.set_player_attribute(player, "identify_name", name_id)
    unilib.utils.set_player_attribute(player, "identify_mod", mod_id)
    unilib.utils.set_player_attribute(player, "identify_pointed_thing", "ignore")
    unilib.utils.set_player_attribute(player, "identify_item_type_in_pointer", "node")

    -- N.B. Change to original code: the HUD is not necessarily visible on connection
    if unilib.utils.get_player_attribute(player, "identify_enabled") == "true" then
        register_player(player, player:get_player_name())
    end

end)

core.register_on_leaveplayer(function(player)
    remove_player(player, player:get_player_name())
end)

if not unilib.setting.identify_optimise_hud_flag then

    -- Non-optimised code, from "what_is_this_uwu" mod
    core.register_globalstep(function()

        for _, player in ipairs(identify_table.player_table) do

            local node
            if identify_table.player_set_table[player:get_player_name()] then
                node = unilib.utils.get_pointed_node(player)
            end

            if node then

                local node_name = node.name
                if unilib.utils.get_player_attribute(player, "identify_pointed_thing") ~=
                        node_name then

                    local form_view, item_type, def_table = get_node_tiles(node_name)
                    -- N.B. "def_table" might be nil or false, as well as a table
                    if not def_table then

                        show_unknown(player, node_name)
                        return

                    end

                    local node_description = destrange(def_table.description)
                    local mod_name = unilib.utils.get_mod_name(node_name)
                    show(player, form_view, node_description, node_name, item_type, mod_name)

                end

            else

                unshow(player)

            end

        end

    end)

else

    -- Code optimised for servers, from "what_is_this_owo" mod
    core.register_on_punchnode(function(pos, node, player, pointed_thing)

        if identify_table.player_set_table[player:get_player_name()] then

            local node_name = node.name
            if unilib.utils.get_player_attribute(player, "identify_pointed_thing") ~= node_name then

                local form_view, item_type, def_table = get_node_tiles(node_name)
                -- N.B. "def_table" might be nil or false, as well as a table
                if not def_table then

                    show_unknown(player, node_name)
                    return

                end

                local node_description = destrange(def_table.description)
                local mod_name = unilib.utils.get_mod_name(node_name)

                show(player, form_view, node_description, node_name, item_type, mod_name)

            else

                unshow(player)

            end

        end

    end)

end
