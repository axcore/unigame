---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hook
-- Code:    LGPL-2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hook_grappling_throw_locked = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.hook.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hook_grappling_throw_locked.init()

    return {
        description = "Locked throwable grappling hook",
        notes = "To place the hook, click on a node, or throw the hook towards the node. Only" ..
                " the owner can throw it or break it",
        depends = {"metal_steel", "shared_hook", "hook_grappling_throw"},
    }

end

function unilib.pkg.hook_grappling_throw_locked.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_tool("unilib:hook_grappling_throw_locked", "hook:climb_rope_locked", mode, {
        -- From hook:climb_rope_locked
        description = unilib.brackets(S("Throwable Grappling Hook"), S("Locked")),
        inventory_image = "unilib_hook_grappling_throw_locked.png",

        range = 2,

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then

                unilib.pkg.shared_hook.hook_table.user = user
                unilib.pkg.shared_hook.hook_table.locked = true
                local pos = user:get_pos()
                local d = user:get_look_dir()
                local m = minetest.add_entity(
                    {x = pos.x, y = pos.y + 1.5, z = pos.z},
                    "unilib:entity_hook_grappling"
                )

                m:set_velocity({x = d.x * 15, y = d.y * 15, z = d.z * 15})
                m:set_acceleration({x = 0, y = -5, z = 0})
                minetest.sound_play(
                    "unilib_hook_grappling_throw",
                    {pos = pos, gain = 1.0, max_hear_distance = 5}
                )

                return itemstack

            else

                local pos = pointed_thing.under
                local d = minetest.dir_to_facedir(user:get_look_dir())
                local z = 0
                local x = 0
                local name = user:get_player_name()
                if unilib.pkg.shared_hook.has_property(pos, "walkable") then

                    if d == 0 then
                        z = 1
                    elseif d == 2 then
                        z =- 1
                    elseif d == 1 then
                        x = 1
                    elseif d == 3 then
                        x = -1
                    end

                    if unilib.pkg.shared_hook.is_hook(
                        {x = pos.x + x, y = pos.y, z = pos.z + z},
                        name
                    ) and unilib.pkg.shared_hook.is_hook(
                        {x = pos.x + x, y = pos.y + 1, z = pos.z + z},
                        name
                    ) then

                        minetest.set_node(
                            {x = pos.x + x, y = pos.y + 1, z = pos.z + z},
                            {name = "unilib:hook_generic_temp", param2 = d}
                        )
                        minetest.get_meta(
                            {x = pos.x + x, y = pos.y + 1, z = pos.z + z}
                        ):set_int("a", 1)

                    else

                        return itemstack

                    end

                    itemstack:take_item()
                    for i = 0, 20 do

                        if unilib.pkg.shared_hook.is_hook(
                            {x = pos.x + x, y = pos.y - i, z = pos.z + z},
                            name
                        ) then

                            minetest.set_node(
                                {x = pos.x + x, y = pos.y - i, z = pos.z + z},
                                {name = "unilib:hook_grappling_throw_locked_temp", param2 = d}
                            )

                            minetest.get_meta(
                                {x = pos.x + x, y = pos.y - i, z = pos.z + z}
                            ):set_string("owner", user:get_player_name())

                        else

                            return itemstack

                        end

                    end

                end

                return itemstack

            end

        end,
    })
    unilib.register_craft({
        -- From hook:climb_rope_locked
        output = "unilib:hook_grappling_throw_locked",
        recipe = {
            {"unilib:hook_grappling_throw", c_ingot, ""},
        }
    })

    unilib.register_node("unilib:hook_grappling_throw_locked_temp", "hook:rope3", mode, {
        -- From hook:rope3
        description = S("Rope"),
        tiles = {"unilib_hook_rope_temp.png"},
        groups = {dig_immediate = 3, not_in_creative_inventory = 1, rope = 1},
        sounds = {
            footstep = {name = "unilib_hook_grappling", gain = 1},
        },

        drawtype = "nodebox",
        drop = "",
        is_ground_content = false,
        liquid_alternative_flowing = "unilib:hook_grappling_throw_locked_temp",
        liquid_alternative_source = "unilib:hook_grappling_throw_locked_temp",
        liquid_range = 0,
        liquid_renewable = false,
        liquid_viscosity = 1,
        liquidtype = "source",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.0625, -0.5, -0.5, 0.0625, 0.5, -0.375},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = false,
        walkable = false,

        can_dig = function(pos, player)

            if minetest.get_meta(pos):get_string("owner") ~= player:get_player_name() then

                minetest.chat_send_player(
                    player:get_player_name(),
                    S("This rope is owned by @1"), minetest.get_meta(pos):get_string("owner")
                )

                return false

            end

            return true

        end,

        on_punch = function(pos, node, puncher, pointed_thing)

            if minetest.get_meta(pos):get_string("owner") ~= puncher:get_player_name() then

                minetest.chat_send_player(
                    puncher:get_player_name(),
                    S("This rope is owned by %s"), minetest.get_meta(pos):get_string("owner")
                )

                return false

            end

            puncher:get_inventory():add_item(
                "main",
                ItemStack("unilib:hook_grappling_throw_locked")
            )

            local n2d = {
                ["unilib:hook_grappling_throw_locked_temp"] = true,
                ["unilib:hook_generic_temp"] = true,
            }

            for i = 0 , 21 do

                local p = {x = pos.x, y = pos.y + i, z = pos.z}
                if n2d[minetest.get_node(p).name] then
                    minetest.remove_node(p)
                else
                    break
                end

            end

            for i = 1, 21 do

                local p = {x = pos.x, y = pos.y - i, z = pos.z}
                if n2d[minetest.get_node(p).name] then
                    minetest.remove_node(p)
                else
                    break
                end

            end

        end,
    })

end
