---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- magnet_get_base.lua
--      Set up Minecraft-style item get. Code adapted from the "item_drop" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of connected players and their current auto-get status. This table (and the associated
--      player attribute) can be updated by a call to unilib.magnet.toggle_player_auto_get()
--  Keys are player names; the corresponding value is true if auto-get is enabled, false otherwise
local player_auto_get_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_auto_get()

    local pickup_gain = unilib.setting.magnet_auto_get_volume
    local pickup_particle = unilib.setting.magnet_auto_get_particle_flag
    local pickup_radius = unilib.setting.magnet_auto_get_radius
    local magnet_radius = unilib.setting.magnet_auto_fly_radius
    local magnet_time = unilib.setting.magnet_auto_fly_time
    local pickup_age = unilib.setting.magnet_auto_get_delay
    local key_triggered = unilib.setting.magnet_get_key_flag
    local key_invert = unilib.setting.magnet_no_get_key_flag ~= false

    local keytype
    if key_triggered then

        keytype = unilib.setting.magnet_get_key_type or "Use"

        -- Disable pickup age if picking is explicitly enabled by the player
        if not key_invert then
            pickup_age = math.min(pickup_age, 0)
        end

    end

    local mouse_pickup = unilib.setting.magnet_click_get_flag ~= false
    if not mouse_pickup then
        core.registered_entities["__builtin:item"].pointable = false
    end

    local magnet_mode = magnet_radius > pickup_radius
    local zero_velocity_mode = pickup_age == -1
    if magnet_mode and zero_velocity_mode then

        unilib.utils.show_error(
            "../lib/effects/magnet/magnet_get_base.lua, do_auto_get():" ..
                    " Zero velocity mode can't be used together with magnet mode"
        )

        return

    end

    -- Determines whether an inventorycube should be shown as pickup_particle for known drawtypes or
    --      not
    local inventorycube_drawtypes = {
        normal = true,
        allfaces = true,
        allfaces_optional = true,
        glasslike = true,
        glasslike_framed = true,
        glasslike_framed_optional = true,
        liquid = true,
        flowingliquid = true,
    }

    -- Get an image string from a tile definition
    local function tile_to_image(tile, fallback_image)

        if not tile then
            return fallback_image
        end

        local tile_type = type(tile)
        if tile_type == "string" then
            return tile
        end

        if tile_type ~= "table" then

            unilib.utils.show_error(
                "../lib/effects/magnet/magnet_get_base.lua, do_auto_get():" ..
                        " Tile definition is not a string or table"
            )

            return

        end

        local image = tile.name or tile.image
        if image == nil then

            unilib.utils.show_error(
                "../lib/effects/magnet/magnet_get_base.lua, do_auto_get():" ..
                        " Tile definition has no image file specified"
            )

            return

        end

        if tile.color then

            local colour_str = core.colorspec_to_colorstring(tile.color)
            if colour_str then
                return image .. "^[multiply:" .. colour_str
            end

        end

        return image

    end

    -- Add the item to the inventory and removes the object
    local function collect_item(ent, pos, player)

        unilib.magnet.before_collect(ent, pos, player)
        core.sound_play(
            "unilib_item_drop_pickup",
            {
                pos = pos,
                gain = pickup_gain,
            },
            true
        )

        if pickup_particle then

            local item = core.registered_nodes[ent.itemstring:gsub("(.*)%s.*$", "%1")]
            local image

            if item and item.tiles and item.tiles[1] then

                if inventorycube_drawtypes[item.drawtype] then

                    local tiles = item.tiles
                    -- Colour in the tile definition is handled by tile_to_image
                    -- Colour in the node definition is not yet supported here
                    local top = tile_to_image(tiles[1])
                    local left = tile_to_image(tiles[3], top)
                    local right = tile_to_image(tiles[5], left)
                    image = core.inventorycube(top, left, right)

                else

                    image = item.inventory_image or item.tiles[1]

                end

                core.add_particle({
                    acceleration = {x = 0, y = -4, z = 0},
                    expirationtime = 0.2,
                    pos = {x = pos.x, y = pos.y + 1.5, z = pos.z},
                    size = 3,
                    texture = image,
                    velocity = {x = 0, y = 1, z = 0},
                    vertical = false,
                })

            end

        end

        ent:on_punch(player)
        unilib.magnet.after_collect(ent, pos, player)

    end

    -- opt_get_ent() gets the object's luaentity if it can be collected
    local opt_get_ent
    if zero_velocity_mode then

        function opt_get_ent(object)

            if object:is_player() or
                    not vector.equals(object:get_velocity(), {x = 0, y = 0, z = 0}) then
                return
            end

            local ent = object:get_luaentity()
            if not ent or
                    ent.name ~= "__builtin:item" or
                    ent.itemstring == "" then
                return
            end

            return ent

        end

    else

        function opt_get_ent(object)

            if object:is_player() then
                return
            end

            local ent = object:get_luaentity()
            if not ent or
                    ent.name ~= "__builtin:item" or
                    (ent.dropped_by and ent.age < pickup_age) or
                    ent.itemstring == "" then
                return
            end

            return ent

        end

    end

    local afterflight
    if magnet_mode then

        -- Take item or reset velocity after flying a second
        function afterflight(object, inv, player)

            local ent = opt_get_ent(object)
            if not ent then
                return
            end

            local item = ItemStack(ent.itemstring)
            if inv and
                    inv:room_for_item("main", item) and
                    unilib.magnet.can_pickup(ent, player) then

                collect_item(ent, object:get_pos(), player)

            else

                -- The acceleration will be reset by the object's on_step
                object:set_velocity({x = 0, y = 0, z = 0})
                ent.is_magnet_item = false

            end

        end

        -- Disable velocity and acceleration changes of items flying to players
        -- N.B. This code has been moved to ../lib/effects/builtin/builtin_item.lua
        --[[
        core.after(0, function()

            local ObjectRef
            local blocked_methods = {
                "set_acceleration", "set_velocity", "setacceleration", "setvelocity"
            }
            local itemdef = core.registered_entities["__builtin:item"]
            local old_on_step = itemdef.on_step
            local function do_nothing() end

            function itemdef.on_step(self, ...)

                if not self.is_magnet_item then
                    return old_on_step(self, ...)
                end

                ObjectRef = ObjectRef or getmetatable(self.object)
                local old_funcs = {}
                for i = 1, #blocked_methods do

                    local method = blocked_methods[i]
                    old_funcs[method] = ObjectRef[method]
                    ObjectRef[method] = do_nothing

                end

                old_on_step(self, ...)
                for i = 1, #blocked_methods do

                    local method = blocked_methods[i]
                    ObjectRef[method] = old_funcs[method]

                end

            end

        end)
        ]]--

    end

    -- Set keytype to the key name if possible
    if keytype == "Use" then
        keytype = "aux1"
    elseif keytype == "Sneak" then
        keytype = "sneak"
    elseif keytype == "LeftAndRight" then       -- LeftAndRight combination
        keytype = 0
    elseif keytype == "SneakAndRMB" then        -- SneakAndRMB combination
        keytype = 1
    end

    -- Test if the player has the keys pressed to enable item picking
    local function has_keys_pressed(player)

        if not key_triggered then
            return true
        end

        local control = player:get_player_control()
        local keys_pressed

        if keytype == 0 then                    -- LeftAndRight combination
            keys_pressed = control.left and control.right
        elseif keytype == 1 then                -- SneakAndRMB combination
            keys_pressed = control.sneak and control.RMB
        else
            keys_pressed = control[keytype]
        end

        return keys_pressed ~= key_invert

    end

    local function is_inside_map(pos)

        local bound = unilib.constant.y_max
        return -bound < pos.x and pos.x < bound and
                -bound < pos.y and pos.y < bound and
                -bound < pos.z and pos.z < bound

    end

    -- Called for each player to possibly collect an item, returns true if so
    local function pickupfunc(player)

        if not has_keys_pressed(player) or
                not core.get_player_privs(player:get_player_name()).interact or
                player:get_hp() <= 0 then
            return
        end

        local pos = player:get_pos()
        if not is_inside_map(pos) then

            -- get_objects_inside_radius() crashes for positions too far away
            return

        end

        pos.y = pos.y + 0.5
        local inv = player:get_inventory()
        local objectlist = core.get_objects_inside_radius(
            pos,
            magnet_mode and magnet_radius or pickup_radius
        )

        for i = 1, #objectlist do

            local object = objectlist[i]
            local ent = opt_get_ent(object)
            if ent and unilib.magnet.can_pickup(ent, player) then

                local item = ItemStack(ent.itemstring)
                if inv:room_for_item("main", item) then

                    local flying_item
                    local pos2
                    if magnet_mode then

                        pos2 = object:get_pos()
                        flying_item = vector.distance(pos, pos2) > pickup_radius

                    end

                    if not flying_item then

                        -- The item is near enough to pick it
                        collect_item(ent, pos, player)
                        -- Collect one item at a time to avoid the loud pop
                        return true

                    end

                    -- The item is not too far a way but near enough to be magnetised, make it fly
                    --      to the player
                    local vel = vector.multiply(vector.subtract(pos, pos2), 3)
                    vel.y = vel.y + 0.6
                    object:set_velocity(vel)
                    if not ent.is_magnet_item then

                        ent.object:set_acceleration({x = 0, y = 0, z = 0})
                        ent.is_magnet_item = true

                        core.after(magnet_time, afterflight, object, inv, player)

                    end

                end

            end

        end

    end

    local function pickup_step()

        -- (Original code)
        --[[
        local got_item
        local players = core.get_connected_players()
        for i = 1, #players do
            got_item = got_item or pickupfunc(players[i])
        end
        ]]--

        -- (Modified unilib code, to enable toggling auto-get on a per-player basis)
        local got_item
        for pname, auto_get_flag in pairs(player_auto_get_table) do

            if auto_get_flag then
                got_item = got_item or pickupfunc(core.get_player_by_name(pname))
            end

        end

        -- Lower step if takeable item(s) were found
        local time
        if got_item then
            time = 0.02
        else
            time = 0.2
        end

        core.after(time, pickup_step)

    end

    core.after(3.0, pickup_step)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (toggle magnet effects on a per-player basis)
---------------------------------------------------------------------------------------------------

function unilib.magnet.toggle_player_auto_get(pname)

    -- Enables/disables auto-get on a per-player basis, updating both the cached table of players
    --      used by code in this file, and the associated player attribute
    -- Returns true if auto-get is enabled, false if it is disabled (or if the specified player is
    --      not connected)

    if player_auto_get_table[pname] == nil then

        return false

    elseif player_auto_get_table[pname] == false then

        player_auto_get_table[pname] = true
        unilib.utils.set_player_attribute(
            core.get_player_by_name(pname), "auto_get_flag", "true"
        )

    else

        player_auto_get_table[pname] = false
        unilib.utils.set_player_attribute(
            core.get_player_by_name(pname), "auto_get_flag", "false"
        )

    end

    return player_auto_get_table[pname]

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Set up Minecraft-style item get
core.register_on_joinplayer(function(player)

    local pname = player:get_player_name()
    local pattrib = unilib.utils.get_player_attribute(player, "auto_get_flag")
    if pattrib == "" or pattrib == "true" then
        player_auto_get_table[pname] = true
    else
        player_auto_get_table[pname] = false
    end

end)

core.register_on_leaveplayer(function(player)

    local pname = player:get_player_name()
    player_auto_get_table[pname] = nil

end)

do_auto_get()
