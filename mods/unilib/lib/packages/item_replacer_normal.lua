---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    replacer
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_replacer_normal = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.replacer.add_mode

-- Default replacement node; in the original code, "default:dirt". If you change this to a non-dirt
--      node, then use as an empty string for the turf node
local default_node = "unilib:dirt_ordinary"
local default_turf_node = "unilib:dirt_ordinary_with_turf"
-- A string with that node, plus param1/param2 values (so successive placed nodes have the same
--      orientation)
local default_pattern = "unilib:dirt_ordinary 0 0"

-- How many patterns are allowed in the history
-- (They don't take up much space, but a long list would not be helpful for the player)
max_hist_size = 20

-- A history of stored replacement patterns, viewable in the formspec. Keys are player names. See
--      the comments and code in update_history()
history_table = {}

-- Store which mode each user has selected
user_mode_table = {}

-- Descriptions for the dropdown menu (accessible via AUX1 + left-click)
mode_description_list = {
    "[ " .. S("normal") .. " ] ..." ..
            S("replace material, shape and orientation according to the stored pattern"),
    "[ " .. S("material") .. " ] ..." ..
            S("replace the material only (if possible), while keeping shape and orientation"),
    "[ " .. S("shape") .. " ] ..." ..
            S("replace shape and orientation (if possible), while keeping the material"),
}

-- Internal names for the above modes, stored in user_mode_table[player_name]
mode_name_list = {"normal", "material", "shape"}

-- Node names for one or two materials from minetest_game do not follow the pattern of node names
--      for that type; offer a way to translate them here
alt_name_table = {}
alt_name_table["default:mese_post_light_wood"] = "default:mese_post_light"
alt_name_table["walls:desert_cobble"] = "walls:desertcobble"

-- Support for the circular saw from moreblocks
-- This table contains prefixes as indices plus a list of known suffixes for that prefix. The table
--      is populated below
-- Keys are a prefix, e.g. "stair_", "slab_"; the corresponding value is a list of suffixes, e.g.
--      { "_outer", "_inner", ... }
saw_prefix_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions (original to unilib)
---------------------------------------------------------------------------------------------------

local function convert_turf_to_dirt(turf_name)

    -- e.g. Converts "unilib:dirt_ordinary_with_turf" to "unilib:dirt_ordinary"
    -- Should work with non-unilib dirts, specifically anything in the .spreading_dirt_type group;
    --      returns the .drop node

    local def_table = core.registered_nodes[turf_name]
    if def_table ~= nil and def_table.groups ~= nil and
            def_table.groups.spreading_dirt_type == 1 and
            def_table.drop ~= nil and type(def_table.drop) == "string" then

        return def_table.drop

    else

        return nil

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (from replacer/fs_history.lua)
---------------------------------------------------------------------------------------------------

local function get_human_readable_pattern(pattern)

    -- Was replacer.human_readable_pattern()
    -- Turns the stored pattern string (<node_name> <param1> <param2>) into something readable by
    --      humans

    if not pattern then
        return "(nothing)"
    end

    -- Data is stored in the form "<nodename> <param1> <param2>"
    local part_list = string.split(pattern, " ")
    if not part_list or #part_list < 3 then
        return "(corrupted data)"
    end

    local node_name = part_list[1]
    local param2 = part_list[3]
    local def_table = core.registered_nodes[node_name]
    if def_table == nil then
        return "(unknown node)"
    end

    local text = "\"" .. tostring(def_table.description or "- no description -") .. "\""
    if not def_table.description or def_table.description == "" then
        text = "- no description -"
    end

    -- facedir is probably the most commonly used rotation variant
    if def_table.paramtype2 == "facedir" or def_table.paramtype2 == "colorfacedir" then

        local axis_name_list = {
            "y+ (Ground)",
            "z+ (North)",
            "z- (South)",
            "x+ (East)",
            "x- (West)",
            "y- (Sky)",
        }

        text = text .. " Rotated: " .. tostring(param2 % 4) .. " around axis: " ..
                tostring(axis_name_list[math.floor((param2 % 24) / 4) + 1])

        -- Wallmounted is different
    elseif def_table.paramtype2 == "wallmounted" or def_table.paramtype2 == "colorwallmounted" then

        local axis_name_list = {
            "y+ (Ground)",
            "y- (Sky)",
            "z+ (North)",
            "z- (South)",
            "x+ (East)",
            "x- (West)",
        }

        text = text .. " Mounted at wall: " .. tostring(axis_name_list[(param2 % 6) + 1])

    end

    return text

end

local function update_history(player_name, pattern)

    -- Was replacer.add_to_hist()
    -- Keep a history of stored patterns for each player (not for each replacer)
    -- This history is not saved between server shutdowns

    if not player_name or not pattern or pattern == "" then
        return
    end

    if not history_table[player_name] then
        history_table[player_name] = {}
    end

    local index = table.indexof(history_table[player_name], pattern)
    -- Only add new entries; do not store duplicates
    if index and index > -1 then
        return
    end

    -- Remove the oldest entry
    if #history_table[player_name] >= max_hist_size then
        table.remove(history_table[player_name], 1)
    end

    table.insert(history_table[player_name], pattern)

end

local function set_new_pattern(player_name, pattern, player, itemstack)

    -- Was replacer.set_to()
    -- Set the replacer to a new pattern

    if not player_name or not player or not itemstack then
        return itemstack
    end

    -- Fallback if nothing is given
    if not pattern then
        pattern = default_pattern
    end

    local new_pattern = get_human_readable_pattern(pattern)
    -- Change the description of the tool so that it's easier to see which replacer is set to which
    --      node
    local meta = itemstack:get_meta()
    -- Actually store the new pattern
    meta:set_string("pattern", pattern)
    meta:set_string(
        "description",
        S("Node replacement tool set to") .. ":\n" .. new_pattern .. "\n[" ..
                tostring(pattern) .. "]"
    )

    core.chat_send_player(
        player_name,
        S("Node replacement tool set to") .. ": " .. new_pattern .. " ["..tostring(pattern).."]"
    )

    update_history(player_name, pattern)

    -- Nothing consumed but data changed
    return itemstack

end

local function get_formspec(player_name, current_pattern, player)

    -- Was replacer.get_formspec()
    -- Shows a formspec with a history of stored patterns to select from (accessible with
    --      AUX1 + left click)

    -- Is the player in creative mode?
    --[[
    local in_creative_mode = core.settings:get_bool("creative_mode") or
                core.check_player_privs(player_name, {creative = true})
    ]]--
    local in_creative_mode = unilib.utils.is_creative(player_name)

    -- Count how many blocks of each type the player has in his inventory
    local counted_inv = {}
    if not in_creative_mode then

        local inv_main = player:get_inventory():get_list("main")
        for i, v in ipairs(inv_main) do

            local stack_name = v:get_name()
            if not counted_inv[stack_name] then
                counted_inv[stack_name] = 0
            end

            counted_inv[stack_name] = counted_inv[stack_name] + v:get_count()

        end

    end

    -- Find out which mode the player has currently selected
    local current_mode = 1
    if user_mode_table and user_mode_table[player_name] then

        current_mode = table.indexof(mode_name_list, user_mode_table[player_name])
        if current_mode == -1 then
            current_mode = 1
        end

    end

    -- N.B. Original formspec tweaked for aesthetics and legibility
    --[[
    local formspec = "size[18,10]" ..
        "label[6,0;Node Replacement Tool Setup and History]" ..
        "button_exit[8,9.4;2,0.8;quit;Exit]" ..
        "label[0.2,8.5;Note: Selected mode and history are reset on server restart.\n" ..
                "Note: The selected mode is valid for *all* replacers you use. " ..
                "The stored pattern is valid for *this particular* replacer only.]" ..
        "label[0.2,0.6;Select mode: When replacing (punching, left-click) or " ..
                "placing (right-click) a block...]" ..
        "dropdown[0.2,1.0;17;select_mode;" ..
                table.concat(mode_description_list, ",") ..
                ";" .. tostring(current_mode) .. ";]" ..
        "label[0.2,2.1;Click here to set the replacer to a pattern you have stored before:]" ..
        "tablecolumns[color;" ..
                "text,align=right,tooltip=Amount of nodes of this type left in your inventory:" ..
                ";color;text,align=left,tooltip=Stored pattern:]" ..
        "table[0.2,2.5;17,6;replacer_history;"
    ]]--
    local formspec = "size[18,10]" ..
        "label[6,0;" .. FS("Node Replacement Tool Setup and History") .. "]" ..
        "button_exit[8,9.4;2,0.8;quit;Exit]" ..
        "label[0.2,8.3;" .. FS(
            "Note: The selected mode and pattern history are reset when the server restarts." ..
                    "\nNote: The selected mode is valid for all replacement tools you use. The" ..
                    " pattern history is valid for this tool only."
        ) .. "]" ..
        "label[0.2,0.6;" .. FS(
            "Select mode: When replacing (punching, left-click) or placing (right-click) a" ..
                    " block..."
        ) .. "]" ..
        "dropdown[0.2,1.1;18;select_mode;" ..
                F(table.concat(mode_description_list, ",")) ..
                ";" .. F(tostring(current_mode)) .. ";]" ..
        "label[0.2,2.1;" .. FS(
            "History: Click here to set the tool to a pattern you have used before"
        ) .. ":]" ..
        "tablecolumns[color;" ..
                "text,align=right,tooltip=" .. FS(
                    "Amount of nodes of this type left in your inventory"
                ) .. ":;color;text,align=left,tooltip=" .. FS("Stored pattern") .. ":]" ..
        "table[0.2,2.6;17,5.5;replacer_history;"

    -- Make sure all variables exist and the current entry is stored
    update_history(player_name, current_pattern)

    local hist_entry_table = {}
    local selected = 1
    for i, v in ipairs(history_table[player_name]) do

        if v == current_pattern then
            selected = i
        end

        local amount_left = "#00FF00," .. FS("infinite supply") .. ":,#00FF00"
        if not in_creative_mode then

            -- Which item are we looking for?
            local part_list = v:split(" ")
            if not part_list or #part_list < 1 then

                part_list = {S("does not exist")}

            --[[
            elseif part_list[1] == default_turf_node then

                part_list[1] = default_node

            end
            ]]--

            else

                local dirt_name = convert_turf_to_dirt(part_list[1])
                if dirt_name ~= nil then
                    part_list[1] = dirt_name
                end

            end

            if counted_inv[part_list[1]] then

                amount_left = "#00FF00," .. tostring(counted_inv[part_list[1]]) ..
                        " " .. S("available") .. ":,#00FF00"

            else

                amount_left = "#FF0000," .. S("none left!") .. ",#CFCFCF"

            end

        end

        hist_entry_table[i] = tostring(amount_left) .. "," .. F(get_human_readable_pattern(v) ..
                " [" .. v .. "]")

    end

    return formspec .. table.concat(hist_entry_table, ",") .. ";" .. tostring(selected) .. "]"

end

---------------------------------------------------------------------------------------------------
-- Local functions (from replacer/mode_of_replacement.lua)
---------------------------------------------------------------------------------------------------

local function identify_shape_and_material(full_name)

    -- Was replacer.identify_shape_and_material()
    -- Does "full_name" match any name from the circular saw from moreblocks, or the technic CNC
    --      machine? Does it match one of a number of minetest_game nodes which are not blocks,
    --      like walls and stairs?
    -- If so, what material is it?
    --
    -- Returns a list in the form
    --      {created_by_machine, source node name, mod_name, prefix, material, suffix}
    -- ...for which the last four, when combined as a string, form the full name of the node
    -- The list can be used to replace a node's material or shape, if replacing just one or the
    --      other has been selected in the formspec

    local part_list = full_name:split(":")
    if not part_list or #part_list < 2 then
        return nil
    end

    local mod_name = part_list[1]
    local item_name = part_list[2]
    -- It might be a full block - or any other drawtype not specifically covered in the code below
    local def_table = core.registered_nodes[full_name]
    if def_table and def_table.drawtype and def_table.drawtype == "normal" then
        return {"normal", full_name, mod_name, "", item_name, ""}
    end

    -- minetest_game items (and their unilib equivalents)

    -- A wooden fence rail, e.g. "default:fence_rail_wood" /
    --      "unilib:tree_apple_wood_fence_rail"
    local prefix = "fence_rail_"
    local suffix = "_fence_rail"
    if mod_name == "default" and item_name:sub(1, #prefix) == prefix then

        local material = item_name:sub(#prefix + 1)
        return {"fence_rail", "default:" .. material, "default", prefix, material, ""}

    elseif mod_name == "unilib" and item_name:sub(-#suffix) == suffix then

        local material = item_name:sub(1, #item_name - #suffix)
        return {"fence_rail", "unilib:" .. material, "unilib", "", material, suffix}

    end

    -- A wooden fence, e.g. "default:fence_wood" / "unilib:tree_apple_wood_fence"
    prefix = "fence_"
    suffix = "_fence"
    if mod_name == "default" and item_name:sub(1, #prefix) == prefix then

        local material = item_name:sub(#prefix + 1)
        return {"fence", "default:" .. material, "unilib", prefix, material, ""}

    elseif mod_name == "unilib" and item_name:sub(-#suffix) == suffix then

        local material = item_name:sub(1, #item_name - #suffix)
        return {"fence", "unilib:" .. material, "unilib", "", material, suffix}

    end

    -- A wooden gate, e.g. "doors:gate_wood_closed", "doors:gate_wood_open" /
    --      "unilib:gate_apple_closed", "unilib:gate_apple_open"
    prefix = "gate_"
    if (mod_name == "doors" or mod_name == "unilib") and item_name:sub(1, #prefix) == prefix then

        local gate_suffixes = {"_open", "_closed"}
        for i, suffix in ipairs(gate_suffixes) do

            if item_name:sub(-#suffix) == suffix then

                local material = item_name:sub(#prefix + 1, -#suffix - 1)
                if mod_name == "doors" then

                    return {"gate", "default:" .. material, "doors", prefix, material, suffix}

                else

                    return {
                        "gate",
                        "unilib:tree_" .. material .. "_wood",
                        "unilib",
                        prefix,
                        material,
                        suffix,
                    }

                end

            end

        end

    end

    -- A mese post, e.g. "default:mese_post_light", "default:mese_post_light_aspen_wood" /
    --      "unilib:light_post_mese_apple", "unilib:light_post_mese_aspen"
    -- A mithril post, e.g. "unilib:light_post_mithril_apple", "unilib:light_post_mithril_aspen"
    prefix = "mese_post_light_"
    local mese_prefix = "light_post_mese"
    local mithril_prefix = "light_post_mithril"
    if full_name == "default:mese_post_light" then

        return {"mese_post", "default:wood", "default", "mese_post_light_", "", ""}

    elseif mod_name == "default" and item_name:sub(1, #prefix) == prefix then

        local material = item_name:sub(#prefix + 1)
        return {"mese_post", "default:" .. material, "default", prefix, material, ""}

    elseif mod_name == "unilib" and item_name:sub(1, #mese_prefix) == mese_prefix then

        local material = item_name:sub(#mese_prefix + 1)
        return {
            "mese_post",
            "unilib:tree_" .. material .. "_wood",
            "unilib",
            mese_prefix,
            material,
            "",
        }

    elseif mod_name == "unilib" and item_name:sub(1, #mithril_prefix) == mithril_prefix then

        local material = item_name:sub(#mithril_prefix + 1)
        return {
            "mithril_post",
            "unilib:tree_" .. material .. "_wood",
            "unilib",
            mithril_prefix,
            material,
            "",
        }

    end

    -- Walls (usually made out of stone). Only three items from minetest_game are supported, but
    --      all unilib walls are supported
    if full_name == "walls:cobble" then

        return {"walls", "default:cobble", "walls", "", "cobble", ""}

    elseif full_name == "walls:mossycobble" then

        return {"walls", "default:mossycobble", "walls", "", "mossycobble", ""}

    elseif full_name == "walls:desertcobble" then

        return {"walls", "default:desert_cobble", "walls", "", "desert_cobble", ""}

    -- e.g. "unilib:stone_ordinary_cobble_wall", "unilib:stone_ordinary_cobble_mossy_wall",
    --      "unilib:stone_desert_cobble_wall" etc
    elseif mod_name == "unilib" and item_name:sub(-5) == "_wall" then

        local material = item_name:sub(1, #item_name - 5)
        return {"walls", "unilib:" .. material .. "_wall", "unilib", "", material, "_wall"}

    end

    -- Basic stairs from minetest_game. Only four stair types from minetest_game are supported, but
    --      all unilib stair and carving types are supported
    -- e.g. "stairs:stair_stone", "stairs:stair_inner_stone", "stairs:stair_outer_stone",
    --      "stairs:slab_stone" / "unilib:stone_ordinary_stair_simple",
    --      "unilib:stone_ordinary_stair_inner", "unilib:stone_ordinary_stair_outer",
    --      "unilib:stone_ordinary_stair_slab"
    if mod_name == "stairs" then

        -- stair_inner_ and stair_outer_ need to be checked before stair_ is checked
        local stair_prefix_list = {"stair_inner_", "stair_outer_", "stair_", "slab_"}
        for i, prefix in ipairs(stair_prefix_list) do

            if item_name:sub(1, #prefix) == prefix then

                local material = item_name:sub(#prefix + 1)
                return {"stairs", "default:" .. material, mod_name, prefix, material, ""}

            end

        end

        return nil

    elseif mod_name == "unilib" and unilib.global.stair_deconvert_table[full_name] ~= nil then

        local orig_name = unilib.global.stair_deconvert_table[full_name]
        suffix = full_name:sub(#orig_name + 1)
        return {"stairs", orig_name, "unilib", "", unilib.utils.get_item_name(orig_name), suffix}

    elseif mod_name == "unilib" and unilib.global.carving_deconvert_table[full_name] ~= nil then

        local orig_name = unilib.global.carving_deconvert_table[full_name]
        suffix = full_name:sub(#orig_name + 1)
        return {"carvings", orig_name, "unilib", "", unilib.utils.get_item_name(orig_name), suffix}

    end

    -- Items created by the circular saw from moreblocks. Their unilib equivalents are stair types
    --      which have already been handled by the code above
    for prefix, suffixes in pairs(saw_prefix_table) do

        -- The prefix matches; does any suffix match?
        if item_name:sub(1, #prefix) == prefix then

            for i, suffix in ipairs(suffixes) do

                if suffix == "" or item_name:sub(-#suffix) == suffix then

                    local material = item_name:sub(#prefix + 1, -#suffix - 1)
                    for m_name, m_part_list in pairs(circular_saw.known_nodes) do

                        if m_part_list[2] == material then

                            return {
                                "circular_saw", m_name, m_part_list[1], prefix, material, suffix,
                            }

                        end

                    end

                end

            end

            -- No need to check the other prefixes; they won't match either
            return ""

        end

    end

    -- Items created by the CNC machine from technic
    if core.global_exists("technic_cnc") and technic_cnc.programs then

        for i, data in ipairs(technic_cnc.programs) do

            if full_name:sub(-#data.suffix - 1) == "_" .. data.suffix then

                local source_node = full_name:sub(1, -#data.suffix - 2)
                local p = source_node:split(":")
                return {"tecnic_cnc", source_node, p[1], "", p[2], "_" .. data.suffix}

            end

        end

    end

    return nil

end

local function get_new_node_data(old_node, stored_pattern, player_name)

    -- Was replacer.get_new_node_data()
    -- Try to convert the old node into the desired new node
    -- The mode is stored in user_mode_table[player_name] (fallback value: "normal")

    if not old_node or not stored_pattern or not old_node.name then
        return nil
    end

    -- Normal mode of operation: replace material, shape and orientation
    if unilib.utils.is_table_empty(user_mode_table) or
            not user_mode_table[player_name] or
            user_mode_table[player_name] == "normal" then
        return stored_pattern
    end

    -- What type of node does the stored pattern represent?
    local new_data = identify_shape_and_material(stored_pattern[1])
    -- If the type of the stored pattern cannot be identified, then abort here
    if not new_data then
        return nil
    end

    local old_data = identify_shape_and_material(old_node.name)
    -- If the type of the node that is to be replaced cannot be identified, then abort here
    if not old_data then
        return nil
    end

    -- Replace material, but keep shape and orientation
    if user_mode_table[player_name] == "material" then

        -- Now try to replace the *material* of the old node while keeping prefix and postfix
        local new_name = old_data[3] .. ":" .. old_data[4] .. new_data[5] .. old_data[6]

        -- Handle some exceptions like mese post light wood and desert_cobble walls
        if not core.registered_nodes[new_name] and alt_name_table[new_name] then
            new_name = alt_name_table[new_name]
        end

        -- Perhaps we need to change the mod name to the new material as well
        if not core.registered_nodes[new_name] then
            new_name = new_data[3] .. ":" .. old_data[4] .. new_data[5] .. old_data[6]
        end

        -- If the node still doesn't exist: give up
        if not core.registered_nodes[new_name] then
            return nil
        end

        -- Keep param1 and param2, but change the node name
        return {new_name, old_node.param1, old_node.param2}

    -- Replace shape and orientation, but keep material
    elseif user_mode_table[player_name] == "shape" then

        -- Ttry to replace the *material* of the old node while keeping prefix and postfix
        local new_name = new_data[3] .. ":" .. new_data[4] .. old_data[5] .. new_data[6]

        -- Handle some exceptions like mese post light wood and desert_cobble walls
        if not core.registered_nodes[new_name] and alt_name_table[new_name] then
            new_name = alt_name_table[new_name]
        end

        -- Perhaps we need to change the mod name to the new material as well
        if not core.registered_nodes[new_name] then
            new_name = old_data[3] .. ":" .. new_data[4] .. old_data[5] .. new_data[6]
        end

        -- If the node still doesn't exist, give up
        if not core.registered_nodes[new_name] then
            return nil
        end

        -- Keep material, but change shape and orientation
        return {new_name, stored_pattern[2], stored_pattern[3]}

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (from replacer/init.lua)
---------------------------------------------------------------------------------------------------

local function do_replace(itemstack, user, pointed_thing, mode)

    -- Was replacer.replace()

    if user == nil or pointed_thing == nil then
        return nil
    end

    local name = user:get_player_name()
    if pointed_thing.type ~= "node" then

       core.chat_send_player(name, S("Node replacement error: No node"))
       return nil

    end

    local pos = core.get_pointed_thing_position(pointed_thing, mode)
    local node = core.get_node_or_nil(pos)
    if node == nil then

        core.chat_send_player(
            name,
            S(
                "Node replacement error: Target node not yet loaded. Please wait a moment for" ..
                " the server to catch up."
            )
        )

        return nil

    end

    local meta = itemstack:get_meta()
    local pattern = meta:get_string("pattern")
    -- Make sure "pattern" is defined
    if not pattern or pattern == "" then
        pattern = default_pattern
    end

    local key_table = user:get_player_control()
    if key_table["aux1"] then

        core.show_formspec(
            name,
            "unilib:formspec_item_replacer_normal",
            get_formspec(name, pattern, user)
        )

        return nil

    end

    -- Retain information about nodename, param1 and param2
    local part_list = pattern:split(" ")
    --[[
    -- Older versions of the original mod stored only the node name
    if #part_list < 3 then

       part_list[2] = 0
       part_list[3] = 0

    end
    ]]--

    -- If someone else owns the node then we can't change it
    if unilib.pkg.shared_replacer.is_owned(pos, user) then
        return nil
    end

    part_list = get_new_node_data(node, part_list, name)
    if not part_list then

        -- Nothing to replace
       return

    end

    if node.name and node.name ~= "" and unilib.pkg.shared_replacer.blacklist_table[node.name] then

        core.chat_send_player(
            name,
            S(
                "Node replacement error: Replacing blocks of the type \"@1\" is not allowed" ..
                        " on this server. Replacement failed.",
                (node.name or "?")
            )
        )

        return nil

    end

    if unilib.pkg.shared_replacer.blacklist_table[part_list[1]] then

        core.chat_send_player(
            name,
            S(
                "Node replacement error: Placing blocks of the type \"@1\" with the replacer" ..
                        " is not allowed on this server. Replacement failed.",
                (part_list[1] or "?")
            )
        )

        return nil

    end

    -- Do not replace anything if it's not necessary
    if node.name == part_list[1] then

       -- The node itself remains the same, but the orientation changes
       if node.param1 ~= part_list[2] or node.param2 ~= part_list[3] then
            core.add_node(pos, {name = node.name, param1 = part_list[2], param2 = part_list[3]})
       end

       return nil

    end

    -- In survival mode, the player has to provide the node he wants to place
    --[[
    if not core.settings:get_bool("creative_mode") and
            not core.check_player_privs(name, {creative = true}) then
    ]]--
    if not unilib.utils.is_creative(name) then

        -- Players usually don't carry dirt_with_turf around; it's safe to assume normal dirt here
        -- Fortunately, dirts don't make use of rotation
        --[[
        if part_list[1] == default_turf_node then

            part_list[1] = default_node
            pattern = default_pattern

        end
        ]]--
        local dirt_name = convert_turf_to_dirt(part_list[1])
        if dirt_name ~= nil then

            part_list[1] = dirt_name
            pattern = dirt_name .. " 0 0"

        end

        -- Is the player carrying at least one of the desired nodes with him?
        if not user:get_inventory():contains_item("main", part_list[1]) then

            core.chat_send_player(
                name,
                S(
                    "Node replacement error: You have no more \"@1\". Replacement failed.",
                    (part_list[1] or "?")
                )
            )

            return nil

        end

        -- Give the player the item by simulating digging if possible
        if node.name ~= "air" and node.name ~= "ignore" then

            core.node_dig(pos, node, user)

            local dug_node = core.get_node_or_nil(pos)
            if not dug_node or dug_node.name == node.name then

                -- Some nodes - like liquids - cannot be dug, but they are buildable_to and
                --      thus can be replaced
                local def_table = core.registered_nodes[node.name]
                if def_table == nil or not def_table.buildable_to then

                    core.chat_send_player(
                        name,
                        S(
                            "Node replacement error: Replacing \"@1\" with \"@2\" failed. Unable" ..
                                    " to remove old node.",
                            (node.name or "air"),
                            (pattern or "?")
                        )
                    )

                    return nil

                end

            end

       end

       -- consume the item
       user:get_inventory():remove_item("main", part_list[1] .. " 1")

    end

    core.add_node(pos, {name = part_list[1], param1 = part_list[2], param2 = part_list[3]})
    -- No item will be removed from the inventory
    return nil

 end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_replacer_normal.init()

    return {
        description = "Normal node replacement tool",
        notes = "SNEAK + right-click to set a replacement node. Left-click to replace a node," ..
                " or SNEAK + left-click to place a node. AUX + left-click to open the formspec," ..
                " which allows finer control (for example, replacing the material of a node," ..
                " but not its shape",
        depends = {
            "container_chest_ordinary",
            "dirt_ordinary",
            "item_stick_ordinary",
            "shared_replacer",
        },
    }

end

function unilib.pkg.item_replacer_normal.exec()

    unilib.register_tool("unilib:item_replacer_normal", "replacer:replacer", mode, {
        -- From replacer:replacer
        description = S("Normal Node Replacement Tool"),
        inventory_image = "unilib_item_replacer_normal.png",
        groups = {},

        -- It's OK to interact with water
        liquids_pointable = true,
        node_placement_prediction = nil,
        -- The replacer must store information, so only one can be stacked
        stack_max = 1,
        wield_image = "",
        wield_scale = {x = 1, y = 1, z = 1},

        on_place = function(itemstack, placer, pointed_thing)

            if placer == nil or pointed_thing == nil then

                -- Nothing consumed
                return itemstack

            end

            local name = placer:get_player_name()
            local key_table = placer:get_player_control()

            -- If no new node is to be selected, just place the stored one
            if not key_table["sneak"] and not key_table["aux1"] then
                return do_replace(itemstack, placer, pointed_thing, 0)
            end

            if pointed_thing.type ~= "node" then

                core.chat_send_player(name, S("Node replacement error: No node selected"))
                return nil

            end

            local pos = core.get_pointed_thing_position(pointed_thing, false)
            local node = core.get_node_or_nil(pos)

            local pattern = default_pattern
            if node ~= nil and node.name then
                pattern = node.name .. " " .. node.param1 .. " " .. node.param2
            end

            -- Nothing consumed, but data changed
            return set_new_pattern(name, pattern, placer, itemstack)

        end,

        on_use = function(itemstack, user, pointed_thing)
            return do_replace(itemstack, user, pointed_thing, false)
        end,
    })
    unilib.register_craft({
        -- From replacer:replacer
        output = "unilib:item_replacer_normal",
        recipe = {
            {"unilib:container_chest_ordinary", "", ""},
            {"", "unilib:item_stick_ordinary", ""},
            {"", "", "unilib:container_chest_ordinary"},
        },
    })

    -- From replacer/fs_history.lua
    core.register_on_player_receive_fields(function(player, formname, fields)

        -- The player has interacted with our formspec
        if not formname or formname ~= "unilib:formspec_item_replacer_normal" then
            return false
        end

        local player_name = player:get_player_name()
        -- The player clicked on an entry in the history
        if fields and fields.history_table and history_table and
                history_table[player_name] then

            -- Find out which line it was
            local selected = core.explode_table_event(fields.history_table)
            if selected and (selected.type == "CHG" or selected.type == "DLC") and
                    selected.row <= #history_table[player_name] then

                local itemstack = player:get_wielded_item()
                itemstack = set_new_pattern(
                    player_name,
                    history_table[player_name][selected.row],
                    player,
                    itemstack
                )
                player:set_wielded_item(itemstack)
                return true

            end

        end

        -- The player selected a mode
        if fields and fields.select_mode then

            local index = table.indexof(mode_description_list, F(fields.select_mode))
            if index and index > -1 and mode_name_list[index] then
                user_mode_table[player_name] = mode_name_list[index]
            end

        end

        return true

    end)

    -- Populate the circular saw table
    if core.global_exists("circular_saw") and circular_saw.names then

        -- This is fixed for the saw and does not depend on which actual nodes are registered for it
        --      later on; we build this table for quick lookup because many shapes share the same
        --      prefix
        for i, v in ipairs(circular_saw.names) do

            local prefix = v[1] .. "_"
            if not saw_prefix_table[prefix] then
                saw_prefix_table[prefix] = {v[2]}
            else
                table.insert(saw_prefix_table[prefix], v[2])
            end

        end

    end

end
