---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- stamina_base.lua
--      Set up hunger and sprinting fatigue. Code adapted from the "stamina" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local settings_table = {}
local player_attribute_table = {}
local exhaustion_table = {}

local player_hud_id_table = {}
local registered_on_update_saturation_table = {}
local registered_on_poison_table = {}
local registered_on_exhaust_player_table = {}
local registered_on_sprinting_table = {}

local stamina_timer = 0
local health_timer = 0
local action_timer = 0

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function stamina_log(level, msg, ...)

    -- Adapted from stamina, was stamina.log()

    -- (Not sure if a separate log function is necessary, but we'll keep it for now)
    return unilib.utils.log(level, ("[%s] %s"):format(unilib.core.name, msg:format(...)))

end

local function is_player(player)

    -- Adapted from stamina, was is_player()

    return core.is_player(player) and not player.is_fake_player

end

local function get_hud_id(player)

    -- Adapted from stamina, was get_hud_id()

    return player_hud_id_table[player:get_player_name()]

end

local function set_hud_id(player, hud_id)

    -- Adapted from stamina, was set_hud_id()

    player_hud_id_table[player:get_player_name()] = hud_id

end

---------------------------------------------------------------------------------------------------
-- Local functions (ticks)
---------------------------------------------------------------------------------------------------

local function poison_tick(player_name, ticks, interval, elapsed)

    -- Adapted from stamina, was poison_tick()

    local player = core.get_player_by_name(player_name)
    if not player or not unilib.stamina.is_poisoned(player) then

        return

    elseif elapsed > ticks then

        unilib.stamina.set_poisoned(player, false)

    else

        local hp = player:get_hp() - 1
        if hp > 0 then
            player:set_hp(hp)
        end

        core.after(interval, poison_tick, player_name, ticks, interval, elapsed + 1)

    end

end

local function move_tick()

    -- Adapted from stamina, was move_tick()

    for _, player in ipairs(core.get_connected_players()) do

        local controls = player:get_player_control()
        local is_moving = controls.up or controls.down or controls.left or controls.right
        local velocity = player:get_velocity()
        velocity.y = 0
        local horizontal_speed = vector.length(velocity)
        local has_velocity = horizontal_speed > 0.05

        if controls.jump then

            unilib.stamina.exhaust_player(
                player, settings_table.exhaust_jump, exhaustion_table.jump
            )

        elseif is_moving and has_velocity then

            unilib.stamina.exhaust_player(
                player, settings_table.exhaust_move, exhaustion_table.move
            )

        end

        if settings_table.sprint then

            local can_sprint = (
                controls.aux1 and
                        not player:get_attach() and
                        (
                            settings_table.sprint_with_fast or
                            not core.check_player_privs(player, {fast = true})
                        ) and
                        unilib.stamina.get_saturation(player) > settings_table.sprint_lvl
            )

            if can_sprint then

                unilib.stamina.set_sprinting(player, true)
                if is_moving and has_velocity then

                    unilib.stamina.exhaust_player(
                        player, settings_table.exhaust_sprint, exhaustion_table.sprint
                    )

                end

            else

                unilib.stamina.set_sprinting(player, false)

            end

        end

    end

end

local function stamina_tick()

    -- Adapted from stamina, was stamina_tick()
    -- Lowers saturation by 1 point after settings_table.tick second(s)

    for _, player in ipairs(core.get_connected_players()) do

        local saturation = unilib.stamina.get_saturation(player)
        if saturation > settings_table.tick_min then
            unilib.stamina.update_saturation(player, saturation - 1)
        end

    end

end

local function health_tick()

    -- Adapted from stamina, was health_tick()
    -- Heals or damages the player, depending on saturation

    for _, player in ipairs(core.get_connected_players()) do

        local air = player:get_breath() or 0
        local hp = player:get_hp()
        local saturation = unilib.stamina.get_saturation(player)

        -- Don't heal if dead, drowning, or poisoned...
        local should_heal = (
            saturation >= settings_table.heal_lvl and
            saturation >= hp and
            hp > 0 and
            air > 0 and
            not unilib.stamina.is_poisoned(player)
        )

        -- ...or damage player by 1 hp if saturation is < 2 (of 30)
        local is_starving = (
            saturation < settings_table.starve_lvl and
            hp > 0
        )

        if should_heal then

            player:set_hp(hp + settings_table.heal)
            unilib.stamina.exhaust_player(player, settings_table.exhaust_lvl, exhaustion_table.heal)

        elseif is_starving then

            player:set_hp(hp - settings_table.starve)

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (timers)
---------------------------------------------------------------------------------------------------

local function stamina_globaltimer(dtime)

    -- Adapted from stamina, was stamina_globaltimer()

    stamina_timer = stamina_timer + dtime
    health_timer = health_timer + dtime
    action_timer = action_timer + dtime

    if action_timer > settings_table.move_tick then

        action_timer = 0
        move_tick()

    end

    if stamina_timer > settings_table.tick then

        stamina_timer = 0
        stamina_tick()

    end

    if health_timer > settings_table.health_tick then

        health_timer = 0
        health_tick()

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (other)
---------------------------------------------------------------------------------------------------

local function show_eat_particles(player, itemname)

    -- Adapted from stamina, was show_eat_particles()
    -- Particle effect when eating

    local pos = player:get_pos()
    -- Assume mouth is slightly below eye_height
    pos.y = pos.y + (player:get_properties().eye_height * .923)
    local dir = player:get_look_dir()

    local def_table = core.registered_items[itemname]
    local texture = def_table.inventory_image or def_table.wield_image

    local particle_def_table = {
        amount = 5,
        time = 0.1,

        maxacc = {x = 0, y = -9, z = 0},
        minacc = {x = 0, y = -5, z = 0},
        maxexptime = 1,
        minexptime = 1,
        maxpos = pos,
        minpos = pos,
        maxsize = 2,
        minsize = 1,
        maxvel = {x = dir.x + 1, y = dir.y, z = dir.z + 1},
        minvel = {x = dir.x - 1, y = dir.y, z = dir.z - 1},
    }

    if texture and texture ~= "" then
        particle_def_table.texture = texture
    elseif def_table.type == "node" then
        particle_def_table.node = {name = itemname, param2 = 0}
    else
        particle_def_table.texture = "blank.png"
    end

    core.add_particlespawner(particle_def_table)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (saturation API)
---------------------------------------------------------------------------------------------------

function unilib.stamina.get_saturation(player)

    -- Adapted from stamina, was stamina.get_saturation()
    -- Gets a player's saturation

    return tonumber(unilib.utils.get_player_attribute(player, player_attribute_table.saturation))

end

function unilib.stamina.set_saturation(player, level)

    -- Adapted from stamina, was stamina.set_saturation()
    -- Sets a player's saturation
    -- Updates the HUD to reflect saturation level

    unilib.utils.set_player_attribute(player, player_attribute_table.saturation, level)
    player:hud_change(
        get_hud_id(player),
        "number",
        math.min(settings_table.visual_max, level)
    )

end

function unilib.stamina.register_on_update_saturation(func)

    -- Adapted from stamina, was stamina.register_on_update_saturation()
    -- Registers a callback for when saturation is updated
    -- If the callback returns True, no further callbacks are called and the default behaviour is
    --      bypassed

    table.insert(registered_on_update_saturation_table, func)

end

function unilib.stamina.update_saturation(player, level)

    -- Adapted from stamina, was stamina.update_saturation()
    -- Updates a player's saturation
    -- Callbacks are processed first

    for _, callback in ipairs(registered_on_update_saturation_table) do

        local result = callback(player, level)
        if result then
            return result
        end

    end

    local old = unilib.stamina.get_saturation(player)

    -- Suppress HUD update
    if level == old then
        return
    end

    -- Players without "interact" privilege cannot eat
    if old < settings_table.heal_lvl and
            not core.check_player_privs(player, {interact = true}) then
        return
    end

    unilib.stamina.set_saturation(player, level)

end

function unilib.stamina.change_saturation(player, change)

    -- Adapted from stamina, was stamina.change_saturation()
    -- Updates a player's saturation by a delta, instead of an absolute value

    if not is_player(player) or not change or change == 0 then
        return false
    end

    local level = unilib.stamina.get_saturation(player) + change
    level = math.max(level, 0)
    level = math.min(level, settings_table.visual_max)
    unilib.stamina.update_saturation(player, level)

    return true

end

---------------------------------------------------------------------------------------------------
-- Shared functions (poison API)
---------------------------------------------------------------------------------------------------

function unilib.stamina.is_poisoned(player)

    -- Adapted from stamina, was stamina.is_poisoned()
    -- Checks if a player is poisoned

    return unilib.utils.get_player_attribute(player, player_attribute_table.poisoned) == "yes"

end

function unilib.stamina.set_poisoned(player, poisoned)

    -- Adapted from stamina, was stamina.set_poisoned()
    -- Sets a player's "poisoned" status (boolean)
    -- Updates the HUD to reflect poison status

    local hud_id = get_hud_id(player)
    if poisoned then

        player:hud_change(hud_id, "text", "unilib_hud_poison_fg.png")
        unilib.utils.set_player_attribute(player, player_attribute_table.poisoned, "yes")

    else

        player:hud_change(hud_id, "text", "unilib_hud_hunger_fg.png")
        unilib.utils.set_player_attribute(player, player_attribute_table.poisoned, "no")

    end

end

function unilib.stamina.register_on_poison(func)

    -- Adapted from stamina, was stamina.register_on_poison()
    -- Registers a callback for when a player is poisoned
    -- If the callback returns True, no further callbacks are called, and the default behaviour is
    --      bypassed

    table.insert(registered_on_poison_table, func)

end

function unilib.stamina.poison_player(player, ticks, interval)

    -- Adapted from stamina, was stamina.poison()
    -- Poisons a player for a certain amount of time
    -- Ticks is how many times to poison the player
    -- "interval" is the time between poison ticks
    -- Processes callbacks before changing status

    for _, func in ipairs(registered_on_poison_table) do

        local rv = func(player, ticks, interval)
        if rv == true then
            return
        end

    end

    if not is_player(player) then
        return
    end

    unilib.stamina.set_poisoned(player, true)
    local player_name = player:get_player_name()
    poison_tick(player_name, ticks, interval, 0)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (exhaustion API)
---------------------------------------------------------------------------------------------------

function unilib.stamina.get_exhaustion(player)

    -- Adapted from stamina, was stamina.get_exhaustion()
    -- Gets a player's exhaustion level
    -- Value is between 0 and settings_table.exhaust_lvl (default: 160)

    return tonumber(unilib.utils.get_player_attribute(player, player_attribute_table.exhaustion))

end

function unilib.stamina.set_exhaustion(player, exhaustion)

    -- Adapted from stamina, was stamina.set_exhaustion()
    -- Sets a player's exhaustion level

    unilib.utils.set_player_attribute(player, player_attribute_table.exhaustion, exhaustion)

end

function unilib.stamina.register_on_exhaust_player(func)

    -- Adapted from stamina, was stamina.register_on_exhaust_player()
    -- Registers a callback for when exhaustion is updated
    -- If the callback returns True, no further callbacks are called, and the default behaviour is
    --      bypassed

    table.insert(registered_on_exhaust_player_table, func)

end

function unilib.stamina.exhaust_player(player, change, cause)

    -- Adapted from stamina, was stamina.exhaust_player()
    -- Updates a player's exhaustion by "change"
    -- If the player's exhaustion exceeds `stamina.exhaust_lvl`, stamina is reduced and exhaustion
    --      is reset
    -- Cause is an optional argument indicating the origin of the exhaustion
    -- Callbacks are processed before exhausting the player

    for _, callback in ipairs(registered_on_exhaust_player_table) do

        local result = callback(player, change, cause)
        if result then
            return result
        end

    end

    if not is_player(player) then
        return
    end

    local exhaustion = unilib.stamina.get_exhaustion(player) or 0

    exhaustion = exhaustion + change

    if exhaustion >= settings_table.exhaust_lvl then

        exhaustion = exhaustion - settings_table.exhaust_lvl
        unilib.stamina.change_saturation(player, -1)

    end

    unilib.stamina.set_exhaustion(player, exhaustion)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (sprinting API)
---------------------------------------------------------------------------------------------------

function unilib.stamina.register_on_sprinting(func)

    -- Adapted from stamina, was stamina.register_on_sprinting()
    -- Registers a callback for when a player's sprinting status is updated.
    -- If the callback returns True, no further callbacks are called, and the default behaviour is
    --      bypassed

    table.insert(registered_on_sprinting_table, func)

end

function unilib.stamina.set_sprinting(player, sprinting_flag)

    -- Adapted from stamina, was stamina.set_sprinting()
    -- Sets whether a player is sprinting or not
    -- Callbacks are processed before setting sprint status

    for _, func in ipairs(registered_on_sprinting_table) do

        local rv = func(player, sprinting_flag)
        if rv == true then
            return
        end

    end

    if core.get_modpath("player_monoids") then

        if sprinting_flag then

            player_monoids.speed:add_change(
                player, 1 + settings_table.sprint_speed, "stamina:physics"
            )

            player_monoids.jump:add_change(
                player, 1 + settings_table.sprint_jump, "stamina:physics"
            )

        else

            player_monoids.speed:del_change(player, "stamina:physics")
            player_monoids.jump:del_change(player, "stamina:physics")

        end

    else

        local data_table = {
            gravity = 1,
            jump = 1,
            speed = 1,
        }

        if unilib.armour.active_flag then

            local armour_data_table = unilib.armour.get_player_data(player:get_player_name())

            if armour_data_table.gravity ~= nil then
                data_table.gravity = armour_data_table.gravity
            end

            if armour_data_table.jump ~= nil then
                data_table.jump = armour_data_table.jump
            end

            if armour_data_table.speed ~= nil then
                data_table.speed = armour_data_table.speed
            end

        end

        if sprinting_flag then

            data_table.speed = data_table.speed + settings_table.sprint_speed
            data_table.jump = data_table.jump + settings_table.sprint_jump

        end

        player:set_physics_override(data_table)

    end

    if settings_table.sprint_particles and sprinting_flag then

        local pos = player:get_pos()
        local node = core.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
        local def_table = core.registered_nodes[node.name] or {}
        local drawtype = def_table.drawtype
        if drawtype ~= "airlike" and drawtype ~= "liquid" and drawtype ~= "flowingliquid" then

            core.add_particlespawner({
                amount = 5,
                time = 0.01,
                texture = "unilib_dirt_ordinary.png",

                maxacc = {x = 0, y = -12, z = 0},
                minacc = {x = 0, y = -5, z = 0},
                maxexptime = 0.5,
                minexptime = 0.25,
                maxpos = {x = pos.x + 0.25, y = pos.y + 0.1, z = pos.z + 0.25},
                minpos = {x = pos.x - 0.25, y = pos.y + 0.1, z = pos.z - 0.25},
                maxsize = 1.0,
                minsize = 0.5,
                maxvel = {x = 0.5, y = 2, z = 0.5},
                minvel = {x = -0.5, y = 1, z = -0.5},

                collisiondetection = false,
                vertical = false,
            })

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Adapted from stamina/init.lua

-- Replace a million MT settings with mostly hard-coded values, at least for now
settings_table = {
    eat_particles = true,
    sprint = unilib.setting.hunger_on_sprint_flag,
    sprint_particles = true,
    sprint_lvl = 6,
    sprint_speed = 0.8,
    sprint_jump = 0.1,
    sprint_with_fast = false,
    tick = 800,
    tick_min = 4,
    health_tick = 4,
    move_tick = 0.5,
    poison_tick = 2.0,
    exhaust_dig = 3 * unilib.setting.hunger_factor,
    exhaust_place = 1 * unilib.setting.hunger_factor,
    exhaust_move = 1.5 * unilib.setting.hunger_on_sprint_factor,
    exhaust_jump = 5 * unilib.setting.hunger_on_sprint_factor,
    exhaust_craft = 20 * unilib.setting.hunger_factor,
    exhaust_punch = 40 * unilib.setting.hunger_factor,
    exhaust_sprint = 28 * unilib.setting.hunger_factor,
    exhaust_lvl = 160,
    heal = 1,
    heal_lvl = 5,
    starve = 1,
    starve_lvl = 3,
    visual_max = 20,
}

-- Keys in the player object's metadata
player_attribute_table = {
    saturation = "stamina_level",
    poisoned = "stamina_poisoned",
    exhaustion = "stamina_exhaustion",
}

-- Cause of player's stamina being reduced, in calls to unilib.stamina.exhaust_player()
exhaustion_table = {
    craft = "craft",
    dig = "dig",
    heal = "heal",
    jump = "jump",
    move = "move",
    place = "place",
    punch = "punch",
    sprint = "sprint",
}

-- Override core.do_item_eat() so we can redirect hp_change to stamina
-- (Note that the old function is not required any more, but it's good form to store it somewhere)
local old_do_item_eat = core.do_item_eat
function core.do_item_eat(hp_change, replace_with_item, itemstack, player, pointed_thing)

    for _, callback in ipairs(core.registered_on_item_eats) do

        local result = callback(hp_change, replace_with_item, itemstack, player, pointed_thing)
        if result then
            return result
        end

    end

    if not is_player(player) or not itemstack then
        return itemstack
    end

    local level = unilib.stamina.get_saturation(player) or 0
    if level >= settings_table.visual_max then

        -- Don't eat if player is full
        return itemstack

    end

    local itemname = itemstack:get_name()
    if replace_with_item then

        stamina_log(
            "action",
            "%s eats %s for %s stamina, replace with %s",
            player:get_player_name(),
            itemname,
            hp_change,
            replace_with_item
        )

    else

        stamina_log(
            "action",
            "%s eats %s for %s stamina",
            player:get_player_name(),
            itemname,
            hp_change
        )

    end

    core.sound_play("unilib_eat", {to_player = player:get_player_name(), gain = 0.7})

    if hp_change > 0 then

        unilib.stamina.change_saturation(player, hp_change)
        unilib.stamina.set_exhaustion(player, 0)

    else

        -- Assume hp_change < 0
        unilib.stamina.poison_player(player, -hp_change, settings_table.poison_tick)

    end

    if settings_table.eat_particles then
        show_eat_particles(player, itemname)
    end

    itemstack:take_item()

    if replace_with_item then

        if itemstack:is_empty() then

            itemstack:add_item(replace_with_item)

        else

            local inv = player:get_inventory()
            if inv:room_for_item("main", {name = replace_with_item}) then

                inv:add_item("main", replace_with_item)

            else

                local pos = player:get_pos()
                pos.y = math.floor(pos.y - 1.0)
                core.add_item(pos, replace_with_item)

            end

        end

    end

    return itemstack

end

core.register_on_joinplayer(function(player)

    local level = unilib.stamina.get_saturation(player) or settings_table.visual_max
    local id = player:hud_add({
        name = "stamina",
        type = "statbar",

        alignment = {x = -1, y = -1},
        item = settings_table.visual_max,
        max = 0,
        number = level,
        offset = {x = -266, y = -110},
        position = {x = 0.5, y = 1},
        size = {x = 24, y = 24},
        text = "unilib_hud_hunger_fg.png",
        text2 = "unilib_hud_stamina_bg.png",
    })

    set_hud_id(player, id)
    unilib.stamina.set_saturation(player, level)
    -- Reset poisoned
    unilib.stamina.set_poisoned(player, false)

end)

core.register_on_leaveplayer(function(player)
    set_hud_id(player, nil)
end)

core.register_globalstep(stamina_globaltimer)

core.register_on_placenode(function(pos, oldnode, player, ext)
    unilib.stamina.exhaust_player(player, settings_table.exhaust_place, exhaustion_table.place)
end)

core.register_on_dignode(function(pos, oldnode, player, ext)
    unilib.stamina.exhaust_player(player, settings_table.exhaust_dig, exhaustion_table.dig)
end)

core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    unilib.stamina.exhaust_player(player, settings_table.exhaust_craft, exhaustion_table.craft)
end)

core.register_on_punchplayer(

    function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)

        unilib.stamina.exhaust_player(
            hitter, settings_table.exhaust_punch, exhaustion_table.punch
        )

    end

)
core.register_on_respawnplayer(function(player)
    unilib.stamina.update_saturation(player, settings_table.visual_max)
end)
