---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- privs.lua
--      Registers privileges
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register privileges
---------------------------------------------------------------------------------------------------

-- Three privileges for unilib chat commands, for the benefit of unilib developers, remix/package
--      writers and so on (but which might not be suitable to ordinary players on servers)
--
--      unilib_tools - automatically granted to admin/singleplayer
--      unilib_admin - automatically granted to admin
--      unilib_danger - not automatically granted; chat commands that could damage a world, if
--          used unwisely
--
-- N.B. Commands requiring "unilib_admin" or "unilib_danger" cannot be run by offline players
--      (e.g. via an IRC bridge)

minetest.register_privilege("unilib_tools", {
    description = "Allow use of simple unilib chat commands",

    give_to_admin = true,
    give_to_singleplayer = true,

    on_grant = function(name, granter_name)
        return false
    end,

    on_revoke = function(name, revoker_name)
        return false
    end,
})

minetest.register_privilege("unilib_admin", {
    description = "Allow use of administrative unilib chat commands",

    give_to_admin = true,
    give_to_singleplayer = false,

    on_grant = function(name, granter_name)
        return false
    end,

    on_revoke = function(name, revoker_name)
        return false
    end,
})

minetest.register_privilege("unilib_danger", {
    description = "Allow use of dangerous unilib chat commands",

    give_to_admin = true,
    give_to_singleplayer = false,

    on_grant = function(name, granter_name)
        return false
    end,

    on_revoke = function(name, revoker_name)
        return false
    end,
})
