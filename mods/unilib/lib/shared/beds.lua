---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- beds.lua
--      Set up shared functions for beds
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- (From beds/init.lua)
local beds_player_table = {}
local beds_position_table = {}
local beds_pos_table = {}
local beds_spawn_table = {}

local esc = minetest.formspec_escape
local formspec = "size[8,11;true]" ..
        "no_prepend[]" ..
        "bgcolor[#080808BB;true]" ..
        "button_exit[2,10;4,0.75;leave;" .. esc(S("Leave Bed")) .. "]"

-- (From beds/functions.lua)
local pi = math.pi
local is_sp_flag = minetest.is_singleplayer()
local enable_respawn_flag = minetest.settings:get_bool("enable_bed_respawn")
if enable_respawn_flag == nil then
    enable_respawn_flag = true
end

-- (From beds/api.lua)
local reverse_flag = true

-- (From beds/spawns.lua)
local org_file = unilib.path_world .. "/beds_spawns"
local file = unilib.path_world .. "/beds_spawns"

---------------------------------------------------------------------------------------------------
-- Spawn functions from beds/spawn.lua
---------------------------------------------------------------------------------------------------

local function read_spawns()

    -- Adapted from beds/spawns.lua

    local spawns = beds_spawn_table
    local input = io.open(file, "r")

    if input then

        repeat

            local x = input:read("*n")
            if x == nil then
                break
            end

            local y = input:read("*n")
            local z = input:read("*n")
            local name = input:read("*l")
            spawns[name:sub(2)] = {x = x, y = y, z = z}

        until input:read(0) == nil

        io.close(input)

    end

end

local function save_spawns()

    -- Adapted from beds/spawns.lua

    if unilib.is_table_empty(beds_spawn_table) then
        return
    end

    local data = {}
    local output = io.open(org_file, "w")
    for k, v in pairs(beds_spawn_table) do
        table.insert(data, string.format("%.1f %.1f %.1f %s\n", v.x, v.y, v.z, k))
    end

    output:write(table.concat(data))
    io.close(output)

end

local function set_spawns()

    -- Adapted from beds/spawns.lua

    for name,_ in pairs(beds_player_table) do

        local player = minetest.get_player_by_name(name)
        local p = player:get_pos()
        -- ...but don't change spawn location if borrowing a bed
        if not minetest.is_protected(p, name) then
            beds_spawn_table[name] = p
        end

    end

    save_spawns()

end

local function remove_spawns_at(pos)

    -- Adapted from beds/spawns.lua

    for name, p in pairs(beds_spawn_table) do

        if vector.equals(vector.round(p), pos) then
            beds_spawn_table[name] = nil
        end

    end

    save_spawns()

end

---------------------------------------------------------------------------------------------------
-- Local functions from beds/functions.lua
---------------------------------------------------------------------------------------------------

local function get_look_yaw(pos)

    -- Adapted from beds/functions.lua

    local rotation = minetest.get_node(pos).param2
    if rotation > 3 then

        -- Mask colorfacedir values
        rotation = rotation % 4

    end

    if rotation == 1 then
        return pi / 2, rotation
    elseif rotation == 3 then
        return -pi / 2, rotation
    elseif rotation == 0 then
        return pi, rotation
    else
        return 0, rotation
    end

end

local function is_night_skip_enabled()

    -- Adapted from beds/functions.lua

    local enable_night_skip = minetest.settings:get_bool("enable_bed_night_skip")
    if enable_night_skip == nil then
        enable_night_skip = true
    end

    return enable_night_skip

end

local function check_in_beds(players)

    -- Adapted from beds/functions.lua

    local in_bed = beds_player_table
    if not players then
        players = minetest.get_connected_players()
    end

    for n, player in ipairs(players) do

        local name = player:get_player_name()
        if not in_bed[name] then
            return false
        end

    end

    return #players > 0

end

local function lay_down(player, pos, bed_pos, state, skip)

    -- Adapted from beds/functions.lua

    local name = player:get_player_name()
    local hud_flags = player:hud_get_flags()

    if not player or not name then
        return
    end

    -- Stand up
    if state ~= nil and not state then

        if not beds_player_table[name] then

            -- Player not in bed, do nothing
            return false

        end

        beds_position_table[name] = nil
        -- Skip here to prevent sending player specific changes (used for leaving players)
        if skip then
            return
        end

        player:set_pos(beds_pos_table[name])

        -- Physics, eye_offset, etc
        local physics_override = beds_player_table[name].physics_override
        beds_player_table[name] = nil
        player:set_physics_override({
            speed = physics_override.speed,
            jump = physics_override.jump,
            gravity = physics_override.gravity
        })
        player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
        player:set_look_horizontal(math.random(1, 180) / 100)
        unilib.player_api.set_player_attached(name, false)
        hud_flags.wielditem = true
        unilib.player_api.set_animation(player, "stand" , 30)

    -- Lie down
    else

        -- Check if bed is occupied
        for _, other_pos in pairs(beds_position_table) do

            if vector.distance(bed_pos, other_pos) < 0.1 then

                minetest.chat_send_player(name, S("This bed is already occupied!"))
                return false

            end

        end

        -- Check if player is moving
        if vector.length(player:get_velocity()) > 0.001 then

            minetest.chat_send_player(name, S("You have to stop moving before going to bed!"))
            return false

        end

        -- Check if player is attached to an object
        if player:get_attach() then
            return false
        end

        -- Check if player already in bed
        if beds_player_table[name] then
            return false
        end

        beds_pos_table[name] = pos
        beds_position_table[name] = bed_pos
        beds_player_table[name] = {physics_override = player:get_physics_override()}

        -- Physics, eye_offset, etc
        -- N.B. Due to an issue in the source version of minetest_game (commit 5273fcb, Oct 16 2021)
        --      the player eye offset when lying down is not correct. Commenting out this line is
        --      an acceptable fix for first-person view, but does not work well in third-person view
--      player:set_eye_offset({x = 0, y = -13, z = 0}, {x = 0, y = 0, z = 0})
        local yaw, param2 = get_look_yaw(bed_pos)
        player:set_look_horizontal(yaw)
        local dir = minetest.facedir_to_dir(param2)
        -- p.y is just above the nodebox height of the 'Simple Bed' (the highest bed), to avoid
        --      sinking down through the bed
        local p = {
            x = bed_pos.x + dir.x / 2,
            y = bed_pos.y + 0.07,
            z = bed_pos.z + dir.z / 2
        }
        player:set_physics_override({speed = 0, jump = 0, gravity = 0})
        player:set_pos(p)
        unilib.player_api.set_player_attached(name, true)
        hud_flags.wielditem = false
        unilib.player_api.set_animation(player, "lay" , 0)

    end

    player:hud_set_flags(hud_flags)

end

local function get_player_in_bed_count()

    -- Adapted from beds/functions.lua

    local c = 0
    for _, _ in pairs(beds_player_table) do
        c = c + 1
    end

    return c

end

local function update_formspecs(finished)

    -- Adapted from beds/functions.lua

    local ges = #minetest.get_connected_players()
    local player_in_bed = get_player_in_bed_count()
    local is_majority = (ges / 2) < player_in_bed

    local form_n
    local esc = minetest.formspec_escape
    if finished then

        form_n = formspec .. "label[2.7,9;" .. esc(S("Good morning.")) .. "]"

    else

        form_n = formspec .. "label[2.2,9;" ..
                esc(S("@1 of @2 players are in bed", player_in_bed, ges)) .. "]"
        if is_majority and is_night_skip_enabled() then

            form_n = form_n .. "button_exit[2,6;4,0.75;force;" ..
                esc(S("Force night skip")) .. "]"

        end

    end

    for name,_ in pairs(beds_player_table) do
        minetest.show_formspec(name, "beds_form", form_n)
    end

end

---------------------------------------------------------------------------------------------------
-- "Public" functions from beds/functions.lua
---------------------------------------------------------------------------------------------------

local function kick_players()

    -- Adapted from beds/functions.lua

    for name, _ in pairs(beds_player_table) do

        local player = minetest.get_player_by_name(name)
        lay_down(player, nil, nil, false)

    end

end

local function skip_night()

    -- Adapted from beds/functions.lua

    minetest.set_timeofday(0.23)

end

local function on_rightclick(pos, player)

    -- Adapted from beds/functions.lua

    local name = player:get_player_name()
    local ppos = player:get_pos()
    local tod = minetest.get_timeofday()

    if tod > 0.2 and tod < 0.805 then

        if beds_player_table[name] then
            lay_down(player, nil, nil, false)
        end

        minetest.chat_send_player(name, S("You can only sleep at night!"))
        return

    end

    -- Move to bed
    if not beds_player_table[name] then

        lay_down(player, ppos, pos)
        -- Save respawn positions when entering bed
        set_spawns()

    else

        lay_down(player, nil, nil, false)

    end

    if not is_sp_flag then
        update_formspecs(false)
    end

    -- Skip the night and let all players stand up
    if check_in_beds() then

        minetest.after(2, function()

            if not is_sp_flag then
                update_formspecs(is_night_skip_enabled())
            end

            if is_night_skip_enabled() then

                skip_night()
                kick_players()

            end

        end)

    end

end

local function can_dig(bed_pos)

    -- Adapted from beds/functions.lua

    -- Check all players in bed which one is at the expected position
    for _, player_bed_pos in pairs(beds_position_table) do

        if vector.equals(bed_pos, player_bed_pos) then
            return false
        end

    end

    return true

end

---------------------------------------------------------------------------------------------------
-- Callbacks from beds/functions.lua
---------------------------------------------------------------------------------------------------

-- (Only register respawn callback if respawn enabled)
if enable_respawn_flag then

    -- Respawn player at bed if enabled and valid position is found
    minetest.register_on_respawnplayer(function(player)

        -- Adapted from beds/functions.lua

        local name = player:get_player_name()
        local pos = beds_spawn_table[name]
        if pos then

            player:set_pos(pos)
            return true

        end

    end)

end

minetest.register_on_leaveplayer(function(player)

    -- Adapted from beds/functions.lua

    local name = player:get_player_name()
    lay_down(player, nil, nil, false, true)
    beds_player_table[name] = nil

    if check_in_beds() then

        minetest.after(2, function()

            update_formspecs(is_night_skip_enabled())
            if is_night_skip_enabled() then

                skip_night()
                kick_players()

            end

        end)

    end

end)

minetest.register_on_dieplayer(function(player)

    -- Adapted from beds/functions.lua

    local name = player:get_player_name()
    local in_bed = beds_player_table
    local pos = player:get_pos()
    local yaw = get_look_yaw(pos)

    if in_bed[name] then

        lay_down(player, nil, pos, false)
        player:set_look_horizontal(yaw)
        player:set_pos(pos)

    end

end)

minetest.register_on_player_receive_fields(function(player, formname, fields)

    -- Adapted from beds/functions.lua

    if formname ~= "beds_form" then
        return
    end

    -- Notes from neds:
    -- Because "Force night skip" button is a button_exit, it will set fields.quit and lay_down call
    --      will change value of player_in_bed, so it must be taken earlier
    local last_player_in_bed = get_player_in_bed_count()

    if fields.quit or fields.leave then

        lay_down(player, nil, nil, false)
        update_formspecs(false)

    end

    if fields.force then

        local is_majority = (#minetest.get_connected_players() / 2) < last_player_in_bed
        if is_majority and is_night_skip_enabled() then

            update_formspecs(true)
            skip_night()
            kick_players()

        else

            update_formspecs(false)

        end

    end

end)

---------------------------------------------------------------------------------------------------
-- Local functions from beds/api.lua
---------------------------------------------------------------------------------------------------

local function destruct_bed(pos, n)

    -- Adapted from beds/api.lua

    local node = minetest.get_node(pos)
    local other

    if n == 2 then

        local dir = minetest.facedir_to_dir(node.param2)
        other = vector.subtract(pos, dir)

    elseif n == 1 then

        local dir = minetest.facedir_to_dir(node.param2)
        other = vector.add(pos, dir)

    end

    if reverse_flag then

        reverse_flag = not reverse_flag
        minetest.remove_node(other)
        minetest.check_for_falling(other)
        remove_spawns_at(pos)
        remove_spawns_at(other)

    else

        reverse_flag = not reverse_flag

    end

end

---------------------------------------------------------------------------------------------------
-- Register beds
---------------------------------------------------------------------------------------------------

function unilib.register_bed(data_table)

    -- Adapted from beds/api.lua
    -- Register a bed
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary"
    --      orig_name (str or list): e.g. {"beds:bed_bottom", "beds:bed_top"},
    --      recipe_table (table): The craft recipe for the bed
    --      tile_table (table): Table with the fields .bottom and .top, each containing a list of
    --          tiles
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burntime (int): e.g. 12
    --      description (str): e.g. "Ordinary Bed"
    --      inventory_image (str): Inventory texture
    --      node_table (table): Table used as the .node_box field in the minetest.register_node()
    --          call
    --      select_table (table): Table used as the .selection_box field in the
    --          minetest.register_node() call
    --      wield_image (str): Wield texture
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local recipe_table = data_table.recipe_table
    local tile_table = data_table.tile_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burntime = data_table.burntime or 12
    local description = data_table.description or S("Bed")
    local inventory_image = data_table.inventory_image or "unilib_unknown.png"
    local node_table = data_table.node_table or {
        bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
        top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
    }
    local select_table = data_table.select_table or {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5}
    local wield_image = data_table.wield_image or "unilib_unknown.png"

    local full_name = "unilib:bed_" .. part_name

    local bottom_group_table = {bed = 1, choppy = 2, flammable = 3, oddly_breakable_by_hand = 2}
    local top_group_table = {
        bed = 2, choppy = 2, flammable = 3, not_in_creative_inventory = 1,
        oddly_breakable_by_hand = 2,
    }

    if unilib.effects_bouncy_beds_flag then

        bottom_group_table.bouncy = 85
        bottom_group_table.fall_damage_add_percent = -40
        top_group_table.bouncy = 85
        top_group_table.fall_damage_add_percent = -40

    end

    -- Beds require code imported from minetest_game/player_api, if not already loaded
    unilib.load_player_api()

    -- Register nodes. The bottom section of the bed is the clickable one
    unilib.register_node(full_name .. "_bottom", orig_name, replace_mode, {
        description = description,
        tiles = tile_table.bottom,
        groups = bottom_group_table,
        sounds = data_table.sounds or unilib.sound_table.wood,

        drawtype = "nodebox",
        inventory_image = inventory_image,
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = node_table.bottom,
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = select_table,
        },
        stack_max = 1,
        use_texture_alpha = "clip",
        wield_image = wield_image,

        can_dig = function(pos, player)
            return can_dig(pos)
        end,

        on_destruct = function(pos)
            destruct_bed(pos, 1)
        end,

        on_place = function(itemstack, placer, pointed_thing)

            local under = pointed_thing.under
            local node = minetest.get_node(under)
            local udef = minetest.registered_nodes[node.name]
            if udef and udef.on_rightclick and not (
                placer and
                placer:is_player() and
                placer:get_player_control().sneak
            ) then

                return udef.on_rightclick(under, node, placer, itemstack, pointed_thing) or
                        itemstack

            end

            local pos
            if udef and udef.buildable_to then
                pos = under
            else
                pos = pointed_thing.above
            end

            local player_name = placer and placer:get_player_name() or ""

            if minetest.is_protected(pos, player_name) and
                    not minetest.check_player_privs(player_name, "protection_bypass") then

                minetest.record_protection_violation(pos, player_name)
                return itemstack

            end

            local node_def = minetest.registered_nodes[minetest.get_node(pos).name]
            if not node_def or not node_def.buildable_to then
                return itemstack
            end

            local dir = placer and placer:get_look_dir() and
                    minetest.dir_to_facedir(placer:get_look_dir()) or 0
            local botpos = vector.add(pos, minetest.facedir_to_dir(dir))

            if minetest.is_protected(botpos, player_name) and
                    not minetest.check_player_privs(player_name, "protection_bypass") then

                minetest.record_protection_violation(botpos, player_name)
                return itemstack

            end

            local botdef = minetest.registered_nodes[minetest.get_node(botpos).name]
            if not botdef or not botdef.buildable_to then
                return itemstack
            end

            minetest.set_node(pos, {name = full_name .. "_bottom", param2 = dir})
            minetest.set_node(botpos, {name = full_name .. "_top", param2 = dir})

            if not unilib.is_creative(player_name) then
                itemstack:take_item()
            end

            return itemstack

        end,

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            on_rightclick(pos, clicker)
            return itemstack

        end,

        on_rotate = function(pos, node, user, _, new_param2)

            local dir = minetest.facedir_to_dir(node.param2)
            local p = vector.add(pos, dir)
            local node2 = minetest.get_node_or_nil(p)
            if not node2 or not minetest.get_item_group(node2.name, "bed") == 2 or
                    not node.param2 == node2.param2 then
                return false
            end

            if minetest.is_protected(p, user:get_player_name()) then

                minetest.record_protection_violation(p, user:get_player_name())
                return false

            end

            if new_param2 % 32 > 3 then
                return false
            end

            local newp = vector.add(pos, minetest.facedir_to_dir(new_param2))
            local node3 = minetest.get_node_or_nil(newp)
            local node_def = node3 and minetest.registered_nodes[node3.name]
            if not node_def or not node_def.buildable_to then
                return false
            end

            if minetest.is_protected(newp, user:get_player_name()) then

                minetest.record_protection_violation(newp, user:get_player_name())
                return false

            end

            node.param2 = new_param2
            -- Do not remove_node here - it will trigger destroy_bed()
            minetest.set_node(p, {name = "air"})
            minetest.set_node(pos, node)
            minetest.set_node(newp, {name = full_name .. "_top", param2 = new_param2})
            return true

        end,
    })

    unilib.register_node(full_name .. "_top", nil, replace_mode, {
        -- (no description)
        tiles = tile_table.top,
        groups = top_group_table,
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        drop = full_name .. "_bottom",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = data_table.node_table.top,
        },
        paramtype = "light",
        paramtype2 = "facedir",
        pointable = false,
        use_texture_alpha = "clip",

        can_dig = function(pos, player)

            local node = minetest.get_node(pos)
            local dir = minetest.facedir_to_dir(node.param2)
            local p = vector.add(pos, dir)
            return can_dig(p)

        end,

        on_destruct = function(pos)
            destruct_bed(pos, 2)
        end,
    })

    -- Craft recipe for the bottom section
    unilib.register_craft({
        output = full_name .. "_bottom",
        recipe = recipe_table
    })
    -- Burn recipe
    unilib.register_craft({
        type = "fuel",
        recipe = full_name .. "_bottom",
        burntime = burntime,
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

read_spawns()
