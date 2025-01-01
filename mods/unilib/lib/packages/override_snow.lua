---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    snow
-- Code:    GPL 3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.override_snow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.snow.add_mode

local creative_mode = core.settings:get_bool("creative_mode")

local snowball_velocity, entity_attack_delay, someone_throwing, just_activated

-- (Formerly Minetest settings. These two values can be changed, if required)
local snowball_velocity = 19
local snowball_gravity = 0.91

local entity_table = {
    initial_properties = {
        collisionbox = {-5/16, -5/16, -5/16, 5/16, 5/16, 5/16},
        physical = false,
    },

    timer = 0,
}

---------------------------------------------------------------------------------------------------
-- Local functions (misc)
---------------------------------------------------------------------------------------------------

local function update_snowball_vel(v)

    snowball_velocity = v
    local walkspeed = tonumber(core.settings:get("movement_speed_walk")) or 4
    entity_attack_delay = (walkspeed + 1) / v

end

local function get_gravity()

    local grav = tonumber(core.settings:get("movement_gravity")) or unilib.constant.gravity
    return grav * snowball_gravity

end

local function shoot_snowball(item, player)

    -- Was snow.shoot_snowball()

    local addp = {y = 1.625}
    local dir = player:get_look_dir()
    local dif = 2 * math.sqrt(dir.z * dir.z + dir.x * dir.x)
    addp.x = dir.z/dif
    addp.z = -dir.x/dif

    local pos = vector.add(player:get_pos(), addp)
    local obj = core.add_entity(pos, "unilib:entity_snow_ordinary_ball")
    obj:set_velocity(vector.multiply(dir, snowball_velocity))
    obj:set_acceleration({x = dir.x * -3, y = -get_gravity(), z = dir.z * -3})
    obj:get_luaentity().thrower = player:get_player_name()
    if creative_mode then

        if not someone_throwing then

            someone_throwing = true
            just_activated = true

        end

        return

    end

    item:take_item()
    return item

end

local function update_step()

    local active
    for _, player in pairs(core.get_connected_players()) do

        if player:get_player_control().LMB then

            local item = player:get_wielded_item()
            local itemname = item:get_name()
            if itemname == "unilib:snow_ordinary" then

                shoot_snowball(nil, player)
                active = true
                break

            end

        end

    end

    -- Disable the function if no-one currently throws snowballs
    if not active then
        someone_throwing = false
    end

end

local function do_step()

    -- Throw snowballs automatically after a call from core.after()

    local timer
    -- Only if the player holds down the left mouse button
    if someone_throwing and not just_activated then

        update_step()
        timer = 0.006

    else

        timer = 0.5
        just_activated = false

    end

    core.after(timer, do_step)

end

---------------------------------------------------------------------------------------------------
-- Local functions (snowball entity)
---------------------------------------------------------------------------------------------------

function entity_table.on_activate(self)

    -- Was snow_snowball_ENTITY.on_activate()

    self.object:set_properties(
        {textures = {"unilib_snow_ordinary_ball.png^[transform" .. math.random(0, 7)}}
    )
    self.object:set_acceleration({x = 0, y = -get_gravity(), z = 0})
    self.lastpos = self.object:get_pos()
    core.after(0.1, function(obj)

        if not obj then
            return
        end

        local vel = obj:get_velocity()
        if vel and vel.y ~= 0 then
            return
        end

        core.after(0, function(object)

            if not object then
                return
            end

            local vel_obj = object:get_velocity()
            if not vel_obj or vel_obj.y == 0 then
                object:remove()
            end

        end, obj)

    end, self.object)

end

function entity_table.on_step(self, dtime)

    -- Was snow_snowball_ENTITY.on_step()

    self.timer = self.timer + dtime
    if self.timer > 10 then

        -- 10 seconds is too long for a snowball to fly somewhere
        self.object:remove()
        return

    end

    if self.physical then

        local vel = self.object:get_velocity()
        local fell = vel.y == 0
        if not fell then

            if self.probably_stuck then
                self.probably_stuck = nil
            end
            return

        end

        if self.probably_stuck and vel.x == 0 and vel.z == 0 then

            -- Add a small velocity to move it from the corner
            vel.x = math.random() - 0.5
            vel.z = math.random() - 0.5
            self.object:set_velocity(vel)
            self.probably_stuck = nil
            return

        end

        local pos = vector.round(self.object:get_pos())
        if core.get_node(pos).name == "air" then

            pos.y = pos.y-1
            if core.get_node(pos).name == "air" then

                if vel.x == 0 and vel.z == 0 then
                    self.probably_stuck = true
                end

                return

            end

        end

        unilib.pkg.shared_snow.place(pos)
        self.object:remove()
        return

    end

    local pos = vector.round(self.object:get_pos())
    if vector.equals(pos, self.lastpos) then
        return
    end

    if core.get_node(pos).name ~= "air" then

        self.object:set_acceleration({x = 0, y = -get_gravity(), z = 0})
        pos = self.lastpos
        self.object:set_pos(pos)
        core.sound_play(
            "unilib_snow_footstep",
            {pos = pos, gain = vector.length(self.object:get_velocity()) / 30}
        )
        self.object:set_properties({physical = true})
        self.physical = true
        return

    end

    self.lastpos = vector.new(pos)

    if self.timer < entity_attack_delay then
        return
    end

    for _,v in pairs(core.get_objects_inside_radius(pos, 1.73)) do

        local entity = v:get_luaentity()
        if v ~= self.object and entity then

            local entity_name = entity.name
            if v:is_player() or (
                entity_name ~= "unilib:entity_snow_ordinary_ball" and
                entity_name ~= "__builtin:item" and
                entity_name ~= "gauges:hp_bar"
            ) then
                local vvel = v:get_velocity() or v:get_player_velocity()
                local veldif = self.object:get_velocity()
                if vvel then
                    veldif = vector.subtract(veldif, vvel)
                end

                local gain = vector.length(veldif) / 20
                v:punch(
                    (self.thrower and core.get_player_by_name(self.thrower)) or self.object,
                    1,
                    {full_punch_interval = 1, damage_groups = {fleshy = math.ceil(gain)}}
                )
                core.sound_play("unilib_snow_footstep", {pos = pos, gain = gain})

                -- spawn_falling_node
                local obj = core.add_entity(pos, "__builtin:falling_node")
                if obj then

                    -- N.B. This line from the original code looks like an error, so fixed it
--                  obj:get_luaentity():set_node{name = "unilib:snow_ordinary"}
                    obj:get_luaentity():set_node({name = "unilib:snow_ordinary"})

                end

                self.object:remove()
                return

            end

        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.override_snow.init()

    return {
        description = "Overrides snow and ice from minetest_game, enabling the new ABM packages to"
                .. " work as intended, and providing snowballs and variable-height snow",
        notes = "Code in this package has been left alone intentionally, so that only ordinary" ..
                " ice and snow, as well as snow moss, are supported (and not any other" ..
                " variants of ice, snow or moss",
        depends = "shared_snow",
        at_least_one = {"ice_ordinary", "moss_snow", "snow_ordinary"},
    }

end

function unilib.pkg.override_snow.exec()

    -- Make ordinary ice freeze over
    if unilib.global.pkg_executed_table["ice_ordinary"] ~= nil then

        local group_table = core.registered_nodes["unilib:ice_ordinary"].groups
        group_table["melt"] = 1

        unilib.override_item("unilib:ice_ordinary", {
            tiles = {"unilib_ice_ordinary_override.png^[brighten"},
            groups = group_table,

            drawtype = "glasslike",
            liquids_pointable = true,
            liquidtype = "none",
            param2 = 0,
            sunlight_propagates = true,
            use_texture_alpha = "blend",

            after_place_node = function(pos)
                core.set_node(pos, {name = "unilib:ice_ordinary", param2 = math.random(0, 10)})
            end,

            on_construct = unilib.pkg.shared_snow.snow_onto_dirt,
        })

    end

    -- Update ordinary snow to support new code from the "snow" mod
    if unilib.global.pkg_executed_table["snow_ordinary"] ~= nil then

        local group_table = core.registered_nodes["unilib:snow_ordinary_block"].groups
        for k, v in pairs({cooks_into_ice = 1, falling_node = 1, icemaker = 1, melts = 1}) do
            group_table[k] = v
        end

        unilib.override_item("unilib:snow_ordinary_block", {
            groups = group_table,

            liquidtype = "none",
            paramtype = "light",
            sunlight_propagates = true,

            on_construct = unilib.pkg.shared_snow.snow_onto_dirt,
        })

        if unilib.global.pkg_executed_table["moss_snow"] ~= nil then

            unilib.override_item("unilib:snow_ordinary", {
                groups = {
                    choppy = 3, cracky = 3, crumbly = 3, falling_node = 1, float = 1,
                    oddly_breakable_by_hand = 3, melts = 2,
                },

                collision_box = {
                    type = "leveled",
                    fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
                },
                drop = {
                    max_items = 2,
                    items = {
                        {items = {"unilib:moss_snow"}, rarity = 20},
                        {items = {"unilib:snow_ordinary"}},
                    },
                },
                leveled = 7,
                node_box = {
                    type = "leveled",
                    fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
                },
                node_placement_prediction = "",
                paramtype2 = "leveled",
                selection_box = {
                    type = "leveled",
                    fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
                },
                sunlight_propagates = true,
                walkable = true,

                on_construct = function(pos)

                    pos.y = pos.y - 1
                    local node = core.get_node(pos)
                    if node.name == "unilib:dirt_ordinary_with_turf" or
                            node.name == "unilib:dirt_ordinary" then

                        node.name = "unilib:dirt_ordinary_with_cover_snow"
                        core.set_node(pos, node)

                    end

                end,

                on_dig = function(pos, node, digger)

                    -- Handle node drops due to node level
                    local level = core.get_node_level(pos)
                    core.node_dig(pos, node, digger)
                    if core.get_node(pos).name ~= node.name then

                        local inv = digger:get_inventory()
                        if not inv then
                            return
                        end

                        local left = inv:add_item(
                            "main",
                            "unilib:snow_ordinary " .. tostring(level / 7 - 1)
                        )

                        if not left:is_empty() then

                            core.add_item(
                                {
                                    x = pos.x + math.random() / 2 - 0.25,
                                    y = pos.y + math.random() / 2 - 0.25,
                                    z = pos.z + math.random() / 2 - 0.25,
                                },
                                left
                            )

                        end

                    end

                end,

                on_place = function(itemstack, player, pt)

                    -- Manage snow levels
                    local oldnode_under = core.get_node_or_nil(pt.under)
                    if not oldnode_under then
                        return itemstack, false
                    end

                    local olddef_under = core.registered_nodes[oldnode_under.name]
                    if not olddef_under then
                        return itemstack, false
                    end

                    -- If node under is buildable_to, place into it instead (e.g. snow)
                    local pos, node

                    if olddef_under.buildable_to then
                        pos = pt.under
                        node = oldnode_under

                    else

                        pos = pt.above
                        node = core.get_node(pos)
                        local def = core.registered_nodes[node.name]
                        if not def or not def.buildable_to then
                            return itemstack, false
                        end

                    end

                    -- nil player can place (for snowballs)
                    if player and core.is_protected(pos, player:get_player_name()) then
                        return itemstack, false
                    end

                    if node.name ~= "unilib:snow_ordinary" then

                        if core.get_node{x = pos.x, y=pos.y - 1, z = pos.z}.name ==
                                "unilib:snow_ordinary" then

                            -- Grow the snow below (fixes "leveled" problem)
                            pos.y = pos.y - 1

                        else

                            -- Place snow
                            return core.item_place_node(itemstack, player, pt)

                        end

                    end

                    -- "Grow" the snow
                    local level = core.get_node_level(pos)
                    level = level + 7
                    if level < 64 then

                        core.set_node_level(pos, level)

                    else

                        -- Place a snowblock and snow onto it if possible
                        local p = {x = pos.x, y = pos.y + 1, z = pos.z}
                        local def_table = core.registered_nodes[core.get_node(p).name]
                        if def_table == nil or not def_table.buildable_to then
                            return itemstack, false
                        end

                        core.set_node(pos, {name = "unilib:snow_ordinary_block"})
                        core.set_node(p, {name = "unilib:snow_ordinary"})
                        level = math.max(level - 64, 7)
                        core.set_node_level(p, level)

                    end

                    itemstack:take_item()
                    return itemstack, true

                end,

                on_use = shoot_snowball,
            })

        end

    end

    -- Handle Snowballs
    update_snowball_vel(snowball_velocity)
    core.after(3, do_step)
    unilib.register_entity("unilib:entity_snow_ordinary_ball", entity_table)

end
