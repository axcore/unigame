---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc_harm_bars.lua
--      Provide the API from the "vis_harm_1nd" mod, allowing harm bars to be drawn above players
--          and mobs
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib

-- Localise math functions (for speed)
local floor = math.floor

-- Default size of the harm bar
local default_size_table = {x = 0.8, y = 0.1}

-- Table of objects to which a harm bar entity has been attached, in the form
--      harm_bar_table[obj] = harm_bar_entity
local harm_bar_table = {}
-- Reverse lookup table for harm bar entities, in the form
--      rev_harm_bar_table[harm_bar_entity] = obj
local rev_harm_bar_table = {}

-- Table of bar entities that are due to be removed, their mobs having regained full health
-- Table in the form
--      clear_table[entity] = remaining_time
local clear_table = {}
-- Delay before removing a harm bar (in seconds); the actual delay is usually twice this value
local clear_interval = 1

-- N.B. Originally {"_VH1_barheight", "_VH1_barheight", "_VH1_nohpbar"}
-- Mobs can be given these properties, in order to customise the size and position of the harm bar,
--      or to disable it altogether
local harm_prop_list = {"harm_bar_height", "harm_bar_size", "harm_bar_disable_flag"}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function retrieve_harm_props(ent_def_table)

    -- Was get_props()

    if not ent_def_table then
        return {}
    end

    local return_table = {}
    for _, prop in ipairs(harm_prop_list) do
        return_table[prop] = ent_def_table[prop]
    end

    return return_table

end

local function set_harm_bar(bar_ent, hp, hp_max)

    -- Was set_bar()

    local suffix = "^[transformR270"
    local percent = floor(hp / hp_max * 100)
    if percent <= 0 then

        -- Nothing to set
        bar_ent:set_texture_mod(suffix)
        return

    end

    --[[
    if percent > 100 then

        -- If HP is more than the maximum, use yellow bar (as a visual indication for developers;
        --      light green in original code)
        percent = 100
--      suffix = suffix .. "^[colorize:#FFFFFF:160"
        suffix = suffix .. "^[colorize:#FFFF00:160"

    elseif percent == 100 then

        -- If full health has been restored, start a 1 second timer to clear the bar
        clear_table[bar_ent] = 1.0

    else

        -- HP is below maximum, don't clear the bar (if it was due to be cleared)
        clear_table[bar_ent] = nil

    end
    ]]--
    -- N.B. Fixed what appears to be faulty logic in the original code (replacing code above)
    if percent > 100 then

        -- If HP is more than the maximum, use yellow bar (as a visual indication for developers;
        --      light green in original code)
        percent = 100
--      suffix = suffix .. "^[colorize:#FFFFFF:160"
        suffix = suffix .. "^[colorize:#FFFF00:160"

    elseif percent < 100 then

        -- HP is below maximum, don't clear the bar (if it was due to be cleared)
        clear_table[bar_ent] = nil

    elseif clear_table[bar_ent] == nil then

        -- If full health has been restored, start a 1 second timer to clear the bar
        clear_table[bar_ent] = clear_interval

    end

    bar_ent:set_texture_mod(
        "^[lowpart:" .. tostring(percent) .. ":unilib_entity_harm_bar_full.png" .. suffix
    )

end

local function add_harm_bar(obj, hp, hp_max, height, harm_prop_table)

    -- Was add_bar()

    -- Create the harm bar entity, and register it
    local bar_ent = core.add_entity(obj:get_pos(), "unimobs:entity_harm_bar")
    set_harm_bar(bar_ent, hp, hp_max)
    harm_bar_table[obj] = bar_ent
    rev_harm_bar_table[bar_ent] = obj

    -- Attach the harm bar entity to the mob at an appropriate height
    local harm_bar_height = height
    if harm_prop_table.harm_bar_height then
        harm_bar_height = harm_prop_table.harm_bar_height
    end

    bar_ent:set_attach(obj, "", vector.new(0, harm_bar_height, 0))

    -- Adjust the size of the harm bar to match the mob's .visual_size
    if harm_prop_table.harm_bar_size then

        local obj_prop_table = bar_ent:get_properties()
        obj_prop_table.visual_size = {
            x = harm_prop_table.harm_bar_size.x or default_size_table.x,
            y = harm_prop_table.harm_bar_size.y or default_size_table.y,
        }

        bar_ent:set_properties(obj_prop_table)

    end

    return bar_ent

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unimobs.misc_api.update_harm_bar(obj, hp, hp_max)

    -- Was VH1.update_bar()
    -- Should be called whenever an object's HP changes; A harm bar entity will be created if one
    --      does not yet exist for the specified "obj"
    -- The "hp" and "hp_max" arguments are optional. If not specified, the built-in obj:get_hp() and
    --      obj:get_properties().max_hp values are used instead

    if not obj then
        return
    end

    local ent_name = obj:get_luaentity().name or obj:get_entity_name()
    local ent_def_table = core.registered_entities[ent_name]
    local obj_prop_table = obj:get_properties()

    -- Retrieve the .harm_bar_height, .harm_bar_size and .harm_bar_disable_flag properties from obj,
    --      in a convenient table
    local harm_prop_table = retrieve_harm_props(ent_def_table)
    if harm_prop_table.nohpbar == true then
        return
    end

    -- Use default values for unspecified arguments
    if not hp then
        hp = obj:get_hp()
    end

    if not hp_max then
        hp_max = obj_prop_table.hp_max
    end

    --[[
    local bar_ent = harm_bar_table[obj]
    if not bar_ent then

        -- Set default bar height, just over the top of the collision box
        local height = (obj_prop_table.collisionbox[5] * 10) + 5
        if obj_prop_table.visual_size then
            height = height / obj_prop_table.visual_size.y
        end

        bar_ent = add_harm_bar(obj, hp, hp_max, height, harm_prop_table)

    end

    set_harm_bar(bar_ent, hp, hp_max)
    ]]--
    -- N.B. Fixed what appears to be faulty logic in the original code (replacing code above). Note
    --      that we no longer add a harm bar to a creature that's been killed in one punch
    local bar_ent = harm_bar_table[obj]
    if not bar_ent and hp > 0 and hp < hp_max then

        -- Set default bar height, just over the top of the collision box
        local height = (obj_prop_table.collisionbox[5] * 10) + 5
        if obj_prop_table.visual_size then
            height = height / obj_prop_table.visual_size.y
        end

        bar_ent = add_harm_bar(obj, hp, hp_max, height, harm_prop_table)

    end

    if bar_ent then
        set_harm_bar(bar_ent, hp, hp_max)
    end

end

function unimobs.misc_api.clear_harm_bar(obj)

    -- Was VH1.clear_bar()
    -- Removes the specified object's harm bar entity, updating local variables
    -- If this function is not called explicitly on death, the harm bar entity will still be removed
    --      automatically when the parent "obj" is removed

    if obj and harm_bar_table[obj] then

        local bar_ent = harm_bar_table[obj]
        harm_bar_table[obj]:remove()
        rev_harm_bar_table[bar_ent] = nil
        harm_bar_table[obj] = nil

    end

end

function unimobs.misc_api.clear_harm_bar_after_delay(obj)

    -- Was VH1.clear_bar_delay()
    -- Sets the timer to remove the specified object's harm bar entity, after a short delay

    core.after(clear_interval, function()
        unimobs.misc_api.clear_harm_bar(obj)
    end)

end

function unimobs.misc_api.set_harm_bar_default_size(x, y)

    -- Was VH1.set_default_size()
    -- Can be called by any code to change the default size of harm bars

    default_size_table = {x = x, y = y}

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Register the entity (can't call unilib.register_entity(), as it hasn't been loaded yet)
core.register_entity("unimobs:entity_harm_bar", {
    -- From visual_harm_1ndicators:hpbar
    initial_properties = {
        glow = 100,
        pointable = false,
        shaded = false,
        static_save = false,
        textures = {"unilib_entity_harm_bar_empty.png"},
        visual = "sprite",
        visual_size = default_size_table,
    },

    on_detach = function(self)
        self.object:remove()
    end,
})

-- Set up harm bars for players (but only on servers); harm bars for mobs are handled in the call
--      from unimobs.mobkit_api.check_vitals()
if unimobs.setting.enable_harm_bar_players_flag and not core.is_singleplayer() then

    core.register_on_player_hpchange(function(player, hpchange, reason)

        local obj_prop_table = player:get_properties()
        local hp = player:get_hp() + hpchange
        local hp_max = obj_prop_table.hp_max

        --[[
        local bar_ent = harm_bar_table[player]
        if not bar_ent then

            -- Set default bar height, just over the top of the collision box
            local height = (obj_prop_table.collisionbox[5] * 10) + 5
            if obj_prop_table.visual_size then
                height = height / obj_prop_table.visual_size.y
            end

            bar_ent = add_harm_bar(player, hp, hp_max, height, obj_prop_table)

        end

        set_harm_bar(bar_ent, hp, hp_max)
        ]]--
        -- N.B. Fixed what appears to be faulty logic in the original code (replacing code above).
        --      Note that we no longer add a harm bar to a player that's been killed in one punch
        local bar_ent = harm_bar_table[player]
        if not bar_ent and hp > 0 and hp < hp_max then

            -- Set default bar height, just over the top of the collision box
            local height = (obj_prop_table.collisionbox[5] * 10) + 5
            if obj_prop_table.visual_size then
                height = height / obj_prop_table.visual_size.y
            end

            bar_ent = add_harm_bar(player, hp, hp_max, height, obj_prop_table)

        end

        if bar_ent then
            set_harm_bar(bar_ent, hp, hp_max)
        end

    end)

    core.register_on_dieplayer(function(player, reason)
        unimobs.misc_api.clear_harm_bar(player)
    end)

end

-- Clear harm bars that are due to be cleared
core.register_globalstep(function(dtime)

    for bar_ent, timestamp in pairs(clear_table) do

        timestamp = timestamp - dtime
        if timestamp <= 0 then

            unimobs.misc_api.clear_harm_bar_after_delay(rev_harm_bar_table[bar_ent])
            clear_table[bar_ent] = nil

        else

            clear_table[bar_ent] = timestamp

        end

    end

end)
