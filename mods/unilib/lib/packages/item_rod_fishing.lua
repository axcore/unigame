---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_rod_fishing = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

-- Item "caught" by the fishing rod, if another item that doesn't exist was meant to be caught
local default_item = "unilib:dirt_ordinary"
-- Shortcuts for the minimum and maximum fishing times (in seconds), which depend on Minetest
--      settings
local max_time = unilib.setting.ethereal_fishing_time       -- Minimum value 25, recommended 45+
local min_time = math.floor(unilib.setting.ethereal_fishing_time / 3)
-- The maximum time is reduced by this much, if using bait
local bait_time = 20

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function do_bubble_effect(pos)

    -- Adapted from ethereal-ng/fishing.lua, was effect()
    -- Do the bubble particle effect

    core.add_particle({
        acceleration = {x = 0, y = -5, z = 0},
        collisiondetection = false,
        expirationtime = math.random() * 0.5,
        pos = {
            x = pos.x + math.random() - 0.5,
            y = pos.y + 0.1,
            z = pos.z + math.random() - 0.5
        },
        size = math.random(),
        texture = "bubble.png",
        velocity = {x = 0, y = 4, z = 0},
        vertical = false,
    })

end

local function use_rod(itemstack, player, pointed_thing)

    -- Adapted from ethereal-ng/fishing.lua, was use_rod()
    -- Called when the fishing rod is used. Throws the bob, places it in water, and catches fish
    --      (or bonus/junk items) when the bob moves

    local pos = player:get_pos()
    local objs = core.get_objects_inside_radius(pos, 15)
    local found_flag = true
    local ent

    -- Loop through entities and look for bobs
    for n = 1, #objs do

        ent = objs[n]:get_luaentity()

        if ent and
                ent.fisher and
                ent.name == "unilib:entity_fishing_bob" and
                player:get_player_name() == ent.fisher then

            found_flag = false

            if ent.bob == true then

                local mini_table
                local r = math.random(100)

                -- Lower position to be in water
                local rod_pos = ent.object:get_pos() or pos
                rod_pos.y = rod_pos.y - 1

                if not unilib.setting.ethereal_fishing_hard_flag then

                    -- Easier fishing (original ethereal-ng values)
                    if r < 86 then
                        mini_table = unilib.fishing.select_catch("fish", rod_pos)
                    elseif r < 96 then
                        mini_table = unilib.fishing.select_catch("junk", rod_pos)
                    else
                        mini_table = unilib.fishing.select_catch("bonus", rod_pos)
                    end

                else

                    -- Harder fishing (fewer fish, but slightly more bonus items)
                    if r < 40 then
                        mini_table = unilib.fishing.select_catch("fish", rod_pos)
                    elseif r < 92 then
                        mini_table = unilib.fishing.select_catch("junk", rod_pos)
                    else
                        mini_table = unilib.fishing.select_catch("bonus", rod_pos)
                    end

                end

                -- Make sure the item exists, if not replace with the default item
                local full_name
                if mini_table == nil or mini_table.full_name == nil then
                    full_name = default_item
                else
                    full_name = mini_table.full_name
                end

                if not core.registered_items[full_name] then
                    full_name = default_item
                end

                -- If a tool, then add wear
                new_stack = ItemStack(full_name)
                if mini_table.tool_wear and core.registered_tools[full_name] then
                    new_stack:set_wear(65535 - mini_table.tool_wear)
                end

                local inv = player:get_inventory()
                if inv:room_for_item("main", new_stack) then
                    inv:add_item("main", new_stack)
                else
                    core.add_item(pos, new_stack)
                end
            end

            ent.object:remove()

            return itemstack

        end

    end

    -- Loop through entities and look for bobs (again)
    for n = 1, #objs do

        ent = objs[n]:get_luaentity()

        if ent and
                ent.fisher and
                ent.name == "unilib:entity_fishing_bob" and
                player:get_player_name() == ent.fisher then

            found_flag = false
            break

        end

    end

    if found_flag == true then

        local player_pos = player:get_pos()
        local dir = player:get_look_dir()
        local pos = {x = player_pos.x, y = player_pos.y + 1.5, z = player_pos.z}

        core.sound_play(
            "unilib_rod_casting",
            {pos = pos, gain = 1.0, max_hear_distance = 16},
            true
        )

        -- Place actual bob
        local obj = core.add_entity(pos, "unilib:entity_fishing_bob")

        obj:set_velocity({x = dir.x * 8, y = dir.y * 8, z = dir.z * 8})
        obj:set_acceleration({x = dir.x * -3, y = (unilib.constant.gravity * -1), z = dir.z * -3})
        obj:get_luaentity().fisher = player and player:get_player_name()

    end

    -- Add wear to fishing rod (65 uses)
    itemstack:add_wear(65535 / 65)
    return itemstack

end

local function remove_bob(player)

    -- Adapted from ethereal-ng/fishing.lua, was remove_bob()
    -- Scans area for bobs that belong to player, and removes them

    local objs = core.get_objects_inside_radius(player:get_pos(), 15)
    local name = player:get_player_name()
    local ent

    for n = 1, #objs do

        ent = objs[n]:get_luaentity()

        if ent and ent.name == "unilib:entity_fishing_bob" then

            -- Only remove player's own bob
            if ent.fisher and ent.fisher == name then
                ent.object:remove()
            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_rod_fishing.init()

    return {
        description = "Fishing rod",
        notes = "Best used with bait (juicy worms), which reduces the waiting time",
        depends = {"dirt_ordinary", "item_string_ordinary"},
        optional = "item_worm_juicy",
    }

end

function unilib.pkg.item_rod_fishing.exec()

    -- The fishing rod itself

    unilib.register_tool("unilib:item_rod_fishing", "ethereal:fishing_rod", mode, {
        -- From ethereal:fishing_rod
        description = unilib.utils.hint(
            S("Fishing Rod"), S("left-click to cast line, left-click to catch fish")
        ),
        inventory_image = "unilib_item_rod_fishing.png",
        groups = {tool = 1},
        sound = {breaks = "unilib_tool_breaks"},

        stack_max = 1,
        wield_image = "unilib_item_rod_fishing.png^[transformFX",
        wield_scale = {x = 1.5, y = 1.5, z = 1},

        on_use = use_rod,
    })
    unilib.register_craft({
        -- From ethereal:fishing_rod
        output = "unilib:item_rod_fishing",
        recipe = {
            {"", "", "group:stick"},
            {"", "group:stick", "unilib:item_string_ordinary"},
            {"group:stick", "", "unilib:item_string_ordinary"},
        },
    })
    unilib.register_craft({
        -- From ethereal:fishing_rod
        type = "fuel",
        recipe = "unilib:item_rod_fishing",
        burntime = 15,
    })
    unilib.tools.register_no_repair(
        "unilib:item_rod_fishing", S("This fishing rod cannot be repaired")
    )

    -- Fishing bob entity
    unilib.register_entity("unilib:entity_fishing_bob", {
        -- From ethereal-ng/fishing.lua, ethereal:bob_entity
        initial_properties = {
            collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
            physical = false,
            pointable = false,
            static_save = false,
            textures = {"unilib_entity_fishing_bob.png"},
            visual_size = {x = 0.5, y = 0.5},
        },

        timer = 0,

        on_step = function(self, dtime)

            local pos = self.object:get_pos()
            local node = core.get_node(pos)
            local def = core.registered_nodes[node.name]

            -- Casting rod into water
            if not self.cast then

                -- Remove bob, if we hit something hard
                if (def and def.walkable) or node.name == "ignore" then

                    self.object:remove()
                    return

                end

                -- While bob is in the water
                if def and
                        def.liquidtype == "source" and
                        core.get_item_group(node.name, "water") > 0 then

                    -- In case of lag, find water level
                    local free_fall, blocker = core.line_of_sight(
                        {x = pos.x, y = pos.y + 2, z = pos.z},
                        {x = pos.x, y = pos.y, z = pos.z}
                    )

                    -- If we have worms for bait, take one
                    local player = self.fisher and core.get_player_by_name(self.fisher)
                    local inv = player and player:get_inventory()
                    local bait = 0

                    if inv and inv:contains_item("main", "unilib:item_worm_juicy") then

                        inv:remove_item("main", "unilib:item_worm_juicy")
                        bait = bait_time

                    end

                    -- Re-position fishing bob and set to cast
                    pos = {x = pos.x, y = blocker.y + 0.45, z = pos.z}

                    self.object:set_acceleration({x = 0, y = 0, z = 0})
                    self.object:set_velocity({x = 0, y = 0, z = 0})
                    self.object:set_pos(pos)
                    self.bait = bait
                    self.cast = true

                    -- Splash
                    do_bubble_effect(pos)
                    do_bubble_effect(pos)
                    do_bubble_effect(pos)
                    do_bubble_effect(pos)

                    core.sound_play("unilib_water_footstep", {pos = pos, gain = 0.1}, true)

                end

            -- Rod already cast, now waiting for fish
            else

                -- We need a name
                if self.fisher == nil or self.fisher == "" then

                    self.object:remove()
                    return

                end

                -- We need an actual player
                local player = core.get_player_by_name(self.fisher)
                if not player then

                    self.object:remove()
                    return

                end


                -- We also need a rod with which to fish
                local wield = player:get_wielded_item()
                if not wield or wield:get_name() ~= "unilib:item_rod_fishing" then

                    self.object:remove()
                    return

                end

                -- Remove the bob if the player is too far away
                local pla_pos = player:get_pos()
                if (pla_pos.y - pos.y) > 15 or
                        (pla_pos.y - pos.y) < -15 or
                        (pla_pos.x - pos.x) > 15 or
                        (pla_pos.x - pos.x) < -15 or
                        (pla_pos.z - pos.z) > 15 or
                        (pla_pos.z - pos.z) < -15 then

                    self.object:remove()
                    return

                end

                -- When in water, bob
                if def and
                        def.liquidtype == "source" and
                        core.get_item_group(def.name, "water") ~= 0 then

                    self.old_y = self.old_y or pos.y

                    -- Choose random time to wait (minus bait time for worm)
                    if not self.patience or self.patience <= 0 then

                        self.patience = math.random(min_time, (max_time - self.bait))
                        self.bait = 0

                    end

                    -- Add particles if bobber bobbing
                    if self.bob then

                        do_bubble_effect(pos)

                        -- Handle timer
                        if self.timer < self.patience then

                            self.timer = self.timer + dtime

                        else

                            self.patience = 0
                            self.timer = 0
                            self.bob = false

                        end

                    else

                        -- Handle timer
                        if self.timer < self.patience then

                            self.timer = self.timer + dtime

                        else

                            -- Waiting over, activate the bobber and play the splash sound
                            self.bob = true
                            -- (Timeframe to catch fish after bob)
                            self.patience = 1.4
                            self.timer = 0

                            self.object:set_velocity({x = 0, y = -1, z = 0})
                            self.object:set_acceleration({x = 0, y = 3, z = 0})

                            core.sound_play(
                                "unilib_water_footstep", {pos = pos, gain = 0.1},
                                true
                            )

                        end

                    end

                else

                    -- Reset to original position after dive
                    if self.old_y and pos.y > self.old_y then

                        self.object:set_velocity({x = 0, y = 0, z = 0})
                        self.object:set_acceleration({x = 0, y = 0, z = 0})
                        self.object:set_pos({x = pos.x, y = self.old_y, z = pos.z})

                    end

                    -- Remove bob if not in water and not bobbing
                    if not self.bob then
                        self.object:remove()
                    end

                end

            end

        end
    })

    -- Remove bob entity if player signs off
    core.register_on_leaveplayer(function(player)
        remove_bob(player)
    end)

    -- Remove bob entity if player dies
    core.register_on_dieplayer(function(player)
        remove_bob(player)
    end)

end
