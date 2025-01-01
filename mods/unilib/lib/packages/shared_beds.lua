---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beds
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_beds = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.beds.add_mode

-- (From beds/init.lua)
local beds_player_table = {}
local beds_position_table = {}
local beds_pos_table = {}
local beds_spawn_table = {}

local formspec = "size[8,11;true]" ..
        "no_prepend[]" ..
        "bgcolor[#080808BB;true]" ..
        "button_exit[2,10;4,0.75;leave;" .. FS("Leave Bed") .. "]"

local day_interval_table = {
    start = 0.2,
    finish = 0.805,
}

-- (From beds/functions.lua)
local pi = math.pi
local is_sp_flag = core.is_singleplayer()
local update_scheduled_flag = false

-- (From beds/spawns.lua)
local org_file = unilib.core.path_world .. "/beds_spawns"
local file = unilib.core.path_world .. "/beds_spawns"

---------------------------------------------------------------------------------------------------
-- Local functions (spawn functions from beds/spawn.lua)
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

    if unilib.utils.is_table_empty(beds_spawn_table) then
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

        local player = core.get_player_by_name(name)
        local p = player:get_pos()
        -- ...but don't change spawn location if borrowing a bed
        if not core.is_protected(p, name) then
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
-- Local functions (from beds/functions.lua)
---------------------------------------------------------------------------------------------------

local function get_look_yaw(pos)

    -- Adapted from beds/functions.lua

    local rotation = core.get_node(pos).param2
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

    local enable_night_skip = core.settings:get_bool("enable_bed_night_skip")
    if enable_night_skip == nil then
        enable_night_skip = true
    end

    return enable_night_skip

end

local function check_in_beds(players)

    -- Adapted from beds/functions.lua

    local in_bed = beds_player_table
    if not players then
        players = core.get_connected_players()
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
            gravity = physics_override.gravity,
            jump = physics_override.jump,
            speed = physics_override.speed,
        })
        player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
        player:set_look_horizontal(math.random(1, 180) / 100)
        unilib.player_api.set_player_attached(name, false)
        hud_flags.wielditem = true
        unilib.player_api.set_animation(player, "stand", 30)

    -- Lie down
    else

        -- Check if bed is occupied
        for _, other_pos in pairs(beds_position_table) do

            if vector.distance(bed_pos, other_pos) < 0.1 then

                core.chat_send_player(name, S("This bed is already occupied!"))
                return false

            end

        end

        -- Check if player is moving
        if vector.length(player:get_velocity()) > 0.001 then

            core.chat_send_player(name, S("You have to stop moving before going to bed!"))
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
        local yaw, param2 = get_look_yaw(bed_pos)
        player:set_look_horizontal(yaw)
        local dir = core.facedir_to_dir(param2)
        -- p.y is just above the nodebox height of the 'Simple Bed' (the highest bed), to avoid
        --      sinking down through the bed
        local p = {
            x = bed_pos.x + dir.x / 2,
            y = bed_pos.y + 0.07,
            z = bed_pos.z + dir.z / 2
        }

        player:set_physics_override({gravity = 0, jump = 0, speed = 0})
        player:set_pos(p)
        unilib.player_api.set_player_attached(name, true)
        hud_flags.wielditem = false
        unilib.player_api.set_animation(player, "lay", 0)

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

    local ges = #core.get_connected_players()
    local player_in_bed = get_player_in_bed_count()
    local is_majority = (ges / 2) < player_in_bed

    local form_n
    if finished then

        form_n = formspec .. "label[2.7,9;" .. FS("Good morning.") .. "]"

    else

        form_n = formspec .. "label[2.2,9;" ..
                FS("@1 of @2 players are in bed", player_in_bed, ges) .. "]"

        if is_majority and is_night_skip_enabled() then
            form_n = form_n .. "button_exit[2,6;4,0.75;force;" .. FS("Force night skip") .. "]"
        end

    end

    for name,_ in pairs(beds_player_table) do
        core.show_formspec(name, "beds_form", form_n)
    end

end

---------------------------------------------------------------------------------------------------
-- Local functions ("Public" functions from beds/functions.lua)
---------------------------------------------------------------------------------------------------

local function kick_players()

    -- Adapted from beds/functions.lua

    for name, _ in pairs(beds_player_table) do

        local player = core.get_player_by_name(name)
        lay_down(player, nil, nil, false)

    end

end

local function skip_night()

    -- Adapted from beds/functions.lua

    core.set_timeofday(0.23)

end

local function schedule_update()

    -- Adapted from beds/functions.lua

    if update_scheduled_flag then

        -- There already is an update scheduled; don't schedule more to prevent race conditions
        return

    end

    update_scheduled_flag = true

    core.after(2, function()

        update_scheduled_flag = false
        if not is_sp_flag then
            update_formspecs(is_night_skip_enabled())
        end

        if is_night_skip_enabled() then

            -- Skip the night and let all players stand up
            skip_night()
            kick_players()

        end

    end)

end

local function on_rightclick(pos, player)

    -- Adapted from beds/functions.lua

    local name = player:get_player_name()
    local ppos = player:get_pos()
    local tod = core.get_timeofday()

    if tod > day_interval_table.start and tod < day_interval_table.finish then

        if beds_player_table[name] then
            lay_down(player, nil, nil, false)
        end

        core.chat_send_player(name, S("You can only sleep at night!"))
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
        schedule_update()
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
-- Local functions (from beds/api.lua)
---------------------------------------------------------------------------------------------------

local function remove_no_destruct(pos)

    -- Removes a node without calling on on_destruct()
    -- We use this to mess with bed nodes without causing unwanted recursion

    core.swap_node(pos, {name = "air"})
    -- Now clear the meta
    core.remove_node(pos)
    core.check_for_falling(pos)

end

local function destruct_bed(pos, n)

    -- Adapted from beds/api.lua

    local node = core.get_node(pos)
    local other

    if n == 2 then

        local dir = core.facedir_to_dir(node.param2)
        other = vector.subtract(pos, dir)

    elseif n == 1 then

        local dir = core.facedir_to_dir(node.param2)
        other = vector.add(pos, dir)

    end

    local other_name = core.get_node(other).name
    if core.get_item_group(other_name, "bed") ~= 0 then

       remove_no_destruct(other)
       remove_spawns_at(pos)
       remove_spawns_at(other)

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_beds.register_bed(data_table)

    -- Adapted from beds/api.lua
    -- Register a bed
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary"
    --      orig_name_list (list or nil): e.g. {"beds:bed_bottom", "beds:bed_top"},
    --      recipe_table (table): The craft recipe for the bed
    --      tile_table (table): Table with the fields .bottom and .top, each containing a list of
    --          tiles
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burntime (int): e.g. 12
    --      description (str): e.g. "Ordinary Bed"
    --      inventory_image (str): Inventory texture
    --      node_table (table): Table used as the .node_box field in the core.register_node() call
    --      select_table (table): Table used as the .selection_box field in the core.register_node()
    --          call
    --      wield_image (str): Wield texture
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name_list = data_table.orig_name_list or {nil, nil}
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

    if unilib.setting.bed_bouncy_flag then

        bottom_group_table.bouncy = 85
        bottom_group_table.fall_damage_add_percent = -40
        top_group_table.bouncy = 85
        top_group_table.fall_damage_add_percent = -40

    end

    -- Register nodes. The bottom section of the bed is the clickable one
    unilib.register_node(full_name .. "_bottom", orig_name_list[1], replace_mode, {
        description = description,
        tiles = tile_table.bottom,
        groups = bottom_group_table,
        sounds = data_table.sounds or unilib.global.sound_table.wood,

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
            local node = core.get_node(under)
            local udef = core.registered_nodes[node.name]
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

            if core.is_protected(pos, player_name) and
                    not core.check_player_privs(player_name, "protection_bypass") then

                core.record_protection_violation(pos, player_name)
                return itemstack

            end

            local node_def = core.registered_nodes[core.get_node(pos).name]
            if not node_def or not node_def.buildable_to then
                return itemstack
            end

            local dir = placer and placer:get_look_dir() and
                    core.dir_to_facedir(placer:get_look_dir()) or 0
            local botpos = vector.add(pos, core.facedir_to_dir(dir))

            if core.is_protected(botpos, player_name) and
                    not core.check_player_privs(player_name, "protection_bypass") then

                core.record_protection_violation(botpos, player_name)
                return itemstack

            end

            local botdef = core.registered_nodes[core.get_node(botpos).name]
            if not botdef or not botdef.buildable_to then
                return itemstack
            end

            core.set_node(pos, {name = full_name .. "_bottom", param2 = dir})
            core.set_node(botpos, {name = full_name .. "_top", param2 = dir})

            if not unilib.utils.is_creative(player_name) then
                itemstack:take_item()
            end

            return itemstack

        end,

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

            on_rightclick(pos, clicker)
            return itemstack

        end,

        on_rotate = function(pos, node, user, _, new_param2)

            local dir = core.facedir_to_dir(node.param2)
            -- Old position of the top node
            local p = vector.add(pos, dir)
            local node2 = core.get_node_or_nil(p)
            if not node2 or
                    core.get_item_group(node2.name, "bed") ~= 2 or
                    node.param2 ~= node2.param2 then
                return false
            end

            if core.is_protected(p, user:get_player_name()) then

                core.record_protection_violation(p, user:get_player_name())
                return false

            end

            if new_param2 % 32 > 3 then
                return false
            end

            -- New position of the top node
            local newp = vector.add(pos, core.facedir_to_dir(new_param2))
            local node3 = core.get_node_or_nil(newp)
            local node_def = node3 and core.registered_nodes[node3.name]
            if not node_def or not node_def.buildable_to then
                return false
            end

            if core.is_protected(newp, user:get_player_name()) then

                core.record_protection_violation(newp, user:get_player_name())
                return false

            end

            node.param2 = new_param2
            remove_no_destruct(p)
            core.set_node(pos, node)
            core.set_node(newp, {name = full_name .. "_top", param2 = new_param2})
            return true

        end,
    })

    unilib.register_node(full_name .. "_top", orig_name_list[2], replace_mode, {
        -- (no description)
        tiles = tile_table.top,
        groups = top_group_table,
        sounds = unilib.global.sound_table.wood,

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

            local node = core.get_node(pos)
            local dir = core.facedir_to_dir(node.param2)
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
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_beds.init()

    return {
        description = "Shared functions for beds (from minetest_game/beds)",
    }

end

function unilib.pkg.shared_beds.exec()

    -- (Callbacks from beds/functions.lua)
    --------------------------------------

    -- Respawn player on a bed, if enabled and if a valid position is found
    if unilib.setting.bed_respawn_flag then

        -- Adapted from beds/functions.lua

        if spawn ~= nil and spawn.register_on_spawn ~= nil then

            -- Use the minetest_game/spawn API, if available
            spawn.register_on_spawn(function(player, is_new)

                local pos = beds_spawn_table[player:get_player_name()]
                if pos then

                    player:set_pos(pos)
                    return true

                end

            end)

        else

            -- Otherwise, use the previous minetest_game code as a fallback
            core.register_on_respawnplayer(function(player)

                local pos = beds_spawn_table[player:get_player_name()]
                if pos then

                    player:set_pos(pos)
                    return true

                end

            end)

        end

    end

    core.register_on_leaveplayer(function(player)

        -- Adapted from beds/functions.lua

        local name = player:get_player_name()
        lay_down(player, nil, nil, false, true)
        beds_player_table[name] = nil

        -- Skip the night and let all players stand up
        if check_in_beds() then
            schedule_update()
        end

    end)

    core.register_on_dieplayer(function(player)

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

    core.register_on_player_receive_fields(function(player, formname, fields)

        -- Adapted from beds/functions.lua

        if formname ~= "beds_form" then
            return
        end

        -- Notes from neds:
        -- Because "Force night skip" button is a button_exit, it will set fields.quit and lay_down
        --      call will change value of player_in_bed, so it must be taken earlier
        local last_player_in_bed = get_player_in_bed_count()

        if fields.quit or fields.leave then

            lay_down(player, nil, nil, false)
            update_formspecs(false)

        end

        if fields.force then

            local is_majority = (#core.get_connected_players() / 2) < last_player_in_bed
            if is_majority and is_night_skip_enabled() then

                update_formspecs(true)
                skip_night()
                kick_players()

            else

                update_formspecs(false)

            end

        end

    end)

    -- Set up
    read_spawns()

end
