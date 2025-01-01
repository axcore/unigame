---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.chat_teleport = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.chat_teleport.init()

    return {
        description = "Chat commands /start1, /start2, /start3, /bay, /coral, /dale, /jungle," ..
                " /meadow",
        notes = "Chat commands for instant teleportation on a world, seed \"test\", mapgen v7",
    }

end

function unilib.pkg.chat_teleport.exec()

    core.register_chatcommand("start1", {
        params = "",
        description = S("Teleports to a start position in v7 map, seed \"test\""),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_pos({x = -192, y = 7, z = -192})
            end

        end,
    })

    core.register_chatcommand("start2", {
        params = "",
        description = S("Teleports to a start position in v7 map, seed \"test\""),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_pos({x = -64, y = 10, z = -576})
            end

        end,
    })

    core.register_chatcommand("start3", {
        params = "",
        description = S("Teleports to a start position in v7 map, seed \"test\""),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_pos({x = 0, y = 9, z = 0})
            end

        end,
    })

    core.register_chatcommand("bay", {
        params = "",
        description = S("Teleports to a location with many trees v7 map, seed \"test\""),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_pos({x = 4999, y = 5, z = 5000})
            end

        end,
    })

    core.register_chatcommand("coral", {
        params = "",
        description = S("Teleports to a location with coral v7 map, seed \"test\""),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_pos({x = -1130, y = 3, z = 1050})
            end

        end,
    })

    core.register_chatcommand("dale", {
        params = "",
        description = S("Teleports to a location with valleys v7 map, seed \"test\""),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_pos({x = -65, y = 11, z = 1578})
            end

        end,
    })

    core.register_chatcommand("jungle", {
        params = "",
        description = S("Teleports to a location with a jungle v7 map, seed \"test\""),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_pos({x = 2967, y = 2, z = 17})
            end

        end,
    })

    core.register_chatcommand("meadow", {
        params = "",
        description = S("Teleports to a location with flat land v7 map, seed \"test\""),
        privs = {unilib_admin = true},

        func = function(name, param)

            local player = core.get_player_by_name(name)
            if not player then
                return false, unilib.constant.chat_offline_msg
            else
                player:set_pos({x = 0, y = 18, z = -1500})
            end

        end,
    })

end
