---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- player_api.lua
--      Code and shared functions imported from minetest_game/player_api
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- In minetest_game, the following mods require the player_api mod:
--      beds boats carts
-- All code from player_api has been imported here. This file is loaded by a call to
--      unilib.load_player_api(), if any packages need it

-- Create namespace for imported player_api code
unilib.player_api = {}

-- Player animation blending (currently broken due to a bug in Irrlicht, leave at 0)
local animation_blend = 0
-- Player stats and animations
local models = {}
local player_attached = {}
local player_model = {}
local player_textures = {}
local player_anim = {}
local player_sneak = {}

---------------------------------------------------------------------------------------------------
-- Accessors (original to unilib)
---------------------------------------------------------------------------------------------------

function unilib.player_api.get_registered_model(key)

    return models[key]

end

function unilib.player_api.set_registered_model(key, value)

    models[key] = value

end

function unilib.player_api.get_player_attached(key)

    return player_attached[key]

end

function unilib.player_api.set_player_attached(key, value)

    player_attached[key] = value

end

---------------------------------------------------------------------------------------------------
-- Functions (from player_api/api.lua)
---------------------------------------------------------------------------------------------------

function unilib.player_api.register_model(name, def)

    -- Adapted from player_api/api.lua

    models[name] = def

end

function unilib.player_api.get_animation(player)

    -- Adapted from player_api/api.lua

    local name = player:get_player_name()
    return {
        model = player_model[name],
        textures = player_textures[name],
        animation = player_anim[name],
    }

end

function unilib.player_api.set_model(player, model_name)

    -- Adapted from player_api/api.lua
    -- Called when a player's appearance needs to be updated

    local name = player:get_player_name()
    local model = models[model_name]

    if model then

        if player_model[name] == model_name then
            return
        end

        player:set_properties({
            mesh = model_name,
            textures = player_textures[name] or model.textures,
            visual = "mesh",
            visual_size = model.visual_size or {x = 1, y = 1},
            collisionbox = model.collisionbox or {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
            stepheight = model.stepheight or 0.6,
            eye_height = model.eye_height or 1.47,
        })
        unilib.player_api.set_animation(player, "stand")

    else

        player:set_properties({
            textures = {"unilib_player_front.png", "unilib_player_back.png"},
            visual = "upright_sprite",
            visual_size = {x = 1, y = 2},
            collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3},
            stepheight = 0.6,
            eye_height = 1.625,
        })

    end

    player_model[name] = model_name

end

function unilib.player_api.set_textures(player, textures)

    -- Adapted from player_api/api.lua

    local name = player:get_player_name()
    local model = models[player_model[name]]
    local model_textures = model and model.textures or nil
    player_textures[name] = textures or model_textures
    player:set_properties({textures = textures or model_textures})

end

function unilib.player_api.set_animation(player, anim_name, speed)

    -- Adapted from player_api/api.lua

    local name = player:get_player_name()
    if player_anim[name] == anim_name then
        return
    end

    local model = player_model[name] and models[player_model[name]]
    if not (model and model.animations[anim_name]) then
        return
    end

    local anim = model.animations[anim_name]
    player_anim[name] = anim_name
    player:set_animation(anim, speed or model.animation_speed, animation_blend)

end

---------------------------------------------------------------------------------------------------
-- Players leaving (from player_api/api.lua)
---------------------------------------------------------------------------------------------------

minetest.register_on_leaveplayer(function(player)

    -- Adapted from player_api/api.lua

    local name = player:get_player_name()
    player_model[name] = nil
    player_anim[name] = nil
    player_textures[name] = nil
    player_sneak[name] = nil
    player_attached[name] = nil

end)

-- Localise for better performance.
local player_set_animation = unilib.player_api.set_animation
local player_attached = player_attached
-- Prevent knockback for attached players
local old_calculate_knockback = minetest.calculate_knockback

function minetest.calculate_knockback(player, ...)

    -- Adapted from player_api/api.lua

    if player_attached[player:get_player_name()] then
        return 0
    end
    return old_calculate_knockback(player, ...)

end

-- Check each player and apply animations
minetest.register_globalstep(function()

    -- Adapted from player_api/api.lua

    for _, player in pairs(minetest.get_connected_players()) do

        local name = player:get_player_name()
        local model_name = player_model[name]
        local model = model_name and models[model_name]

        if model and not player_attached[name] then

            local controls = player:get_player_control()
            local animation_speed_mod = model.animation_speed or 30

            -- Determine if the player is sneaking, and reduce animation speed if so
            if controls.sneak then
                animation_speed_mod = animation_speed_mod / 2
            end

            -- Apply animations based on what the player is doing
            if player:get_hp() == 0 then

                player_set_animation(player, "lay")

            -- Determine if the player is walking
            elseif controls.up or controls.down or controls.left or controls.right then

                if player_sneak[name] ~= controls.sneak then

                    player_anim[name] = nil
                    player_sneak[name] = controls.sneak

                end

                if controls.LMB or controls.RMB then
                    player_set_animation(player, "walk_mine", animation_speed_mod)
                else
                    player_set_animation(player, "walk", animation_speed_mod)
                end

            elseif controls.LMB or controls.RMB then

                player_set_animation(player, "mine", animation_speed_mod)

            else

                player_set_animation(player, "stand", animation_speed_mod)

            end

        end

    end

end)

---------------------------------------------------------------------------------------------------
-- Default player appearance (from player_api/init.lua)
---------------------------------------------------------------------------------------------------

unilib.player_api.register_model("unilib_character.b3d", {
    animation_speed = 30,
    textures = {"unilib_character.png"},
    animations = {
        -- Standard animations.
        stand     = {x = 0,   y = 79},
        lay       = {x = 162, y = 166},
        walk      = {x = 168, y = 187},
        mine      = {x = 189, y = 198},
        walk_mine = {x = 200, y = 219},
        sit       = {x = 81,  y = 160},
    },
    collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
    stepheight = 0.6,
    eye_height = 1.47,
})

---------------------------------------------------------------------------------------------------
-- Update appearance when the player joins (from player_api/init.lua)
---------------------------------------------------------------------------------------------------

minetest.register_on_joinplayer(function(player)
    player_attached[player:get_player_name()] = false
    unilib.player_api.set_model(player, "unilib_character.b3d")
    player:set_local_animation(
        {x = 0,   y = 79},
        {x = 168, y = 187},
        {x = 189, y = 198},
        {x = 200, y = 219},
        30
    )
end)
