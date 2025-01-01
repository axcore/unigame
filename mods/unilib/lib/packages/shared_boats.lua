---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    boats
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_boats = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.boats.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_water(pos)

    -- Adapted from boats/init.lua

    local nn = core.get_node(pos).name
    return core.get_item_group(nn, "water") ~= 0

end

local function get_velocity(v, yaw, y)

    -- Adapted from boats/init.lua

    local x = -math.sin(yaw) * v
    local z = math.cos(yaw) * v
    return {x = x, y = y, z = z}

end

local function get_v(v)

    -- Adapted from boats/init.lua

    return math.sqrt(v.x ^ 2 + v.z ^ 2)

end

local function prepare_boat_entity(full_name, part_name)

    -- Adapted from boats/init.lua
    -- Returns an entity definition, ready for the call to unilib.register_entity()

    local def_table = {
        initial_properties = {
            -- Warning: Do not change the position of the collisionbox top surface, lowering it
            --      causes the boat to fall through the world if underwater
            collisionbox = {-0.5, -0.35, -0.5, 0.5, 0.3, 0.5},
            mesh = "unilib_boat.obj",
            physical = true,
            textures = {"unilib_tree_" .. part_name .. "_wood.png"},
            visual = "mesh",
        },

        auto = false,
        driver = nil,
        last_v = 0,
        removed = false,
        v = 0,
    }

    function def_table.on_activate(self, staticdata, dtime_s)

        self.object:set_armor_groups({immortal = 1})
        if staticdata then
            self.v = tonumber(staticdata)
        end

        self.last_v = self.v

    end

    function def_table.on_detach_child(self, child)

        -- If driver leaves server while driving boat
        if child and child:get_player_name() == self.driver then

            unilib.player_api.set_player_attached(child:get_player_name(), false)

            self.driver = nil
            self.auto = false

        end

    end

    function def_table.on_punch(self, puncher)

        if not puncher or not puncher:is_player() or self.removed then
            return
        end

        local name = puncher:get_player_name()
        if self.driver and name == self.driver then

            self.driver = nil
            puncher:set_detach()
            unilib.player_api.set_player_attached(name, false)

        end

        if not self.driver then

            self.removed = true
            local inv = puncher:get_inventory()
            if not unilib.utils.is_creative(name) or
                    not inv:contains_item("main", full_name) then

                local leftover = inv:add_item("main", full_name)
                -- If no room in inventory add a replacement boat to the world
                if not leftover:is_empty() then
                    core.add_item(self.object:get_pos(), leftover)
                end

            end

            -- Delay remove to ensure player is detached
            core.after(0.1, function()
                self.object:remove()
            end)

        end

    end

    function def_table.on_step(self, dtime)

        self.v = get_v(self.object:get_velocity()) * math.sign(self.v)

        if self.driver then

            local driver_objref = core.get_player_by_name(self.driver)
            if driver_objref then

                local ctrl = driver_objref:get_player_control()

                if ctrl.up and ctrl.down then

                    if not self.auto then

                        self.auto = true
                        core.chat_send_player(self.driver, S("Boat cruise mode on"))

                    end

                elseif ctrl.down then

                    self.v = self.v - dtime * 2.0
                    if self.auto then

                        self.auto = false
                        core.chat_send_player(self.driver, S("Boat cruise mode off"))

                    end

                elseif ctrl.up or self.auto then

                    self.v = self.v + dtime * 2.0

                end

                if ctrl.left then

                    if self.v < -0.001 then
                        self.object:set_yaw(self.object:get_yaw() - dtime * 0.9)
                    else
                        self.object:set_yaw(self.object:get_yaw() + dtime * 0.9)
                    end

                elseif ctrl.right then

                    if self.v < -0.001 then
                        self.object:set_yaw(self.object:get_yaw() + dtime * 0.9)
                    else
                        self.object:set_yaw(self.object:get_yaw() - dtime * 0.9)
                    end

                end

            end

        end

        local velo = self.object:get_velocity()
        if not self.driver and self.v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then

            self.object:set_pos(self.object:get_pos())
            return

        end

        -- We need to preserve velocity sign to properly apply drag force while moving backward
        local drag = dtime * math.sign(self.v) * (0.01 + 0.0796 * self.v * self.v)
        -- If drag is larger than velocity, then stop horizontal movement
        if math.abs(self.v) <= math.abs(drag) then
            self.v = 0
        else
            self.v = self.v - drag
        end

        local p = self.object:get_pos()
        p.y = p.y - 0.5
        local new_velo
        local new_acce = {x = 0, y = 0, z = 0}

        if not is_water(p) then

            local nodedef = core.registered_nodes[core.get_node(p).name]
            if (not nodedef) or nodedef.walkable then
                self.v = 0
                new_acce = {x = 0, y = 1, z = 0}
            else
                new_acce = {x = 0, y = (unilib.constant.gravity * -1), z = 0}
            end

            new_velo = get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y)
            self.object:set_pos(self.object:get_pos())

        else

            p.y = p.y + 1
            if is_water(p) then

                local y = self.object:get_velocity().y
                if y >= 5 then
                    y = 5
                elseif y < 0 then
                    new_acce = {x = 0, y = 20, z = 0}
                else
                    new_acce = {x = 0, y = 5, z = 0}
                end

                new_velo = get_velocity(self.v, self.object:get_yaw(), y)
                self.object:set_pos(self.object:get_pos())

            else

                new_acce = {x = 0, y = 0, z = 0}
                if math.abs(self.object:get_velocity().y) < 1 then

                    local pos = self.object:get_pos()
                    pos.y = math.floor(pos.y) + 0.5
                    self.object:set_pos(pos)
                    new_velo = get_velocity(self.v, self.object:get_yaw(), 0)

                else

                    new_velo = get_velocity(
                        self.v,
                        self.object:get_yaw(),
                        self.object:get_velocity().y
                    )
                    self.object:set_pos(self.object:get_pos())

                end

            end

        end

        self.object:set_velocity(new_velo)
        self.object:set_acceleration(new_acce)

    end

    function def_table.on_rightclick(self, clicker)

        if not clicker or not clicker:is_player() then
            return
        end

        local name = clicker:get_player_name()
        if self.driver and name == self.driver then

            -- Cleanup happens in def_table.on_detach_child()
            clicker:set_detach()

            unilib.player_api.set_animation(clicker, "stand", 30)
            local pos = clicker:get_pos()
            pos = {x = pos.x, y = pos.y + 0.2, z = pos.z}
            core.after(0.1, function()
                clicker:set_pos(pos)
            end)

        elseif not self.driver then

            clicker:set_attach(self.object, "", {x = 0.5, y = 1, z = -3}, {x = 0, y = 0, z = 0})

            self.driver = name
            unilib.player_api.set_player_attached(name, true)

            core.after(0.2, function()
                unilib.player_api.set_animation(clicker, "sit", 30)
            end)

            clicker:set_look_horizontal(self.object:get_yaw())

        end

    end

    function def_table.get_staticdata(self)
        return tostring(self.v)
    end

    return def_table

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_boats.register_boat(data_table)

    -- Adapted from boats/init.lua
    -- Creates a boat for a tree type already registered in an earlier call to
    --      unilib.register_tree()
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "apple", a key in unilib.global.tree_table
    --      orig_name (str): e.g. "boats:boat"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      burnlevel (int): value in the range 1-5, see ../lib/system/global/global_variables.lua.
    --          Overrides the value of "burntime" is specified
    --      burntime (int): e.g. 20
    --      description (str): e.g. "Simple Boat (Apple Tree Wood)"
    --
    -- Return values:
    --      The full_name of the new node

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local burnlevel = data_table.burnlevel or nil
    local burntime = data_table.burntime or 20
    local description = data_table.description or S("Simple Boat")

    local full_name = "unilib:boat_simple_" .. part_name
    local entity_name = "unilib:entity_boat_simple_" .. part_name
    local ingredient = "unilib:tree_" .. part_name .. "_wood"

    if burnlevel ~= nil then
        burntime = unilib.global.tree_burn_table.trunk[burnlevel]
    end

    -- Prepare the entity definition
    local def_table = prepare_boat_entity(full_name, part_name)
    -- Register the entity
    unilib.register_entity(entity_name, def_table)

    -- Register the craftitem
    unilib.register_craftitem(full_name, orig_name, replace_mode, {
        -- From boats:boat
        description = description,
        inventory_image = "unilib_boat_simple_" .. part_name .. "_inv.png",
        groups = {flammable = 2},

        liquids_pointable = true,
        wield_image = "unilib_boat_simple_" .. part_name .. "_wield.png",
        wield_scale = {x = 2, y = 2, z = 1},

        on_place = function(itemstack, placer, pointed_thing)

            local under = pointed_thing.under
            local node = core.get_node(under)
            local udef = core.registered_nodes[node.name]

            if udef and udef.on_rightclick and not (
                placer and placer:is_player() and
                placer:get_player_control().sneak
            ) then

                return udef.on_rightclick(
                    under,
                    node,
                    placer,
                    itemstack,
                    pointed_thing
                ) or itemstack

            end

            if pointed_thing.type ~= "node" then
                return itemstack
            end

            if not is_water(pointed_thing.under) then
                return itemstack
            end

            pointed_thing.under.y = pointed_thing.under.y + 0.5
            boat = core.add_entity(pointed_thing.under, entity_name)
            if boat then

                if placer then
                    boat:set_yaw(placer:get_look_horizontal())
                end

                local player_name = placer and placer:get_player_name() or ""
                if not unilib.utils.is_creative(player_name) then
                    itemstack:take_item()
                end

            end

            return itemstack

        end,
    })
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", "", ""},
            {ingredient, "", ingredient},
            {ingredient, ingredient, ingredient},
        },
    })
    unilib.register_craft({
        type = "fuel",
        recipe = full_name,
        burntime = burntime,
    })

    return full_name

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_boats.init()

    return {
        description = "Shared functions for boats (from minetest_game/boats)",
    }

end
