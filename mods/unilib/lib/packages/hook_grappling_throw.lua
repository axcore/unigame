---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hook
-- Code:    LGPL-2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.hook_grappling_throw = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.hook.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.hook_grappling_throw.init()

    return {
        description = "Throwable grappling hook",
        notes = "To place the hook, click on a node, or throw the hook towards the node",
        depends = {"metal_steel", "shared_hook"},
    }

end

function unilib.pkg.hook_grappling_throw.exec()

    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_tool("unilib:hook_grappling_throw", "hook:climb_rope", mode, {
        -- From hook:climb_rope
        description = S("Throwable Grappling Hook"),
        inventory_image = "unilib_hook_grappling_throw.png",

        range = 2,

        on_use = function(itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then

                unilib.pkg.shared_hook.hook_table.user = user
                unilib.pkg.shared_hook.hook_table.locked = false
                local pos = user:get_pos()
                local d = user:get_look_dir()
                local m = core.add_entity(
                    {x = pos.x, y = pos.y + 1.5, z = pos.z},
                    "unilib:entity_hook_grappling"
                )

                m:set_velocity({x = d.x * 15, y = d.y * 15, z = d.z * 15})
                m:set_acceleration({x = 0, y = -5, z = 0})
                core.sound_play(
                    "unilib_hook_grappling_throw",
                    {pos = pos, gain = 1.0, max_hear_distance = 5}
                )

                return itemstack

            else

                local pos = pointed_thing.under
                local d = core.dir_to_facedir(user:get_look_dir())
                local z = 0
                local x = 0
                local name = user:get_player_name()
                if unilib.pkg.shared_hook.has_property(pos, "walkable") then

                    if d == 0 then
                        z = 1
                    elseif d == 2 then
                        z = -1
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

                        core.set_node(
                            {x = pos.x + x, y = pos.y + 1, z = pos.z + z},
                            {name = "unilib:hook_generic_temp", param2 = d}
                        )

                        core.get_meta(
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

                            core.set_node(
                                {x = pos.x + x, y = pos.y - i, z = pos.z + z},
                                {name = "unilib:hook_grappling_throw_temp", param2 = d}
                            )

                        else

                            return itemstack

                        end

                    end

                end

                return itemstack

            end

        end
    })
    unilib.register_craft({
        -- From hook:climb_rope
        output = "unilib:hook_grappling_throw",
        recipe = {
            {"", c_ingot, ""},
            {"", "unilib:metal_steel_block", ""},
            {"", c_ingot, ""},
        },
    })

    unilib.register_node("unilib:hook_grappling_throw_temp", "hook:rope2", mode, {
        -- From hook:rope2
        description = S("Rope"),
        tiles = {"unilib_hook_rope_temp.png"},
        groups = {dig_immediate = 3, not_in_creative_inventory = 1, rope = 1},
        sounds = {
            footstep = {name = "unilib_hook_grappling", gain = 1},
        },

        drawtype = "nodebox",
        drop = "",
        is_ground_content = false,
        liquid_alternative_flowing = "unilib:hook_grappling_throw_temp",
        liquid_alternative_source = "unilib:hook_grappling_throw_temp",
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

        on_punch = function(pos, node, puncher, pointed_thing)

            if core.is_protected(pos,puncher:get_player_name()) then
                return false
            end

            puncher:get_inventory():add_item("main", ItemStack("unilib:hook_grappling_throw"))
            local n2d = {
                ["unilib:hook_grappling_throw_temp"] = true,
                ["unilib:hook_generic_temp"] = true,
            }

            for i = 0, 21 do

                local p = {x = pos.x, y = pos.y + i, z = pos.z}
                if n2d[core.get_node(p).name] then
                    core.remove_node(p)
                else
                    break
                end

            end

            for i = 1, 21 do

                local p = {x = pos.x, y = pos.y - i, z = pos.z}
                if n2d[core.get_node(p).name] then
                    core.remove_node(p)
                else
                    break
                end

            end

        end,
    })

end
