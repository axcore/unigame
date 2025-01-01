---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- player_api_local.lua
--      unilib's version of minetest_game/player_api
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Local versions of minetest_game/player_api variables, preserving their original names
unilib.player_api.player_attached = {}
unilib.player_api.registered_models = {}
-- (Use local for speed; was "models")
local model_table = unilib.player_api.registered_models

-- Player animation blending (currently broken due to a bug in Irrlicht, leave at 0)
local animation_blend = 0
-- Player stats and animations (was "players")
local player_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions (from player_api/api.lua)
---------------------------------------------------------------------------------------------------

local function collisionbox_equals(collisionbox, other_collisionbox)

    if collisionbox == other_collisionbox then
        return true
    end

    for index = 1, 6 do

        if collisionbox[index] ~= other_collisionbox[index] then
            return false
        end

    end

    return true

end

local function get_player_data(player)
    return assert(player_table[player:get_player_name()])
end

---------------------------------------------------------------------------------------------------
-- Accessors (original to unilib)
---------------------------------------------------------------------------------------------------

function unilib.player_api._get_registered_model(key)

    return model_table[key]

end

function unilib.player_api._set_registered_model(key, value)

    model_table[key] = value

end

function unilib.player_api._get_player_attached(key)

    return unilib.player_api.player_attached[key]

end

function unilib.player_api._set_player_attached(key, value)

    unilib.player_api.player_attached[key] = value

end

---------------------------------------------------------------------------------------------------
-- Functions (from player_api/api.lua)
---------------------------------------------------------------------------------------------------

function unilib.player_api._register_model(name, def_table)

    -- Adapted from player_api/api.lua

    model_table[name] = def_table
    def_table.visual_size = def_table.visual_size or {x = 1, y = 1}
    def_table.collisionbox = def_table.collisionbox or {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3}
    def_table.stepheight = def_table.stepheight or 0.6
    def_table.eye_height = def_table.eye_height or 1.47

    -- Sort animations into property classes:
    -- Animations with same properties have the same _equals value
    for animation_name, animation in pairs(def_table.animations) do

        animation.eye_height = animation.eye_height or def_table.eye_height
        animation.collisionbox = animation.collisionbox or def_table.collisionbox
        animation.override_local = animation.override_local or false
        for _, other_animation in pairs(def_table.animations) do

            if other_animation._equals then

                if collisionbox_equals(animation.collisionbox, other_animation.collisionbox) and
                        animation.eye_height == other_animation.eye_height then

                    animation._equals = other_animation._equals
                    break

                end

            end

        end

        animation._equals = animation._equals or animation_name

    end

end

function unilib.player_api._get_animation(player)

    -- Adapted from player_api/api.lua

    return get_player_data(player)

end

function unilib.player_api._set_model(player, model_name)

    -- Adapted from player_api/api.lua
    -- Called when a player's appearance needs to be updated

    local player_data = get_player_data(player)
    if player_data.model == model_name then
        return
    end

    -- Update data
    player_data.model = model_name
    -- Clear animation data as the model has changed (required so that setting the "stand" animation
    --      is not a no-op)
    player_data.animation, player_data.animation_speed, player_data.animation_loop = nil, nil, nil

    local model = model_table[model_name]
    if model then

        player:set_properties({
            mesh = model_name,
            textures = player_data.textures or model.textures,
            visual = "mesh",
            visual_size = model.visual_size,
            stepheight = model.stepheight,
        })

        -- Sets local_animation, collisionbox & eye_height
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

end

function unilib.player_api._get_textures(player)

    -- Adapted from player_api/api.lua

    local player_data = get_player_data(player)
    local model = model_table[player_data.model]
    return assert(player_data.textures or (model and model.textures))

end

function unilib.player_api._set_textures(player, textures)

    -- Adapted from player_api/api.lua

    local player_data = get_player_data(player)
    local model = model_table[player_data.model]
    local new_textures = assert(textures or (model and model.textures))
    player_data.textures = new_textures
    player:set_properties({textures = new_textures})

end

function unilib.player_api._set_texture(player, index, texture)

    -- Adapted from player_api/api.lua

    local textures = table.copy(player_api.get_textures(player))
    textures[index] = texture
    player_api.set_textures(player, textures)

end

function unilib.player_api._set_animation(player, anim_name, speed, loop)

    -- Adapted from player_api/api.lua

    local player_data = get_player_data(player)
    local model = model_table[player_data.model]
    if not (model and model.animations[anim_name]) then
        return
    end

    --[[
    speed = speed or model.animation_speed
    if player_data.animation == anim_name and player_data.animation_speed == speed then
        return
    end
    ]]--
    speed = speed or model.animation_speed
    if loop == nil then
        loop = true
    end

    if player_data.animation == anim_name and
            player_data.animation_speed == speed and
            player_data.animation_loop == loop then
        return
    end

    local previous_anim = model.animations[player_data.animation] or {}
    local anim = model.animations[anim_name]
    player_data.animation = anim_name
    player_data.animation_speed = speed
    player_data.animation_loop = loop

    -- If necessary change the local animation (only seen by the client of *that* player)
    -- "override_local" <=> suspend local animations while this one is active
    -- (This is basically a hack, proper engine feature needed...)
    if anim.override_local ~= previous_anim.override_local then

        if anim.override_local then

            local none = {x = 0, y = 0}
            player:set_local_animation(none, none, none, none, 1)

        else

            -- (Not specific to the animation being set)
            local a = model.animations

            player:set_local_animation(
                a.stand, a.walk, a.mine, a.walk_mine,
                model.animation_speed or 30
            )

        end

    end

    -- Set the animation seen by everyone else
    player:set_animation(anim, speed, animation_blend, loop)

    -- Update related properties if they changed
    if anim._equals ~= previous_anim._equals then

        player:set_properties({
            collisionbox = anim.collisionbox,
            eye_height = anim.eye_height
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Players leaving (from player_api/api.lua)
---------------------------------------------------------------------------------------------------

core.register_on_joinplayer(function(player)

    -- Adapted from player_api/api.lua

    local name = player:get_player_name()
    player_table[name] = {}
    unilib.player_api.player_attached[name] = false

end)

core.register_on_leaveplayer(function(player)

    -- Adapted from player_api/api.lua

    local name = player:get_player_name()
    player_table[name] = nil
    unilib.player_api.player_attached[name] = nil

end)

-- Prevent knockback for attached players
local old_calculate_knockback = core.calculate_knockback

function core.calculate_knockback(player, ...)

    -- Adapted from player_api/api.lua

    if unilib.player_api.player_attached[player:get_player_name()] then
        return 0
    end

    return old_calculate_knockback(player, ...)

end

-- Check each player and apply animations
function unilib.player_api.globalstep()

    -- Adapted from player_api/api.lua

    for _, player in ipairs(core.get_connected_players()) do

        local name = player:get_player_name()
        local player_data = player_table[name]
        local model = player_data and model_table[player_data.model]

        if model and not unilib.player_api.player_attached[name] then

            local controls = player:get_player_control()
            local animation_speed_mod = model.animation_speed or 30

            -- Determine if the player is sneaking, and reduce animation speed if so
            if controls.sneak then
                animation_speed_mod = animation_speed_mod / 2
            end

            -- Apply animations based on what the player is doing
            if player:get_hp() == 0 then

                unilib.player_api.set_animation(player, "lay")

            elseif controls.up or controls.down or controls.left or controls.right then

                if controls.LMB or controls.RMB then
                    unilib.player_api.set_animation(player, "walk_mine", animation_speed_mod)
                else
                    unilib.player_api.set_animation(player, "walk", animation_speed_mod)
                end

            elseif controls.LMB or controls.RMB then

                unilib.player_api.set_animation(player, "mine", animation_speed_mod)

            else

                unilib.player_api.set_animation(player, "stand", animation_speed_mod)

            end

        end

    end

end

-- Mods can modify the globalstep by overriding player_api.globalstep (use local for speed)
local player_api_globalstep = unilib.player_api.globalstep
core.register_globalstep(function(...)
    player_api_globalstep(player_table, ...)
end)

for _, api_function in pairs({"get_animation", "set_animation", "set_model", "set_textures"}) do

    local original_function = player_api[api_function]
    player_api[api_function] = function(player, ...)

        if not player_table[player:get_player_name()] then

            -- Notes from original mod:
            -- Hack for keeping backwards compatibility
            unilib.utils.log("warning", api_function .. " called on offline player")
            return

        end

        return original_function(player, ...)

    end

end

---------------------------------------------------------------------------------------------------
-- Default player appearance (from player_api/init.lua)
---------------------------------------------------------------------------------------------------

unilib.player_api.register_model("unilib_character.b3d", {
    animation_speed = 30,
    textures = {"unilib_character.png"},
    animations = {
        -- Standard animations
        lay       = {
            x = 162,
            y = 166,
            eye_height = 0.3,
            override_local = true,
            collisionbox = {-0.6, 0.0, -0.6, 0.6, 0.3, 0.6},
        },
        mine      = {x = 189, y = 198},
        sit       = {
            x = 81,
            y = 160,
            eye_height = 0.8,
            override_local = true,
            collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.0, 0.3},
        },
        stand     = {x = 0, y = 79},
        walk      = {x = 168, y = 187},
        walk_mine = {x = 200, y = 219},
    },
    collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
    stepheight = 0.6,
    eye_height = 1.47,
})

---------------------------------------------------------------------------------------------------
-- Update appearance when the player joins (from player_api/init.lua)
---------------------------------------------------------------------------------------------------

core.register_on_joinplayer(function(player)
    unilib.player_api.set_model(player, "unilib_character.b3d")
end)
