---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hook
-- Code:    LGPL-2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hook_grappling = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.hook.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hook_grappling.init()

    return {
        description = "Grappling hook",
        notes = "To place the hook, click on a node edge. For higher edges, use the hook with" ..
                " the longer rope",
        depends = {"metal_steel", "shared_hook"},
    }

end

function unilib.pkg.hook_grappling.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_tool("unilib:hook_grappling", "hook:hook", mode, {
        -- From hook:hook
        description = unilib.hint(S("Grappling Hook"), S("hit a corner to climb")),
        inventory_image = "unilib_hook_grappling.png",

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then
                return itemstack
            end

            local d = minetest.dir_to_facedir(user:get_look_dir())
            local pos = pointed_thing.above
            local pos2 = pointed_thing.under
            local name = user:get_player_name()

            if unilib.pkg.shared_hook.has_property(pos2, "walkable") and
            unilib.pkg.shared_hook.has_property({x = pos.x, y = pos.y - 1, z = pos.z}, "walkable")
                    == false and
            (
                unilib.pkg.shared_hook.has_property(
                    {x = pos2.x, y = pos2.y + 1, z = pos2.z},
                    "walkable"
                ) == false or
                minetest.get_node({x = pos2.x, y = pos2.y + 1, z = pos2.z}).name
                        == "unilib:snow_ordinary"
            ) and
            unilib.pkg.shared_hook.is_hook(pos,name) and
            unilib.pkg.shared_hook.has_property({x = pos.x, y = pos.y + 1, z = pos.z}, "walkable")
                    == false then

                if d == 3 then
                    d = 1
                elseif d == 1 then
                    d = 3
                elseif d == 2 then
                    d = 0
                elseif d == 0 then
                    d = 2
                end

                if unilib.pkg.shared_hook.is_hook({x = pos.x, y = pos.y + 1, z = pos.z}, name) then

                    minetest.set_node(
                        {x = pos.x, y = pos.y + 1, z = pos.z},
                        {name = "unilib:hook_generic_temp", param2 = d}
                    )
                    minetest.get_node_timer({x = pos.x, y = pos.y + 1, z = pos.z}):start(3)

                else

                    return itemstack

                end

                for i = 0, -4, -1 do

                    if unilib.pkg.shared_hook.is_hook(
                        {x = pos.x, y = pos.y + i, z = pos.z},
                        name
                    ) then

                        minetest.set_node(
                            {x = pos.x, y = pos.y + i, z = pos.z},
                            {name = "unilib:hook_grappling_temp", param2 = d}
                        )

                    else

                        return itemstack

                    end

                end

            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From hook:hook
        output = "unilib:hook_grappling",
        recipe = {
            {"", c_ingot, ""},
            {"", c_ingot, c_ingot},
            {c_ingot, "", ""},
        }
    })

    unilib.register_tool("unilib:hook_grappling_long", "hook:hook_upgrade", mode, {
        -- From hook:hook_upgrade
        description = unilib.hint(S("Grappling Hook with Long Rope"), S("hit a corner to climb")),
        inventory_image = "unilib_hook_grappling_long.png",

        range = 6,

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then
                return itemstack
            end

            local d = minetest.dir_to_facedir(user:get_look_dir())
            local pos = pointed_thing.above
            local pos2 = pointed_thing.under
            local name = user:get_player_name()

            if unilib.pkg.shared_hook.has_property(pos2, "walkable") and
            unilib.pkg.shared_hook.has_property({x = pos.x, y = pos.y - 1, z = pos.z}, "walkable")
                    == false and
            (
                unilib.pkg.shared_hook.has_property(
                    {x = pos2.x, y = pos2.y + 1, z = pos2.z},
                    "walkable"
                ) == false or
                minetest.get_node({x = pos2.x, y = pos2.y + 1, z = pos2.z}).name
                        == "unilib:snow_ordinary"
            ) and
            unilib.pkg.shared_hook.is_hook(pos, name) and
            unilib.pkg.shared_hook.has_property({x = pos.x, y = pos.y + 1, z = pos.z}, "walkable")
                    == false then

                if d == 3 then
                    d = 1
                elseif d == 1 then
                    d = 3
                elseif d == 2 then
                    d = 0
                elseif d == 0 then
                    d = 2
                end

                if unilib.pkg.shared_hook.is_hook({x = pos.x, y = pos.y + 1, z = pos.z}, name) then

                    minetest.set_node(
                        {x = pos.x, y = pos.y + 1, z = pos.z},
                        {name = "unilib:hook_generic_temp", param2 = d}
                    )
                    minetest.get_node_timer({x = pos.x, y = pos.y + 1, z = pos.z}):start(3)

                else

                    return itemstack

                end

                for i = 0, -8, -1 do

                    if unilib.pkg.shared_hook.is_hook(
                        {x = pos.x, y = pos.y + i, z = pos.z},
                        name
                    ) then

                        minetest.set_node(
                            {x = pos.x, y = pos.y + i, z = pos.z},
                            {name = "unilib:hook_grappling_temp", param2 = d}
                        )

                    else

                        return itemstack

                    end

                end

            end

            return itemstack

        end,
    })
    unilib.register_craft({
        -- From hook:hook_upgrade
        output = "unilib:hook_grappling_long",
        recipe = {
            {"", "unilib:hook_grappling", ""},
            {"", "unilib:hook_grappling", ""},
            {"", c_ingot, ""},
        }
    })

    unilib.register_node("unilib:hook_grappling_temp", "hook:rope", mode, {
        -- From hook:rope
        description = S("Rope"),
        tiles = {"unilib_hook_rope_temp.png"},
        groups = {dig_immediate = 3, not_in_creative_inventory = 1, rope = 1},
        sounds = {
            footstep = {name = "unilib_hook_grappling", gain = 1},
        },

        buildable_to = true,
        drawtype = "nodebox",
        drop = "",
        is_ground_content = false,
        liquid_alternative_flowing = "unilib:hook_grappling_temp",
        liquid_alternative_source = "unilib:hook_grappling_temp",
        liquid_range = 0,
        liquid_renewable = false,
        liquid_viscosity = 1,
        liquidtype = "source",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.0625, -0.5, -0.5, 0.0625, 0.5, -0.375},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = false,
        walkable = false,

        on_construct = function(pos)
            minetest.get_node_timer(pos):start(3)
        end,

        on_timer = function(pos, elapsed)

            for i, ob in pairs(minetest.get_objects_inside_radius(pos, 3)) do

                if ob:is_player() then
                    return true
                end

            end

            minetest.set_node(pos, {name = "air"})
            return false

        end,
    })

end
