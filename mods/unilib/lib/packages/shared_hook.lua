---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hook
-- Code:    LGPL-2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_hook = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

-- Shared table to handle throwing (see also code .post() function below)
unilib.pkg.shared_hook.hook_table = {
    tmp_throw = {},
    tmp_throw_timer = 0,
    tmp_time = tonumber(minetest.settings:get("item_entity_ttl")),
    pvp = minetest.settings:get_bool("enable_pvp") == true,
}

if unilib.pkg.shared_hook.hook_table.tmp_time == "" or
        unilib.pkg.shared_hook.hook_table.tmp_time == nil then
    unilib.pkg.shared_hook.hook_table.tmp_time = 890
else
    unilib.pkg.shared_hook.hook_table.tmp_time = unilib.pkg.shared_hook.hook_table.tmp_time - 10
end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_hook.punch(ob1, ob2, hp)

    ob2:punch(ob1, 1, {full_punch_interval = 1, damage_groups = {fleshy = hp}})

end

function unilib.pkg.shared_hook.is_hook(pos, name)

    if not (name and minetest.is_protected(pos,name)) then

        local def_table = minetest.registered_nodes[minetest.get_node(pos).name]
        if def_table and
                (
                    def_table.name == "unilib:hook_generic_temp" or
                    (
                        def_table.buildable_to and
                        not (def_table.liquidtype == "source" and def_table.paramtype2 == "none")
                    )
                ) then

            if not (
                def_table.name == "unilib:hook_generic_temp" and
                minetest.get_meta(pos):get_int("a") ~= 0
            ) then
                return true
            end

        end

    end

    return false

end

function unilib.pkg.shared_hook.has_property(pos, n)

    -- Adapted from hook/init.lua, was hook.slingshot_def()
    -- Returns true if the node at the specified position has the property "n" (e.g. "walkable")

    local nn = minetest.get_node(pos).name
    return (minetest.registered_nodes[nn] and minetest.registered_nodes[nn][n])

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_hook.init()

    return {
        description = "Shared functions for grappling hooks and slingshots (from hook mod)",
    }

end

function unilib.pkg.shared_hook.exec()

    -- (Required by items in "tool_hook_with_rope", "tool_rope_climbing" and
    --      "tool_rope_climbing_locked" packages, all of which specify this package as a dependency)

    unilib.register_node("unilib:hook_generic_temp", "hook:hooking", mode, {
        -- From hook:hooking
        description = S("Hook"),
        tiles = {"unilib_hook_rope_temp.png"},
        groups = {dig_immediate = 3, not_in_creative_inventory = 1, rope = 1},
        -- (no sounds)

        drawtype = "mesh",
        drop = "",
        mesh = "unilib_hook_generic.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.0625, -0.5, -0.5, 0.0625, -0.49, -0.375},
            },
        },
        sunlight_propagates = false,
        walkable = false,

        can_dig = function(pos, player)

            return minetest.get_item_group(
                minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name,
                "rope"
            ) == 0

        end,

        on_timer = function(pos, elapsed)

            if minetest.get_item_group(
                minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name,
                "rope"
            ) == 0 then
                minetest.remove_node(pos)
            else
                return true
            end

        end,
    })

    unilib.register_entity("unilib:entity_hook_grappling", {
        -- From hooks/project.lua, hook:power
        collisionbox = {-0.2, -0.2, -0.2, 0.2, 0.2, 0.2},
        d = 0,
        hp_max = 100,
        is_visible = true,
        locked = false,
        makes_footstep_sound = false,
        mesh = "unilib_hook_generic.obj",
        physical = true,
        textures = {"unilib_entity_hook_grappling.png"},
        timer2 = 0,
        uname = "",
        visual = "mesh",
        visual_size = {x = 10, y = 10},

        on_activate = function(self, staticdata)

            if unilib.pkg.shared_hook.hook_table.user == nil then

                self.object:remove()
                return self

            end

            self.d = unilib.pkg.shared_hook.hook_table.user:get_look_dir()
            self.fd = minetest.dir_to_facedir(self.d)
            self.uname = unilib.pkg.shared_hook.hook_table.user:get_player_name()
            self.user = unilib.pkg.shared_hook.hook_table.user
            self.locked = unilib.pkg.shared_hook.hook_table.locked
            unilib.pkg.shared_hook.hook_table.user = nil

            if self.fd == 3 then
                self.fd = 1
            elseif self.fd == 1 then
                self.fd = 3
            elseif self.fd == 2 then
                self.fd = 0
            elseif self.fd == 0 then
                self.fd = 2
            end

        end,

        on_step= function(self, dtime)

            self.timer2 = self.timer2 + dtime
            local pos = self.object:get_pos()
            local kill = 0
            if unilib.pkg.shared_hook.has_property(
                {x = pos.x + self.d.x, y = pos.y, z = pos.z + self.d.z},
                "walkable"
            ) and not unilib.pkg.shared_hook.has_property(
                {x = pos.x + self.d.x, y = pos.y + 1, z = pos.z + self.d.z},
                "walkable"
            ) and unilib.pkg.shared_hook.is_hook(pos,self.uname) and
            unilib.pkg.shared_hook.is_hook({x = pos.x, y = pos.y + 1, z = pos.z}, self.uname) then

                kill = 1
                if self.locked then

                    if self.user:get_inventory():contains_item(
                        "main",
                        "unilib:hook_grappling_throw_locked"
                    ) == false then

                        self.object:remove()
                        return self

                    end

                    if unilib.pkg.shared_hook.is_hook(
                        {x = pos.x, y = pos.y + 1, z = pos.z},
                        self.uname
                    ) then

                        minetest.set_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:hook_generic_temp", param2 = self.fd}
                        )
                        minetest.get_meta({x = pos.x, y = pos.y + 1, z = pos.z}):set_int("a", 1)

                    else

                        return self

                    end

                    self.user:get_inventory():remove_item(
                        "main",
                        "unilib:hook_grappling_throw_locked"
                    )

                    for i = 0, 20 do

                        if unilib.pkg.shared_hook.is_hook(
                            {x = pos.x, y = pos.y - i, z = pos.z},
                            self.uname
                        ) then

                            minetest.set_node(
                                {x = pos.x, y = pos.y - i, z = pos.z},
                                {name = "unilib:hook_grappling_throw_locked_temp", param2 = self.fd}
                            )

                        else

                            break

                        end

                        minetest.get_meta(
                            {x = pos.x, y = pos.y - i, z = pos.z}
                        ):set_string("owner", self.uname)

                    end

                else

                    if self.user:get_inventory():contains_item(
                        "main",
                        "unilib:hook_grappling_throw"
                    ) == false then

                        self.object:remove()
                        return self

                    end

                    if unilib.pkg.shared_hook.is_hook(
                        {x = pos.x, y = pos.y + 1, z = pos.z},
                        self.uname
                    ) then

                        minetest.set_node(
                            {x = pos.x, y = pos.y + 1, z = pos.z},
                            {name = "unilib:hook_generic_temp", param2 = self.fd}
                        )
                        minetest.get_meta({x = pos.x, y = pos.y + 1, z = pos.z}):set_int("a", 1)

                    else

                        return self

                    end

                    self.user:get_inventory():remove_item("main", "unilib:hook_grappling_throw")
                    for i = 0, 20 do

                        if unilib.pkg.shared_hook.is_hook(
                            {x = pos.x, y = pos.y - i, z = pos.z},
                            self.uname
                        ) then

                            minetest.set_node(
                                {x = pos.x, y = pos.y - i, z = pos.z},
                                {name = "unilib:hook_grappling_throw_temp", param2 = self.fd}
                            )

                        else

                            break

                        end

                    end

                end

            end

            if self.timer2 > 3 or kill == 1 then
                self.object:remove()
            end

            return self

        end,
    })

end

function unilib.pkg.shared_hook.post()

    -- Handle throwing of hooks
    minetest.register_globalstep(function(dtime)

        unilib.pkg.shared_hook.hook_table.tmp_throw_timer
                = unilib.pkg.shared_hook.hook_table.tmp_throw_timer + dtime

        if unilib.pkg.shared_hook.hook_table.tmp_throw_timer < 0.1 then
            return
        end

        unilib.pkg.shared_hook.hook_table.tmp_throw_timer = 0
        for i, t in pairs(unilib.pkg.shared_hook.hook_table.tmp_throw) do

            t.timer = t.timer - 0.25
            if t.timer <= 0 or t.ob == nil or t.ob:get_pos() == nil then

                table.remove(unilib.pkg.shared_hook.hook_table.tmp_throw, i)
                return

            end

            for ii, ob in pairs(minetest.get_objects_inside_radius(t.ob:get_pos(), 1.5)) do

                if (not ob:get_luaentity()) or
                        (ob:get_luaentity() and (ob:get_luaentity().name ~= "__builtin:item")) then

                    if (not ob:is_player()) or
                            (
                                ob:is_player() and
                                ob:get_player_name(ob) ~= t.user and
                                unilib.pkg.shared_hook.hook_table.pvp
                            ) then

                        ob:set_hp(ob:get_hp() - 5)
                        unilib.pkg.shared_hook.hook_table.punch(ob, ob, 4)
                        t.ob:set_velocity({x = 0, y = 0, z = 0})
                        if ob:get_hp() <= 0 and ob:is_player() == false then
                            ob:remove()
                        end

                        t.ob:set_acceleration({x = 0, y = -10, z = 0})
                        t.ob:set_velocity({x = 0, y = -10, z = 0})
                        table.remove(unilib.pkg.shared_hook.hook_table.tmp_throw, i)

                        break

                    end

                end

            end

        end

    end)

end
