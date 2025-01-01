---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- player_api_mtgame.lua
--      Wrapper functions for minetest_game/player_api
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Pointers to minetest_game/player_api tables
unilib.player_api.registered_models = player_api.registered_models
unilib.player_api.player_attached = player_api.player_attached

---------------------------------------------------------------------------------------------------
-- Accessors (original to unilib)
---------------------------------------------------------------------------------------------------

function unilib.player_api.get_registered_model(key)

    return player_api.registered_models[key]

end

function unilib.player_api.set_registered_model(key, value)

    player_api.registered_models[key] = value

end

function unilib.player_api.get_player_attached(key)

    return player_api.player_attached[key]

end

function unilib.player_api.set_player_attached(key, value)

    player_api.player_attached[key] = value

end

---------------------------------------------------------------------------------------------------
-- Wrapper functions (calling player_api/api.lua)
---------------------------------------------------------------------------------------------------

function unilib.player_api.register_model(name, def_table)

    return player_api.register_model(name, def_table)

end

function unilib.player_api.get_animation(player)

    return player_api.get_animation(player)

end

function unilib.player_api.set_model(player, model_name)

    return player_api.set_model(player, model_name)

end

function unilib.player_api.get_textures(player)

    return player_api.get_textures(player)

end

function unilib.player_api.set_textures(player, textures)

    return player_api.set_textures(player, textures)

end

function unilib.player_api.set_texture(player, index, texture)

    return player_api.set_texture(player, index, texture)

end

function unilib.player_api.set_animation(player, anim_name, speed, loop)

    return player_api.set_animation(player, anim_name, speed, loop)

end
