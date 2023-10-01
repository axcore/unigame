---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- test.lua
--      Set up chat commands for teleporting to arbitrary locations
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Instant teleportation on a world, seed "test", mapgen v7
-- /start1: Teleports to a start position
-- /start2: Teleports to a start position
-- /start3: Teleports to a start position
-- /bay: Teleports to a location with many trees
-- /coral: Teleports to a location with coral
-- /dale: Teleports to a location with valleys
-- /jungle: Teleports to a location with a jungle
-- /meadow: Teleports to a location with flat land
---------------------------------------------------------------------------------------------------

minetest.register_chatcommand("start1", {
    params = "",
    description = S("Teleports to a start position in v7 map, seed \"test\""),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_pos({x = -192, y = 7, z = -192})

    end,
})

minetest.register_chatcommand("start2", {
    params = "",
    description = S("Teleports to a start position in v7 map, seed \"test\""),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_pos({x = -64, y = 10, z = -576})

    end,
})

minetest.register_chatcommand("start3", {
    params = "",
    description = S("Teleports to a start position in v7 map, seed \"test\""),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_pos({x = 0, y = 9, z = 0})

    end,
})

minetest.register_chatcommand("bay", {
    params = "",
    description = S("Teleports to a location with many trees v7 map, seed \"test\""),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_pos({x = 4999, y = 5, z = 5000})

    end,
})

minetest.register_chatcommand("coral", {
    params = "",
    description = S("Teleports to a location with coral v7 map, seed \"test\""),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_pos({x = -1130, y = 3, z = 1050})

    end,
})

minetest.register_chatcommand("dale", {
    params = "",
    description = S("Teleports to a location with valleys v7 map, seed \"test\""),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_pos({x = -65, y = 11, z = 1578})

    end,
})

minetest.register_chatcommand("jungle", {
    params = "",
    description = S("Teleports to a location with a jungle v7 map, seed \"test\""),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_pos({x = 2967, y = 2, z = 17})

    end,
})

minetest.register_chatcommand("meadow", {
    params = "",
    description = S("Teleports to a location with flat land v7 map, seed \"test\""),
    privs = {unilib_admin = true},

    func = function(name, param)

        if not minetest.get_player_by_name(name) then
            return false, unilib.chat_offline_msg
        end

        local player = minetest.get_player_by_name(name)
        player:set_pos({x = 0, y = 18, z = -1500})

    end,
})
