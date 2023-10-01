---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- player_api_wrapper.lua
--      Replicates the API of ../shared/player_api.lua, passing on calls to minetest_game/player_api
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Create namespace for imported player_api code
unilib.player_api = {}

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

function unilib.player_api.register_model(name, def)

    return player_api.register_model(name, def)

end

function unilib.player_api.get_animation(player)

    return player_api.get_animation(player)

end

function unilib.player_api.set_model(player, model_name)

    return player_api.set_model(player, model_name)

end

function unilib.player_api.set_textures(player, textures)

    return player_api.set_textures(player, textures)

end

function unilib.player_api.set_animation(player, anim_name, speed)

    return player_api.set_animation(player, anim_name, speed)

end
