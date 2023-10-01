---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    towercrane
-- Code:    LGPL 2.1
-- Media:   CC0/CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_towercrane = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

-- Minetest settings provide maximum crane/rope sizes. This is the minium value
local crane_min_size = 8
-- The LBM removes the erected crane after a year of inactivity
local days_without_use = 365
-- Table of player names (keys) and booleans (corresponding values), to prevent race condition
--      crashes
local departed_player_table = {}
-- Flag (original to unilib), set to true on first call to .register_crane(), as
--      minetest.register_on_joinplayer() etc only needs to be called once
local first_crane_flag = false

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function chat(player, text)

    -- Adapted from towercrane/init.lua, was .chat()

    if player ~= nil then
        minetest.chat_send_player(player, text)
    end

end

local function crane_body_plan(pos, dir, height, width, callback_func, arg_table, part_name)

    -- Adapted from towercrane/init.lua, was .crane_body_plan()
    -- Generic function for contruction and removal

    pos.y = pos.y + 1
    callback_func(pos, "unilib:crane_" .. part_name .. "_mast_ctrl_off", arg_table)

    for _ = 1, height + 1 do

        pos.y = pos.y + 1
        callback_func(pos, "unilib:crane_" .. part_name .. "_mast", arg_table)

    end

    pos.y = pos.y - 2
    pos.x = pos.x - dir.x
    pos.z = pos.z - dir.z
    callback_func(pos, "unilib:crane_" .. part_name .. "_arm_right", arg_table)

    pos.x = pos.x - dir.x
    pos.z = pos.z - dir.z
    callback_func(pos, "unilib:crane_" .. part_name .. "_arm_left", arg_table)

    pos.x = pos.x - dir.x
    pos.z = pos.z - dir.z
    callback_func(pos, "unilib:crane_" .. part_name .. "_balance", arg_table)

    pos.x = pos.x + 3 * dir.x
    pos.z = pos.z + 3 * dir.z

    for i = 1,width do

        pos.x = pos.x + dir.x
        pos.z = pos.z + dir.z
        if i % 2 == 0 then
            callback_func(pos, "unilib:crane_" .. part_name .. "_arm_right", arg_table)
        else
            callback_func(pos, "unilib:crane_" .. part_name .. "_arm_left", arg_table)
        end
    end

end

local function check_space(pos, dir, height, width, owner, part_name)

    -- Adapted from towercrane/init.lua, was .check_space()
    -- Check space and protection for the crane

    local check = function(pos, node_name, arg_table)

        if minetest.get_node(pos).name ~= "air" then

            arg_table.res = false
            chat(owner, S("There is not enough space to erect this crane!"))

        elseif minetest.is_protected(pos, arg_table.owner) then

            arg_table.res = false
            chat(owner, S("This crane cannot be erected in a protected area!"))

        end

    end

    local arg_table = {res = true, owner = owner}
    crane_body_plan(table.copy(pos), dir, height, width, check, arg_table, part_name)
    return arg_table.res

end

local function construct_crane(pos, dir, height, width, part_name)

    -- Adapted from towercrane/init.lua, was .construct_crane()

    local add = function(pos, node_name, arg_table)

        minetest.add_node(
            pos,
            {name = node_name, param2 = minetest.dir_to_facedir(arg_table.dir)}
        )

    end

    local arg_table = {dir = dir}
    crane_body_plan(table.copy(pos), dir, height, width, add, arg_table, part_name)

end

local function get_formspec(height, width, max_height, max_width)

    -- Adapted from towercrane/init.lua, was .formspec()

    local text = ""
    if height and width then
        text = height .. "," .. width
    end

    -- N.B. The formspec provided by the towercrane mod is confusing, so I have rearranged it
    --[[
    return "size[5,4]"..
        "label[0,0;"..S("Construction area size").."]" ..
        "field[1,1.5;3,1;size;height,width;"..text.."]" ..
        "button_exit[1,2;2,1;exit;"..S("Build").."]"
    ]]--
    return "size[5,3]" ..
        "label[0,0;" .. S("Size of construction area") .. "]" ..
        "label[0.5,0.5;" .. S("Example: 8,8") .. "]" ..
        "label[0.5,1;" .. S("Maximum size") .. ": " .. tostring(max_height) .. "," ..
                tostring(max_width) .. "]" ..
        "field[0.3,2.5;3,1;size;" .. S("height,width") .. ";" .. text .. "]" ..
        "button_exit[3,2.2;2,1;exit;" .. S("Build") .. "]"

end

local function build_crane_up(pos, owner, height, width, max_height, max_width, part_name)

    -- Adapted from towercrane/init.lua, was .build_crane_up()

    if height > 0 and width > 0 then

        local meta = minetest.get_meta(pos)
        local dir = minetest.string_to_pos(meta:get_string("dir"))
        if dir then

            if check_space(pos, dir, height, width, owner, part_name) then

                construct_crane(pos, dir, height, width, part_name)
                meta:set_int("height", height)
                meta:set_int("width", width)
                meta:set_string(
                    "infotext",
                    S("Owner") .. ": " .. owner ..
                            ", " .. S("Crane size") .. ": " .. height .. "," .. width
                )

                meta:set_string("formspec", get_formspec(height, width, max_height, max_width))

            end

        end

    else

        chat(owner, S("Invalid crane size! Example value: 8,8"))

    end

end

local function get_crane_data_main(pos)

    -- Adapted from towercrane/init.lua, was .get_crane_data()

    local meta = minetest.get_meta(pos)
    local dir = minetest.string_to_pos(meta:get_string("dir"))
    local owner = meta:get_string("owner")
    local height = meta:get_int("height")
    local width = meta:get_int("width")

    if dir and height > 0 and width > 0 and owner ~= "" then
        return {dir = dir, height = height, width = width, owner = owner}
    end

end

local function get_crane_data_control(pos)

    -- Adapted from towercrane/control.lua, was .get_crane_data()
    -- "pos" is the switch position

    local base_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
    return get_crane_data_main(base_pos)

end

local function turn_left(dir)

    -- Adapted from towercrane/init.lua, was .turnleft()

    local facedir = minetest.dir_to_facedir(dir)
    return minetest.facedir_to_dir((facedir + 3) % 4)

end

local function turn_right(dir)

    -- Adapted from towercrane/init.lua, was .turnright()

    local facedir = minetest.dir_to_facedir(dir)
    return minetest.facedir_to_dir((facedir + 1) % 4)

end

local function calc_construction_area(pos)

    -- Adapted from towercrane/control.lua, was .calc_construction_area()

    local data = get_crane_data_control(pos)
    if data then

        -- pos1 = close/right/below
        local dir = turn_right(data.dir)
        local pos1 = vector.add(pos, vector.multiply(dir, data.width / 2))
        dir = turn_left(dir)
        pos1 = vector.add(pos1, vector.multiply(dir, 1))
        pos1.y = pos.y - 2 + data.height - unilib.crane_rope_length

        -- pos2 = far/left/above
        local pos2 = vector.add(pos1, vector.multiply(dir, data.width - 1))
        dir = turn_left(dir)
        pos2 = vector.add(pos2, vector.multiply(dir, data.width))
        pos2.y = pos.y - 3 + data.height

        -- Normalise x/z so that pos2 > pos1
        if pos2.x < pos1.x then
            pos2.x, pos1.x = pos1.x, pos2.x
        end

        if pos2.z < pos1.z then
            pos2.z, pos1.z = pos1.z, pos2.z
        end

        return pos1, pos2

    end

end

local function check_input(fields, max_height, max_width)

    -- Adapted from towercrane/init.lua, was .check_input()
    -- Check user input (height, width)

    local size = string.split(fields.size, ",")
    if #size == 2 then

        local height = tonumber(size[1])
        local width = tonumber(size[2])
        if height ~= nil and width ~= nil then

            height = math.max(height, crane_min_size)
            height = math.min(height, max_height)
            width = math.max(width, crane_min_size)
            width = math.min(width, max_width)
            return height, width

        end

    end

    return 0, 0

end

local function is_crane_running_control(pos)

    -- Adapted from towercrane/control.lua, was .is_crane_running()
    -- "pos" is the switch position

    local meta = minetest.get_meta(pos)
    return meta:get_int("running") == 1

end

local function is_crane_running_main(pos)

    -- Adapted from towercrane/init.lua, was .is_crane_running()
    -- "pos" is the base position

    local switch_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
    return is_crane_running_control(switch_pos)

end

local function is_my_crane_main(pos, player)

    -- Adapted from towercrane/init.lua, was .is_my_crane()
    -- "pos" is the base position

    if minetest.check_player_privs(player, "server") then
        return true
    end

    -- Check protection
    local player_name = player and player:get_player_name() or ""
    if minetest.is_protected(pos, player_name) then
        return false
    end

    -- Check owner
    local meta = minetest.get_meta(pos)
    if not meta or player_name ~= meta:get_string("owner") then
        return false
    end

    return true

end

local function is_my_crane_control(pos, clicker)

    -- Adapted from towercrane/control.lua, was .is_my_crane()
    -- "pos" is the switch position

    local base_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
    return is_my_crane_main(base_pos, clicker)

end

local function pos_to_string(pos)

    -- Adapted from towercrane/init.lua and control.lua, was P2S()

    if pos then
        return minetest.pos_to_string(pos)
    end

end

local function store_last_used(pos)

    -- Adapted from towercrane/control.lua, was .store_last_used()
    -- "pos" is the switch position

    local meta = minetest.get_meta(pos)
    meta:set_int("last_used", minetest.get_day_count() + days_without_use)

end

local function place_player(pos, player)

    -- Adapted from towercrane/control.lua, was .place_player()

    if pos and player then

        local data = get_crane_data_control(pos)
        if data then

            local new_pos = vector.add(pos, data.dir)
            new_pos.y = new_pos.y - 1
            player:set_pos(new_pos)
            local meta = minetest.get_meta(pos)
            meta:set_string("last_known_pos", pos_to_string(new_pos))

        end

    end

end

local function reset_operator_privs(player)

    -- Adapted from towercrane/control.lua, was .reset_operator_privs()

    local privs = minetest.get_player_privs(player:get_player_name())
    local physics = player:get_physics_override()
    if privs and physics then

        unilib.set_player_attribute(player, "pkg_shared_towercrane_pos", "")

        -- Restore the player privs default values
        unilib.set_player_attribute(player, "pkg_shared_towercrane_is_operator", 0)
        unilib.set_player_attribute(player, "pkg_shared_towercrane_player_physics_locked", 0)
        privs["fast"] =
            unilib.get_player_attribute(player, "pkg_shared_towercrane_fast") == "true" or nil
        privs["fly"] =
            unilib.get_player_attribute(player, "pkg_shared_towercrane_fly") == "true" or nil
        physics.speed = tonumber(unilib.get_player_attribute(player, "pkg_shared_towercrane_speed"))
        if physics.speed == 0 or physics.speed == nil then
            physics.speed = 1
        end

        -- Delete stored default values
        unilib.set_player_attribute(player, "pkg_shared_towercrane_fast", "")
        unilib.set_player_attribute(player, "pkg_shared_towercrane_fly", "")
        unilib.set_player_attribute(player, "pkg_shared_towercrane_speed", "")

        -- Write back
        player:set_physics_override(physics)
        minetest.set_player_privs(player:get_player_name(), privs)

    end

end

local function control_player(pos, pos1, pos2, player_name)

    -- Adapted from towercrane/control.lua, was .control_player()

    if departed_player_table[player_name] then

        departed_player_table[player_name] = nil
        return

    end

    local player = player_name and minetest.get_player_by_name(player_name)
    if player then

        if is_crane_running_control(pos) then

            -- Check if outside of the construction area
            local correction = false
            local pl_pos = player:get_pos()
            if pl_pos then

                if pl_pos.x < pos1.x then

                    pl_pos.x = pos1.x
                    correction = true

                end

                if pl_pos.x > pos2.x then

                    pl_pos.x = pos2.x
                    correction = true

                end

                if pl_pos.y < pos1.y then

                    pl_pos.y = pos1.y
                    correction = true

                end

                if pl_pos.y > pos2.y then

                    pl_pos.y = pos2.y
                    correction = true

                end

                if pl_pos.z < pos1.z then

                    pl_pos.z = pos1.z
                    correction = true

                end

                if pl_pos.z > pos2.z then

                    pl_pos.z = pos2.z
                    correction = true

                end

                -- Check if a protected area is violated
                if correction == false and minetest.is_protected(pl_pos, player_name) then

                    chat(player_name, S("This crane cannot be erected in a protected area!"))
                    correction = true

                end

                local meta = minetest.get_meta(pos)
                if correction == true then

                    local last_pos = minetest.string_to_pos(meta:get_string("last_known_pos"))
                    if last_pos then
                        player:set_pos(last_pos)
                    end

                else

                    -- Store last known correct position
                    meta:set_string("last_known_pos", pos_to_string(pl_pos))

                end

                minetest.after(1, control_player, pos, pos1, pos2, player_name)

            end

        else

            store_last_used(pos)
            place_player(pos, player)
            reset_operator_privs(player)

        end

    else

        local meta = minetest.get_meta(pos)
        meta:set_int("running", 0)

    end

end

local function get_node_lvm(pos)

    -- Adapted from towercrane/init.lua, was .get_node_lvm()

    local node = minetest.get_node_or_nil(pos)
    if node then
        return node
    end

    local vm = minetest.get_voxel_manip()
    local MinEdge, MaxEdge = vm:read_from_map(pos, pos)
    local data = vm:get_data()
    local param2_data = vm:get_param2_data()
    local area = VoxelArea:new({MinEdge = MinEdge, MaxEdge = MaxEdge})
    local idx = area:indexp(pos)
    if data[idx] and param2_data[idx] then

        return {
            name = minetest.get_name_from_content_id(data[idx]),
            param2 = param2_data[idx]
        }

    end

    return {name = "ignore", param2 = 0}

end

local function remove_crane(pos, dir, height, width, part_name)

    -- Adapted from towercrane/init.lua, was .remove_crane()

    local remove = function(pos, node_name, arg_table)

        local node = get_node_lvm(pos)
        if node.name == node_name or
                node.name == "unilib:crane_" .. part_name .. "_mast_ctrl_on" then
            minetest.remove_node(pos)
        end

    end

    crane_body_plan(table.copy(pos), dir, height, width, remove, {}, part_name)

end

local function get_crane_down(pos, max_height, max_width, part_name)

    -- Adapted from towercrane/init.lua, was .get_crane_down()
    -- "pos" is the base position

    local data = get_crane_data_main(pos)
    if data then

        remove_crane(pos, data.dir, data.height, data.width, part_name)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec", get_formspec(data.height, data.width, max_height, max_width))

    end

end

local function get_my_crane_pos(player)

    -- Adapted from towercrane/control.lua, was .get_my_crane_pos()

    -- Check operator state
    if tonumber(unilib.get_player_attribute(player, "pkg_shared_towercrane_is_operator")) ~= 1 then
        return
    end

    -- Check owner
    local pos =
        minetest.string_to_pos(unilib.get_player_attribute(player, "pkg_shared_towercrane_pos"))
    local player_name = (player and player:get_player_name()) or ""
    local data = get_crane_data_control(pos)
    if not data or player_name ~= data.owner then
        return
    end

    -- Check protection
    if minetest.is_protected(pos, player_name) then
        return
    end

    -- switch pos
    return pos

end

local function is_operator(player)

    -- Adapted from towercrane/control.lua, was .is_operator()

    if tonumber(unilib.get_player_attribute(player, "pkg_shared_towercrane_is_operator")) ~= 1 then
        return false
    else
        return true
    end

end

local function set_operator_privs(player, pos)

    -- Adapted from towercrane/control.lua, was .set_operator_privs()

    local privs = minetest.get_player_privs(player:get_player_name())
    local physics = player:get_physics_override()

    -- Check access conflicts with other mods
    if unilib.get_player_attribute(player, "pkg_shared_towercrane_player_physics_locked") == "" or
            tonumber(
                unilib.get_player_attribute(player, "pkg_shared_towercrane_player_physics_locked")
            ) == 0 then

        if pos and privs and physics then

            unilib.set_player_attribute(player, "pkg_shared_towercrane_pos", pos_to_string(pos))

            -- Store the player privs default values
            unilib.set_player_attribute(
                player,
                "pkg_shared_towercrane_fast",
                privs["fast"] and "true" or "false"
            )
            unilib.set_player_attribute(
                player,
                "pkg_shared_towercrane_fly",
                privs["fly"] and "true" or "false"
            )
            unilib.set_player_attribute(player, "pkg_shared_towercrane_speed", physics.speed)

            -- Set operator privs
            unilib.set_player_attribute(player, "pkg_shared_towercrane_is_operator", 1)
            unilib.set_player_attribute(player, "pkg_shared_towercrane_player_physics_locked", 1)
            privs["fly"] = true
            privs["fast"] = nil
            physics.speed = 0.7

            -- Write back
            player:set_physics_override(physics)
            minetest.set_player_privs(player:get_player_name(), privs)

            return true

        end

    end

    return false

end

local function swap_node(pos, state, part_name)

    -- Adapted from towercrane/control.lua, was .swap_node()
    -- State must be "on" or "off"

    -- Check node
    local node = minetest.get_node(pos)
    if node.name ~= "unilib:crane_" .. part_name .. "_mast_ctrl_" ..
            (state == "on" and "off" or "on") then
        return
    end

    -- Switch node
    node.name = "unilib:crane_" .. part_name .. "_mast_ctrl_" .. state
    minetest.swap_node(pos, node)

end

local function start_crane(pos, player, part_name)

    -- Adapted from towercrane/control.lua, was .start_crane()

    swap_node(pos, "on", part_name)
    local meta = minetest.get_meta(pos)
    meta:set_int("running", 1)
    store_last_used(pos)
    place_player(pos, player)

end

local function stop_crane(pos, player, part_name)

    -- Adapted from towercrane/control.lua, was .stop_crane()

    swap_node(pos, "off", part_name)
    local meta = minetest.get_meta(pos)
    meta:set_int("running", 0)
    store_last_used(pos)
    place_player(pos, player)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_towercrane.register_crane(data_table)

    -- Adapted from towercrane/init.lua and control.lua
    -- Creates a crane made from a specified ingredient, with specified maximum size
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "steel"
    --      orig_name (str): e.g. "towercrane:base" for the crane using the original mod's textures,
    --          or an empty string for all other cranes
    --      ingredient (str): e.g. "unilib:metal_steel_ingot"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Gold Crane"
    --      max_height (int): Maximum height in the range "crane_min_size" (specified above,
    --          default value 32) to unilib_crane_max_height
    --      max_width (int): Maximum width in the range "crane_min_size" to unilib_crane_max_width
    --      minor_ingredient (str): e.g. "unilib:mineral_mese_block". If omitted, only "ingredient"
    --          is used
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Crane")
    local max_height = data_table.max_height or unilib.crane_max_height
    local max_width = data_table.max_height or unilib.crane_max_width
    local minor_ingredient = data_table.minor_ingredient or ingredient

    -- (Set up original node names)
    local orig_base = nil
    local orig_balance = nil
    local orig_mast = nil
    local orig_arm_left = nil
    local orig_arm_right = nil
    local orig_mast_on = nil
    local orig_mast_off = nil
    if orig_name ~= nil then

        orig_base = "towercrane:base"
        orig_balance = "towercrane:balance"
        orig_mast = "towercrane:mast"
        orig_arm_left = "towercrane:arm"
        orig_arm_right = "towercrane:arm2"
        orig_mast_on = "towercrane:mast_ctrl_on"
        orig_mast_off = "towercrane:mast_ctrl_off"

    end

    local arm_left_img = "unilib_crane_" .. part_name .. "_arm_left.png"
    local arm_right_img = "unilib_crane_" .. part_name .. "_arm_right.png"
    local arrow_img = "unilib_crane_generic_arrow_overlay.png"
    local base_img = "unilib_crane_" .. part_name .. "_base.png"
    local light_img = "unilib_crane_generic_light_overlay.png"
    local mast_img = "unilib_crane_" .. part_name .. "_mast.png"
    local screws_img = "unilib_crane_generic_screws_overlay.png"

    -- (Absolute xaximum/minimum heights are specified by Minetest settings)
    max_height = math.min(max_height, unilib.crane_max_height)
    max_width = math.min(max_width, unilib.crane_max_width)

    -- (From init.lua)

    unilib.register_node("unilib:crane_" .. part_name .. "_base", orig_base, replace_mode, {
        -- From towercrane:base
        description = unilib.brackets(description, S("Base")),
        tiles = {base_img .. "^" .. arrow_img, base_img .. "^" .. screws_img},
        groups = {cracky = 2},
        sounds = unilib.sound_table.metal,

        inventory_image = "[inventorycube{" .. mast_img .. "{" .. mast_img .. "{" .. mast_img,
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,

        after_place_node = function(pos, placer)

            -- Set metadata (a form for crane height and width, and for the direction of the arm)

            local meta = minetest.get_meta(pos)
            local owner = placer:get_player_name()
            meta:set_string("owner", owner)
            meta:set_string("formspec", get_formspec(nil, nil, max_height, max_width))

            local fdir = minetest.dir_to_facedir(placer:get_look_dir(), false)
            local dir = minetest.facedir_to_dir(fdir)
            meta:set_string("dir", pos_to_string(dir))

        end,

        can_dig = function(pos, player)

            if minetest.check_player_privs(player, "server") then
                return true
            end

            if is_crane_running_main(pos) then
                return false
            end

            if not is_my_crane_main(pos, player) then
                return false
            end

            return true

        end,

        on_destruct = function(pos)
            get_crane_down(pos, max_height, max_width, part_name)
        end,

        on_receive_fields = function(pos, formname, fields, player)

            -- Evaluate user input (height, width)
            -- Destroy the old crane and build a new one with the specified size

            if fields.size == nil then
                return
            end

            if is_crane_running_main(pos) then
                return
            end

            if not is_my_crane_main(pos, player) then
                return
            end

            -- Destroy old crane
            get_crane_down(pos, max_height, max_width, part_name)
            -- Evaluate user input and build a new one
            local height, width = check_input(fields, max_height, max_width)
            build_crane_up(
                pos, player:get_player_name(), height, width, max_height, max_width, part_name
            )

        end,

        on_rotate = function(pos, node, player, mode, new_facedir)

            -- Check whether crane is built up
            local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
            local node_above = minetest.get_node(pos_above)

            if node_above.name == "unilib:crane_" .. part_name .. "_mast_ctrl_on" or
                    node_above.name == "unilib:crane_" .. part_name .. "_mast_ctrl_off" then
                return false
            end

            -- Only allow rotation around y-axis
            new_facedir = new_facedir % 4

            local dir = minetest.facedir_to_dir(new_facedir)
            local meta = minetest.get_meta(pos)
            meta:set_string("dir", pos_to_string(dir))

            node.param2 = new_facedir
            minetest.swap_node(pos, node, part_name)
            return true

        end,
    })
    -- (Changed the original recipe, to replace dye with a customistable ingredient)
    unilib.register_craft({
        -- From towercrane:base
        output = "unilib:crane_" .. part_name .. "_base",
        recipe = {
            {ingredient, ingredient, ingredient},
            {ingredient, "", ""},
            {minor_ingredient, ingredient, ""},
        }
    })

    unilib.register_node("unilib:crane_" .. part_name .. "_balance", orig_balance, replace_mode, {
        -- From towercrane:balance
        description = unilib.brackets(description, S("Balance")),
        tiles = {base_img .. "^" .. screws_img .. "^" .. light_img},
        groups = {crumbly = 0, not_in_creative_inventory = 1},
        -- (no sounds)

        is_ground_content = false,
        light_source = 12,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })

    unilib.register_node("unilib:crane_" .. part_name .. "_mast", orig_mast, replace_mode, {
        -- From towercrane:mast
        description = unilib.brackets(description, S("Mast")),
        tiles = {
            mast_img,
            {
                name = mast_img,
                backface_culling = false,
            },
        },
        groups = {crumbly = 0, not_in_creative_inventory = 1},
        -- (no sounds)

        drawtype = "glasslike_framed",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })

    unilib.register_node("unilib:crane_" .. part_name .. "_arm_left", orig_arm_left, replace_mode, {
        -- From towercrane:arm
        description = unilib.brackets(description, S("Left Arm")),
        tiles = {
            arm_left_img,
            {
                name = arm_left_img,
                backface_culling = false,
            },
        },
        groups = {crumbly = 0, not_in_creative_inventory = 1},
        -- (no sounds)

        drawtype = "glasslike_framed",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
    })

    unilib.register_node(
        -- From towercrane:arm2
        "unilib:crane_" .. part_name .. "_arm_right",
        orig_arm_right,
        replace_mode,
        {
            description = unilib.brackets(description, S("Right Arm")),
            tiles = {
                arm_right_img,
                {
                    name = arm_right_img,
                    backface_culling = false,
                },
            },
            groups = {crumbly = 0, not_in_creative_inventory = 1},
            -- (no sounds)

            drawtype = "glasslike_framed",
            is_ground_content = false,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
        }
    )

    -- (From control.lua)

    unilib.register_node(
        -- From towercrane:mast_ctrl_on
        "unilib:crane_" .. part_name .. "_mast_ctrl_on",
        orig_mast_on,
        replace_mode,
        {
            description = unilib.brackets(description, S("Mast Control On")),
            tiles = {
                base_img,
                base_img,
                base_img,
                base_img,
                base_img .. "^unilib_crane_generic_button_on_overlay.png",
                base_img .. "^unilib_crane_generic_button_on_overlay.png",
            },
            groups = {crumbly = 0, not_in_creative_inventory = 1},
            -- (no sounds)

            drawtype = "node",
            is_ground_content = false,
            light_source = 3,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,

            on_construct = function(pos)

                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", S("Switch crane on/off"))

            end,

            on_rightclick = function (pos, node, clicker)

                -- Switch the crane off
                local pos2 = get_my_crane_pos(clicker)
                if pos2 and
                        (
                            vector.equals(pos, pos2) or
                            minetest.check_player_privs(clicker, "server")
                        ) then
                    stop_crane(pos, clicker, part_name)
                end

            end,
        }
    )

    unilib.register_node(
        -- From towercrane:mast_ctrl_off
        "unilib:crane_" .. part_name .. "_mast_ctrl_off",
        orig_mast_off,
        replace_mode,
        {
            description = unilib.brackets(description, S("Mast Control Off")),
            tiles = {
                base_img,
                base_img,
                base_img,
                base_img,
                base_img .. "^unilib_crane_generic_button_off_overlay.png",
                base_img .. "^unilib_crane_generic_button_off_overlay.png",
            },
            groups = {crumbly = 0, not_in_creative_inventory = 1},
            -- (no sounds)

            drawtype = "node",
            is_ground_content = false,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,

            on_construct = function(pos)

                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", S("Switch crane on/off"))

            end,

            on_rightclick = function (pos, node, clicker)

                -- Switch the crane ON
                if is_my_crane_control(pos, clicker) and not is_operator(clicker) then

                    if set_operator_privs(clicker, pos) then

                        start_crane(pos, clicker, part_name)
                        local pos1, pos2 = calc_construction_area(pos)
                        -- Control player every second
                        minetest.after(
                            1, control_player, pos, pos1, pos2, clicker:get_player_name()
                        )

                    end

                end

            end,
        }
    )

    if not first_crane_flag then

        -- Only call minetest.register_on_joinplayer() etc once
        first_crane_flag = true

        minetest.register_on_joinplayer(function(player)

            local pos = get_my_crane_pos(player)
            if pos then

                reset_operator_privs(player)
                stop_crane(pos, player, part_name)

            end

        end)

        minetest.register_on_leaveplayer(function(player)

            if is_operator(player) then
                departed_player_table[player:get_player_name()] = true
            end

        end)

        minetest.register_on_dieplayer(function(player, reason)

            if is_operator(player) then

                local pos = get_my_crane_pos(player)
                if pos then

                    reset_operator_privs(player)
                    stop_crane(pos, player, part_name)

                end

            end

        end)

    end

    -- LBM to remove the erected crane, leaving just the base, after a year of inactivity
    unilib.register_lbm({
        label = "Break down " .. part_name .. " crane [shared_towercrane]",
        name = "unilib:lbm_shared_towercrane_" .. part_name,
        nodenames = {
            "unilib:crane_" .. part_name .. "_mast_ctrl_off",
            "unilib:crane_" .. part_name .. "_mast_ctrl_on",
        },

        run_at_every_load = true,

        action = function(pos, node)

            local t = minetest.get_day_count()
            local meta = minetest.get_meta(pos)
            local last_used = meta:get_int("last_used") or 0
            if last_used == 0 then

                meta:set_int("last_used", t + days_without_use)

            elseif t > last_used then

                local base_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
                get_crane_down(base_pos, max_height, max_width, part_name)

            end

        end
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_towercrane.init()

    return {
        description = "Shared functions for cranes (from minetest_game/default)",
    }

end
