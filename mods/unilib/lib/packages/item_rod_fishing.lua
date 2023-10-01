---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_rod_fishing = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

-- Item "caught" by the fishing rod, if another item that doesn't exist was meant to be caught
local default_item = "unilib:dirt_ordinary"
-- Shortcuts for the minimum and maximum fishing times (in seconds), which depend on Minetest
--      settings
local max_time = unilib.ethereal_fishing_time       -- Minimum value 25, recommended 45+
local min_time = math.floor(unilib.ethereal_fishing_time / 3)
-- The maximum time is reduced by this much, if using bait
local bait_time = 20

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function use_rod(itemstack, player, pointed_thing)

    -- Adapted from ethereal-ng/fishing.lua
    -- Called when the fishing rod is used. Throws the bob, places it in water, and catches fish
    --      (or bonus/junk items) when the bob moves

    local pos = player:get_pos()
    local objs = minetest.get_objects_inside_radius(pos, 25)
    local found = true
    local ent

    -- Loop through entities and look for bobs
    for n = 1, #objs do

        ent = objs[n]:get_luaentity()

        if ent and
                ent.fisher and
                (
                    ent.name == "unilib:entity_fishing_bob_throw" or
                    ent.name == "unilib:entity_fishing_bob_float"
                ) and
                player:get_player_name() == ent.fisher then

            found = false

            if ent.bob == true then

                local item
                local r = math.random(100)

                if not unilib.ethereal_fishing_hard_flag then

                    -- Easier fishing (original ethereal-ng values)
                    if r < 86 then
                        item = unilib.find_caught_item("fish", pos)
                    elseif r < 96 then
                        item = unilib.find_caught_item("junk", pos)
                    else
                        item = unilib.find_caught_item("bonus", pos)
                    end

                else

                    -- Harder fishing (fewer fish, but slightly more bonus items)
                    if r < 40 then
                        item = unilib.find_caught_item("fish", pos)
                    elseif r < 92 then
                        item = unilib.find_caught_item("junk", pos)
                    else
                        item = unilib.find_caught_item("bonus", pos)
                    end

                end

                -- Make sure "item" exists, if not replace with default item
                -- (In unilib, this should not be necessary since the global variables have already
                --      been filtered; but we'll retain this code anyway)
                if not minetest.registered_items[item] then
                    item = default_item
                end

                item = ItemStack(item)

                local inv = player:get_inventory()
                if inv:room_for_item("main", item) then
                    inv:add_item("main", item)
                else
                    minetest.add_item(pos, item)
                end
            end

            ent.object:remove()

            return itemstack

        end

    end

    -- Loop through entities and look for bobs
    for n = 1, #objs do

        ent = objs[n]:get_luaentity()

        if ent and
                ent.fisher and
                (
                    ent.name == "unilib:entity_fishing_bob_throw" or
                    ent.name == "unilib:entity_fishing_bob_float"
                ) and
                player:get_player_name() == ent.fisher then

            found = false
            break

        end

    end

    if found == true then

        local playerpos = player:get_pos()
        local dir = player:get_look_dir()
        local pos = {x = playerpos.x, y = playerpos.y + 1.5, z = playerpos.z}

        minetest.sound_play(
            "unilib_rod_casting",
            {pos = pos, gain = 0.4, max_hear_distance = 16},
            true
        )

        -- Place actual bob
        local obj = minetest.add_entity(pos, "unilib:entity_fishing_bob_throw")

        obj:set_velocity({x = dir.x * 8, y = dir.y * 8, z = dir.z * 8})
        obj:set_acceleration({x = dir.x * -3, y = -9.8, z = dir.z * -3})
        obj:get_luaentity().fisher = player and player:get_player_name()

    end
end

local function remove_bob(player)

    -- Adapted from ethereal-ng/fishing.lua
    -- Scans area for bobs that belong to player, and removes them

    local objs = minetest.get_objects_inside_radius(player:get_pos(), 25)
    local name = player:get_player_name()
    local ent

    for n = 1, #objs do

        ent = objs[n]:get_luaentity()

        if ent and
                (
                    ent.name == "unilib:entity_fishing_bob_throw" or
                    ent.name == "unilib:entity_fishing_bob_float"
                ) then

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
        description = unilib.hint(
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
            {"group:stick", "", "unilib:item_string_ordinary"}
        }
    })
    unilib.register_craft({
        -- From ethereal:fishing_rod
        type = "fuel",
        recipe = "unilib:item_rod_fishing",
        burntime = 15,
    })
    unilib.register_tool_no_repair(
        "unilib:item_rod_fishing", S("This fishing rod cannot be repaired")
    )

    -- Fishing bob entity, thrown into the water
    unilib.register_entity("unilib:entity_fishing_bob_throw", {
        -- From ethereal-ng/fishing.lua, ethereal:prebob_entity
        collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
        lastpos = {},
        physical = false,
        pointable = false,
        textures = {"unilib_entity_fishing_bob.png"},
        visual_size = {x = 0.5, y = 0.5},

        on_step = function(self, dtime)

            local pos = self.object:get_pos()

            -- Destroy when hitting a solid node
            if self.lastpos.x then

                local node = minetest.get_node(pos)
                local def = minetest.registered_nodes[node.name]

                -- Remove if we hit something hard
                if def and def.walkable then

                    self.object:remove()
                    return

                end

                if def and
                        def.liquidtype == "source" and
                        minetest.get_item_group(node.name, "water") > 0 then

                    -- Do we have worms for bait? If so, take one
                    local player = self.fisher and minetest.get_player_by_name(self.fisher)
                    local inv = player and player:get_inventory()
                    local bait = 0

                    if inv and inv:contains_item("main", "unilib:item_worm_juicy") then

                        inv:remove_item("main", "unilib:item_worm_juicy")
                        bait = bait_time

                    end

                    self.lastpos.y = math.floor(self.lastpos.y)

                    local obj = minetest.add_entity(self.lastpos, "unilib:entity_fishing_bob_float")
                    local ent = obj:get_luaentity()

                    ent.fisher = self.fisher
                    ent.bait = bait

                    minetest.sound_play(
                        "unilib_water_footstep",
                        {pos = self.lastpos, gain = 0.1},
                        true
                    )

                    self.object:remove()

                    return

                end

            end

            self.lastpos = {x = pos.x, y = pos.y, z = pos.z}

        end
    })

    -- Fishing bob entity that moves in the water from time to time
    unilib.register_entity("unilib:entity_fishing_bob_float", {
        -- From ethereal-ng/fishing.lua, ethereal:bob_entity
        bob = false,
        collisionbox = {0.4, 0.4, 0.4, 0.4, 0.4, 0.4},
        lastpos = {},
        old_y = nil,
        patience = nil,
        physical = false,
        pointable = false,
        static_save = false,
        textures = {"unilib_entity_fishing_bob.png"},
        timer = 0,
        visual_size = {x = 0.5, y = 0.5},

        on_step = function(self, dtime)

            -- We need a name
            if self.fisher == nil or self.fisher == "" then

                self.object:remove()
                return

            end

            local player = minetest.get_player_by_name(self.fisher)

            -- We need an actual person
            if not player then

                self.object:remove()
                return

            end

            local pos = self.object:get_pos()
            pos.y = math.floor(pos.y)

            local node = minetest.get_node(pos)
            local def = minetest.registered_nodes[node.name]
            local wield = player:get_wielded_item()

            -- We also need a rod to fish with
            if not wield or wield:get_name() ~= "unilib:item_rod_fishing" then

                self.object:remove()
                return

            end

            -- Remove bob if player is too far away
            local bob_pos = self.object:get_pos()
            local pla_pos = player:get_pos()

            if (pla_pos.y - bob_pos.y) > 15 or
                    (pla_pos.y - bob_pos.y) < -15 or
                    (pla_pos.x - bob_pos.x) > 15 or
                    (pla_pos.x - bob_pos.x) < -15 or
                    (pla_pos.z - bob_pos.z) > 15 or
                    (pla_pos.z - bob_pos.z) < -15 then

                -- Out of range
                self.object:remove()
                return

            end

            -- When in water, the entity bobs around
            if def and
                    def.liquidtype == "source" and
                    minetest.get_item_group(def.name, "water") ~= 0 then

                if self.old_y == nil then

                    self.object:set_pos({
                        x = self.object:get_pos().x,
                        y = math.floor(self.object:get_pos().y) + 0.5,
                        z = self.object:get_pos().z,
                    })

                    self.old_y = self.object:get_pos().y

                end

                -- Reset to original position after dive
                if self.object:get_pos().y > self.old_y then

                    self.object:set_pos({
                        x = self.object:get_pos().x,
                        y = self.old_y,
                        z = self.object:get_pos().z,
                    })

                    self.object:set_velocity({x = 0, y = 0, z = 0})
                    self.object:set_acceleration({x = 0, y = 0, z = 0})

                end

                -- Choose random time to wait (minus bait time for worm)
                if not self.patience or self.patience <= 0 then

                    self.patience = math.random(min_time, (max_time - self.bait))
                    self.bait = 0

                end

                -- Add particles if bobber bobbing
                if self.bob then

                    minetest.add_particle({
                        acceleration = {x = 0, y = -5, z = 0},
                        collisiondetection = false,
                        expirationtime = math.random() * 0.5,
                        pos = {
                            x = pos.x + math.random() - 0.5,
                            y = pos.y + 0.1,
                            z = pos.z + math.random() - 0.5,
                        },
                        size = math.random(),
                        texture = "bubble.png",
                        velocity = {x = 0, y = 4, z = 0},
                        vertical = false,
                    })

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

                        -- Waiting over. Play the splash sound
                        self.bob = true
                        self.patience = 1.5     -- Time frame to catch fish after bob
                        self.timer = 0

                        self.object:set_velocity({x = 0, y = -2, z = 0})
                        self.object:set_acceleration({x = 0, y = 5, z = 0})

                        minetest.sound_play(
                            "unilib_water_footstep",
                            {pos = pos, gain = 0.1},
                            true
                        )

                    end

                end

            end

        end,
    })

    -- Remove bob entity if player signs off
    minetest.register_on_leaveplayer(function(player)
        remove_bob(player)
    end)

    -- Remove bob entity if player dies
    minetest.register_on_dieplayer(function(player)
        remove_bob(player)
    end)

end
