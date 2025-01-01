---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- player_api_unilib.lua
--      Wrapper functions for unilib's version of minetest_game/player_api
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Wrapper functions for unilib's version of minetest_game/player_api
local api_file = unilib.core.path_mod .. "/lib/shared/player_api/player_api_local.lua"

function unilib.player_api.get_registered_model(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._get_registered_model(...)

end

function unilib.player_api.set_registered_model(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._set_registered_model(...)

end

function unilib.player_api.get_player_attached(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._get_player_attached(...)

end

function unilib.player_api.set_player_attached(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._set_player_attached(...)

end

function unilib.player_api.register_model(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._register_model(...)

end

function unilib.player_api.get_animation(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._get_animation(...)

end

function unilib.player_api.set_model(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._set_model(...)

end

function unilib.player_api.get_textures(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._get_textures(...)

end

function unilib.player_api.set_textures(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._set_textures(...)

end

function unilib.player_api.set_texture(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._set_texture(...)

end

function unilib.player_api.set_animation(...)

    if not t[api_file] then t[api_file] = true; dofile(api_file) end
    return unilib.player_api._set_animation(...)

end
