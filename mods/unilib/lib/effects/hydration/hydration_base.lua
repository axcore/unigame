---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- hydration.lua
--      Set up hydration/thirst. Code adapted from the "thirsty" mod
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

local settings_table = {}
local player_table = {}
local fountain_table = {}
local time_next_tick = 0.0

-- N.B. from persistent_player_attributes.lua
-- In original code, the player's hydration was stored between sessions using a Minetest inventory.
--      That code has been imported here, but has been commented out and replaced with code that
--      stores the player's hydration as an ordinary player attribute
local attribute_template_table = {}
local read_cache_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions (utilities)
---------------------------------------------------------------------------------------------------

local function count_for_val(value, data_table)

    -- Adapted from thirsty/persistent_player_attributes.lua, was _count_for_val()

    local count = math.floor((value - data_table.min) / (data_table.max - data_table.min) * 65535)
    if count < 0 then
        count = 0
    end

    if count > 65535 then
        count = 65535
    end

    return count

end

local function val_for_count(count, data_table)

    -- Adapted from thirsty/persistent_player_attributes.lua, was _val_for_count()

    local value = count / 65535 * (data_table.max - data_table.min) + data_table.min
    if value < data_table.min then
        value = data_table.min
    end

    if value > data_table.max then
        value = data_table.max
    end

    return value

end

local function player_attribute_get_value(player, name)

    -- Adapted from thirsty/persistent_player_attributes.lua, was PPA.get_value()

    --[[
    local pname = player:get_player_name()
    if read_cache_table[pname][name] == nil then

        local data_table = attribute_template_table[name]
        local inv = player:get_inventory()
        local count = inv:get_stack(name, 1):get_count()
        read_cache_table[pname][name] = val_for_count(count, data_table)

    end
    ]]--

    local pname = player:get_player_name()
    if read_cache_table[pname][name] == nil then

        local data_table = attribute_template_table[name]
        local count = tonumber(unilib.utils.get_player_attribute(player, "hydration_level"))
        read_cache_table[pname][name] = val_for_count(count, data_table)

    end

    return read_cache_table[pname][name]

end

local function player_attribute_set_value(player, name, value)

    -- Adapted from thirsty/persistent_player_attributes.lua, was PPA.set_value()

    --[[
    local data_table = attribute_template_table[name]
    local inv = player:get_inventory()
    local pname = player:get_player_name()

    if value > data_table.max then
        value = data_table.max
    end

    if value < data_table.min then
        value = data_table.min
    end

    read_cache_table[pname][name] = value
    inv:set_stack(name, 1, ItemStack({name = ":", count = count_for_val(value, data_table)}))
    ]]--

    local data_table = attribute_template_table[name]
    local pname = player:get_player_name()

    if value > data_table.max then
        value = data_table.max
    end

    if value < data_table.min then
        value = data_table.min
    end

    read_cache_table[pname][name] = value
    unilib.utils.set_player_attribute(player, "hydration_level", count_for_val(value, data_table))

end

local function hud_clamp(value)

    -- Adapted from thirsty/hud.lua, was thirsty.hud_clamp()

    if value < 0 then
        return 0
    elseif value > 20 then
        return 20
    else
        return math.ceil(value)
    end

end

local function hud_init(player)

    -- Adapted from thirsty/hud.lua, was thirsty.hud_init()

    local pname = player:get_player_name()

    player_table[pname].hud_id = player:hud_add({
        name = "hydration",
        type = "statbar",

        direction = 0,
        number = hud_clamp(player_attribute_get_value(player, "hydration")),
        -- N.B. Tweaked position of the HUD, so it matches the hunger HUD on the left side
--      offset = {x = 25, y = -(48 + 24 + 16 + 32)},
        offset = {x = 25, y = -110},
        position = {x = 0.5, y = 1},
        size = {x = 24, y = 24},
        text = "unilib_hud_thirst_fg.png",
    })

end

local function hud_update(player, value)

    -- Adapted from thirsty/hud.lua, was thirsty.hud_update()

    local pname = player:get_player_name()
    local hud_id = player_table[pname].hud_id
    player:hud_change(hud_id, "number", hud_clamp(value))

end

---------------------------------------------------------------------------------------------------
-- Local functions (callbacks)
---------------------------------------------------------------------------------------------------

local function on_joinplayer(player)

    -- Adapted from thirsty/functions.lua, was thirsty.on_joinplayer()

    local pname = player:get_player_name()

    -- Default entry for new players
    if not player_table[pname] then

        local pos = player:get_pos()
        player_table[pname] = {
            last_pos = math.floor(pos.x) .. ":" .. math.floor(pos.z),
            time_in_pos = 0.0,
            pending_dmg = 0.0,
        }

    end

    hud_init(player)

end

local function on_dieplayer(player)

    -- Adapted from thirsty/functions.lua, was thirsty.on_dieplayer()

    local pname = player:get_player_name()
    local data_table = player_table[pname]

    -- Reset after death
    player_attribute_set_value(player, "hydration", 20)
    data_table.pending_dmg = 0.0

end

---------------------------------------------------------------------------------------------------
-- Local functions (handlers)
---------------------------------------------------------------------------------------------------

local function drink_handler(player, itemstack, node)

    -- Adapted from thirsty/functions.lua, was thirsty.drink_handler()
    -- Most tools, nodes and craftitems use the same code, so here it is

    local hydro = player_attribute_get_value(player, "hydration")
    local old_hydro = hydro

    -- Selectors, always true, to make the following code easier
    local itemstack_name = itemstack and itemstack:get_name() or ":"
    local node_name = node and node.name or ":"

    if settings_table.node_drinkable[node_name] then

        -- The player found something to drink
        local cont_level = settings_table.drink_from_container[itemstack_name] or 0
        local node_level = settings_table.drink_from_node[node_name] or 0
        -- Drink until level
        local level = math.max(cont_level, node_level)
        unilib.hydration.do_drink(player, level, level)

        -- fill container, if applicable
        if settings_table.container_capacity[itemstack_name] then

            -- Looks full
            itemstack:set_wear(1)

        end

    elseif settings_table.container_capacity[itemstack_name] then

        -- Drinking from a container
        if itemstack:get_wear() ~= 0 then

            local capacity = settings_table.container_capacity[itemstack_name]
            local hydro_missing = 20 - hydro
            if hydro_missing > 0 then

                local wear_missing = hydro_missing / capacity * 65535.0
                local wear = itemstack:get_wear()
                local new_wear = math.ceil(math.max(wear + wear_missing, 1))
                if (new_wear > 65534) then

                    wear_missing = 65534 - wear
                    new_wear = 65534

                end

                itemstack:set_wear(new_wear)

                -- Rounding glitches?
                if wear_missing > 0 then

                    unilib.hydration.do_drink(player, wear_missing * capacity / 65535.0, 20)
                    hydro = player_attribute_get_value(player, "hydration")

                end

            end

        end

    end

    -- Update HUD if value changed
    if hydro ~= old_hydro then
        hud_update(player, hydro)
    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (setup)
---------------------------------------------------------------------------------------------------

local function register_player_attribute(data_table)

    -- Adapted from thirsty/persistent_player_attributes.lua, was PPA.register()

    attribute_template_table[data_table.name] = {
        name = data_table.name,
        min = data_table.min or 0.0,
        max = data_table.max or 1.0,
        default = data_table.default or data_table.min or 0.0,
    }

end

local function player_attribute_on_joinplayer(player)

    -- Adapted from thirsty/persistent_player_attributes.lua, was PPA.on_joinplayer()

    --[[
    local inv = player:get_inventory()
    local pname = player:get_player_name()

    read_cache_table[pname] = {}
    for name, data_table in pairs(attribute_template_table) do

        inv:set_size(name, 1)
        if inv:is_empty(name) then

            -- Set default value
            inv:set_stack(
                name,
                1,
                ItemStack({name = ":", count = count_for_val(data_table.default, data_table)})
            )

            -- Cache default value
            read_cache_table[pname][name] = data_table.default

        end

    end
    ]]--

    local pname = player:get_player_name()

    read_cache_table[pname] = {}
    for name, data_table in pairs(attribute_template_table) do

        if unilib.utils.get_player_attribute(player, "hydration_level") == "" then

            -- Set default value
            unilib.utils.set_player_attribute(
                player, "hydration_level", count_for_val(data_table.default, data_table)
            )

            -- Cache default value
            read_cache_table[pname][name] = data_table.default

        end

    end

end

local function main_loop(dtime)

    -- Adapted from thirsty/functions.lua, was thirsty.main_loop()

    -- Get thirsty
    time_next_tick = time_next_tick - dtime
    while time_next_tick < 0.0 do

        -- Time for thirst
        time_next_tick = time_next_tick + settings_table.tick_time
        for _, player in ipairs(core.get_connected_players()) do

            if player:get_hp() <= 0 then

                -- Dead players don't get thirsty, or full for that matter
                break

            end

            local pname = player:get_player_name()
            local pos = player:get_pos()
            local pl = player_table[pname]
            local hydro = player_attribute_get_value(player, "hydration")

            -- How long has the player been standing here?
            -- (The node coordinates in X and Z should be good enough)
            local pos_hash = math.floor(pos.x) .. ":" .. math.floor(pos.z)
            if pl.last_pos == pos_hash then

                pl.time_in_pos = pl.time_in_pos + settings_table.tick_time

            else

                -- Player has moved
                pl.last_pos = pos_hash
                pl.time_in_pos = 0.0

            end

            local pl_standing = pl.time_in_pos > settings_table.stand_still_for_drink
            local pl_afk = pl.time_in_pos > settings_table.stand_still_for_afk

            pos.y = pos.y + 0.1
            local node = core.get_node(pos)
            local drink_per_second = settings_table.regen_from_node[node.name] or 0

            -- Fountaining (uses pos, slight changes ok)
            for k, data_table in pairs(fountain_table) do

                local dx = data_table.pos.x - pos.x
                local dy = data_table.pos.y - pos.y
                local dz = data_table.pos.z - pos.z
                local dist2 = dx * dx + dy * dy + dz * dz
                -- .fountain_distance_per_level = max 100 nodes radius
                local fdist = data_table.level * settings_table.fountain_distance_per_level
                if dist2 < fdist * fdist then

                    -- In range, drink as if standing (still) in water
                    drink_per_second = math.max(
                        settings_table.regen_from_fountain or 0, drink_per_second
                    )
                    pl_standing = true

                    -- No need to check the other fountains
                    break

                end

            end

            -- Extractor/injector devices
            -- Notes from original mod:
            -- TODO: I *guess* we need to optimize this, but I haven't measured it yet. No premature
            --      optimizations!
            local pl_inv = player:get_inventory()
            local extractor_max = 0.0
            local injector_max = 0.0
            local container_not_full = nil
            local container_not_empty = nil
            local inv_main = player:get_inventory():get_list("main")

            for i, itemstack in ipairs(inv_main) do

                local name = itemstack:get_name()
                local injector_this = settings_table.injection_for_item[name]
                if injector_this and injector_this > injector_max then
                    injector_max = injector_this
                end

                local extractor_this = settings_table.extraction_for_item[name]
                if extractor_this and extractor_this > extractor_max then
                    extractor_max = extractor_this
                end

                if settings_table.container_capacity[name] then

                    local wear = itemstack:get_wear()

                    -- Can be both!
                    if wear == 0 or wear > 1 then
                        container_not_full = {i, itemstack}
                    end

                    if wear > 0 and wear < 65534 then
                        container_not_empty = {i, itemstack}
                    end

                end

            end

            if extractor_max > 0.0 and container_not_full then

                local i = container_not_full[1]
                local itemstack = container_not_full[2]
                local capacity = settings_table.container_capacity[itemstack:get_name()]

                local wear = itemstack:get_wear()
                if wear == 0 then
                    wear = 65535.0
                end

                local drink = extractor_max * settings_table.tick_time
                local drinkwear = drink / capacity * 65535.0
                wear = wear - drinkwear
                if wear < 1 then
                    wear = 1
                end

                itemstack:set_wear(wear)
                player:get_inventory():set_stack("main", i, itemstack)

            end

            if injector_max > 0.0 and container_not_empty then

                local i = container_not_empty[1]
                local itemstack = container_not_empty[2]
                local capacity = settings_table.container_capacity[itemstack:get_name()]

                local wear = itemstack:get_wear()
                if wear == 0 then
                    wear = 65535.0
                end

                local drink = injector_max * settings_table.tick_time
                local drink_missing = 20 - hydro
                drink = math.max(math.min(drink, drink_missing), 0)

                local drinkwear = drink / capacity * 65535.0
                wear = wear + drinkwear
                if wear > 65534 then
                    wear = 65534
                end

                itemstack:set_wear(wear)
                unilib.hydration.do_drink(player, drink, 20)
                hydro = player_attribute_get_value(player, "hydration")
                player:get_inventory():set_stack("main", i, itemstack)

            end

            if drink_per_second > 0 and pl_standing then

                -- Drinking from the ground won't give you more than max
                unilib.hydration.do_drink(player, drink_per_second * settings_table.tick_time, 20)

            else

                if not pl_afk then

                    -- Only get thirsty if not AFK
                    local amount = settings_table.thirst_per_second * settings_table.tick_time
                    player_attribute_set_value(player, "hydration", hydro - amount)
                    hydro = player_attribute_get_value(player, "hydration")

                end

            end

            -- Should we only update the HUD on an actual change?
            hud_update(player, hydro)

            -- Damage, if enabled
            if core.settings:get_bool("enable_damage") then

                -- Maybe not the best way to do this, but it does mean we can do anything with one
                --      tick loop
                if hydro <= 0.0 and not pl_afk then

                    pl.pending_dmg = pl.pending_dmg + (
                        settings_table.damage_per_second * settings_table.tick_time
                    )

                    if pl.pending_dmg > 1.0 then

                        local dmg = math.floor(pl.pending_dmg)
                        pl.pending_dmg = pl.pending_dmg - dmg
                        player:set_hp(player:get_hp() - dmg)

                    end

                else

                    -- Forget any pending damage when not thirsty
                    pl.pending_dmg = 0.0

                end

            end

        end

        -- Check fountains for expiration
        for k, data_table in pairs(fountain_table) do

            data_table.time_until_check = data_table.time_until_check - settings_table.tick_time
            if data_table.time_until_check <= 0 then

                -- Remove fountain, the abm will set it again
                fountain_table[k] = nil

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions (original mod API)
---------------------------------------------------------------------------------------------------

function unilib.hydration.do_drink(player, value, max)

    -- Adapted from thirsty/functions.lua, was thirsty.drink()
    -- Instantly drink a bit (up to a max value, default 20)

    -- If max is not specified, assume 20
    if not max then
        max = 20
    end

    local hydro = player_attribute_get_value(player, "hydration")

    -- Test whether we're not above the max; this function should not remove any overhydration
    if hydro < max then

        hydro = math.min(hydro + value, max)
        player_attribute_set_value(player, "hydration", hydro)
        return true

    else

        return false

    end

end

function unilib.hydration.get_hydro(player)

    -- Adapted from thirsty/functions.lua, was thirsty.get_hydro()
    -- Returns the current hydration of a player

    return player_attribute_get_value(player, "hydration")

end

function unilib.hydration.set_hydro(player, value)

    -- Original to unilib, called by /cripple_thirst and other chat commands
    -- Set the player's hydration directly

    if value > 20 then
        value = 20
    end

    player_attribute_set_value(player, "hydration", value)

end

---------------------------------------------------------------------------------------------------
-- Shared functions (package API)
---------------------------------------------------------------------------------------------------

function unilib.hydration.on_use(old_on_use)

    -- Adapted from thirsty/functions.lua, was thirsty.on_use()
    -- Returns an .on_use() function for the calling package's node/craftitem/tool
    -- Calls the local function drink_handler(), then calls the original .on_use() function (if
    --      any)

    return function(itemstack, player, pointed_thing)

        local node = nil
        if pointed_thing and pointed_thing.type == "node" then
            node = core.get_node(pointed_thing.under)
        end

        drink_handler(player, itemstack, node)

        -- Call original on_use(), if provided
        if old_on_use ~= nil then
            return old_on_use(itemstack, player, pointed_thing)
        else
            return itemstack
        end

    end

end

function unilib.hydration.on_rightclick(old_on_rightclick)

    -- Adapted from thirsty/functions.lua, was thirsty.on_rightclick()
    -- Returns an .on_rightclick() function for the calling package's node/craftitem/tool
    -- Calls the local function drink_handler(), then calls the original .on_rightclick() function
    --      (if any)

    return function(pos, node, player, itemstack, pointed_thing)

        drink_handler(player, itemstack, node)

        -- Call original on_rightclick(), if provided
        if old_on_rightclick ~= nil then
            return old_on_rightclick(pos, node, player, itemstack, pointed_thing)
        else
            return itemstack
        end

    end

end

function unilib.hydration.enable_drinking_from_container(full_name, level)

    -- Adapted from thirsty/functions.lua, was thirsty.augment_item_for_drinking()
    -- Updates a suitable container (a node, craftitem or tool originally provided by another mod)
    --      to allow the player to drink from it

    -- Change from original code: don't bother if hydration is not enabled
    if unilib.setting.thirst_enable_flag then

        -- Overwrite the node definition
        unilib.override_item(full_name, {
            liquids_pointable = true,

            on_use = unilib.hydration.on_use(core.registered_items[full_name].on_use),
        })

        -- Update settings
        settings_table.drink_from_container[full_name] = level

    end

end

function unilib.hydration.enable_water_storage(full_name, level)

    -- Original to unilib
    -- Updates a suitable container (such as a canteen) so it can store water

    -- Don't bother if hydration is not enabled
    if unilib.setting.thirst_enable_flag then

        -- Update settings
        settings_table.container_capacity[full_name] = level

    end

end

function unilib.hydration.enable_static_drinking(full_name, level)

    -- Original to unilib
    -- Updates a suitable item intended to have an unlimited water storage capacity (such as a
    --      drinking fountain) so the player can drink from it

    -- Don't bother if hydration is not enabled
    if unilib.setting.thirst_enable_flag then

        -- Overwrite the node definition
        unilib.override_item(full_name, {
            on_rightclick = unilib.hydration.on_rightclick(
                core.registered_items[full_name].on_rightclick
            ),
        })

        -- Update settings
        settings_table.drink_from_node[full_name] = level
        settings_table.node_drinkable[full_name] = true

    end

end

function unilib.hydration.fountain_abm(pos, node)

    -- Adapted from thirsty/functions.lua, was thirsty.fountain_abm()
    -- Called from the hydration machine extender in the "machine_hydration" package

    local fountain_count = 0
    local water_count = 0
    local total_count = 0

    for y = 0, settings_table.fountain_height do

        for x = -y, y do

            for z = -y, y do

                -- Start one *above* the fountain
                local n = core.get_node({x = pos.x + x, y = pos.y - y + 1, z = pos.z + z})
                if n then

                    total_count = total_count + 1
                    local type = settings_table.fountain_type[n.name] or ""
                    if type == "f" then
                        fountain_count = fountain_count + 1
                    elseif type == "w" then
                        water_count = water_count + 1
                    end

                end

            end

        end

    end

    local level = math.min(settings_table.fountain_max_level, math.min(fountain_count, water_count))
    fountain_table[string.format("%d:%d:%d", pos.x, pos.y, pos.z)] = {
        pos = {x = pos.x, y = pos.y, z = pos.z},
        level = level,
        -- Time until the abm ticks again. 20 seconds, or twice the average, should be enough.
        time_until_check = 20,
    }

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- (from configuration.lua)
-- Replace thirsty/configuration.lua and various config files with with mostly hard-coded
--      values, at least for now
-- The commented-out key-value pairs have been replaced with calls to the setter functions
--      above, directly from each package
-- N.B. In the original code, an active player reached maximum thirst after 6 minutes 40
--      seconds; adjusted this, so it takes slightly over 20 minutes (a game day)
settings_table = {
    damage_per_second = 0.1,
    fountain_distance_per_level = 5,
    fountain_height = 4,
    fountain_max_level = 20,
    stand_still_for_afk = 120,
    stand_still_for_drink = 1,
--  thirst_per_second = 0.05 * unilib.setting.thirst_factor,
    thirst_per_second = 0.015 * unilib.setting.thirst_factor,
    tick_time = 0.5,

    container_capacity = {
--      ["unilib:item_canteen_bronze"] = 60,
--      ["unilib:item_canteen_steel"] = 40,
    },
    extraction_for_item = {
        ["unilib:device_extractor_water"] = 0.6,
    },
    drink_from_container = {
--      ["unilib:item_canteen_bronze"] = 25,
--      ["unilib:utensil_bowl_wooden"] = 25,
--      ["unilib:item_canteen_steel"] = 25,
    },
    drink_from_node = {
--      ["unilib:misc_fountain_drinking"] = 30,
    },
    fountain_type = {
--      ["unilib:liquid_water_river_source"] = "w",
--      ["unilib:liquid_water_ordinary_source"] = "w",
        ["unilib:machine_hydration"] = "f",
--      ["unilib:liquid_water_ordinary_flowing"] = "w",
        ["unilib:machine_hydration_extender"] = "f",
--      ["unilib:liquid_water_river_flowing"] = "w",
    },
    injection_for_item = {
        ["unilib:device_injector_water"] = 0.5,
    },
    node_drinkable = {
--      ["unilib:liquid_water_river_source"] = true,
--      ["unilib:liquid_water_ordinary_source"] = true,
--      ["unilib:liquid_water_ordinary_flowing"] = true,
--      ["unilib:misc_fountain_drinking"] = true,
--      ["unilib:liquid_water_river_flowing"] = true,
    },
    regen_from_fountain = 0.5,
    regen_from_node = {
--      ["unilib:liquid_water_river_source"] = 0.5,
--      ["unilib:liquid_water_ordinary_source"] = 0.5,
--      ["unilib:liquid_water_ordinary_flowing"] = 0.5,
--      ["unilib:liquid_water_river_flowing"] = 0.5,
    },
}

-- Update this table, once all packages have been loaded
core.after(0.2, function()

    -- (All drinkable waters have the same restorative qualities)
    for _, data_table in pairs(unilib.global.generic_liquid_table) do

        if data_table.potable_flag then

            settings_table.fountain_type[data_table.source_name] = "w"
            settings_table.fountain_type[data_table.flowing_name] = "w"

            settings_table.node_drinkable[data_table.source_name] = true
            settings_table.node_drinkable[data_table.flowing_name] = true

            settings_table.regen_from_node[data_table.source_name] = 0.5
            settings_table.regen_from_node[data_table.flowing_name] = 0.5

        end

    end

end)

-- (from thirsty/persistent_player_attributes.lua)
core.register_on_joinplayer(player_attribute_on_joinplayer)

-- (from init.lua)
time_next_tick = settings_table.tick_time

-- (from functions.lua)
register_player_attribute({
    name = "hydration",
    min = 0,
    max = 50,
    default = 20,
})

core.register_on_joinplayer(on_joinplayer)
core.register_on_dieplayer(on_dieplayer)
core.register_globalstep(main_loop)
