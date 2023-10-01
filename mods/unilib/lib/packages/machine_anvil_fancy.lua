---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    anvil
-- Code:    GPL-3.0-only
-- Media:   GPL-3.0-only
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_anvil_fancy = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.anvil.add_mode

local item_displacement = 2 / 16
local hud_timeout = 2
local temp_table = {}
local hud_info_by_puncher_name_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function remove_item(pos, node)

    local obj_table = minetest.get_objects_inside_radius(
        {x = pos.x, y = pos.y + item_displacement, z = pos.z},
        0.5
    )

    if obj_table then

        for _, obj in ipairs(obj_table) do

            if obj and
                    obj:get_luaentity() and
                    obj:get_luaentity().name == "unilib:entity_machine_anvil_fancy" then
                obj:remove()
            end

        end

    end

end

local function update_item(pos, node)

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if not inv:is_empty("input") then

        pos.y = pos.y + item_displacement
        temp_table.nodename = node.name
        temp_table.texture = inv:get_stack("input", 1):get_name()
        local e = minetest.add_entity(pos, "unilib:entity_machine_anvil_fancy")
        local yaw = math.pi * 2 - node.param2 * math.pi / 2
        --[[
        if e.set_rotation == nil then

            -- This was for Minetest 0.4.16 support, remove it eventually
            e:set_yaw(yaw)
            pos.y = pos.y + 5 / 16
            e:set_pos(pos)

        else

            -- x is pitch, 1.5708 is 90 degrees
            e:set_rotation({x = -1.5708, y = yaw, z = 0})

        end
        ]]--
        -- x is pitch, 1.5708 is 90 degrees
        e:set_rotation({x = -1.5708, y = yaw, z = 0})

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_anvil_fancy.init()

    return {
        description = "Fancy anvil",
        notes = "Use together with a hammer to repair tools. If you don't want inappropriate" ..
                " tools from technic (and similar mods) to be repairable, add the" ..
                " \"shared_anvil\" package to your remix. Place paper and the anvil in a" ..
                " crafting grid to generate a \"shared\" anvil",
        depends = {"metal_bronze", "metal_steel"},
        optional = {"item_paper_ordinary", "shared_anvil"},
    }

end

function unilib.pkg.machine_anvil_fancy.exec()

    unilib.register_entity("unilib:entity_machine_anvil_fancy", {
        -- From anvil:item
        collisionbox = {0, 0, 0, 0, 0, 0},
        hp_max = 1,
        physical = false,
        textures = {"air"},
        visual = "wielditem",
        visual_size = {x = 0.33, y = 0.33},

        get_staticdata = function(self)

            if self.nodename ~= nil and self.texture ~= nil then
                return self.nodename .. ";" .. self.texture
            end

            return ""

        end,

        on_activate = function(self, staticdata)

            if temp_table.nodename ~= nil and temp_table.texture ~= nil then

                self.nodename = temp_table.nodename
                temp_table.nodename = nil
                self.texture = temp_table.texture
                temp_table.texture = nil

            else

                if staticdata ~= nil and staticdata ~= "" then

                    local data = staticdata:split(";")
                    if data and data[1] and data[2] then

                        self.nodename = data[1]
                        self.texture = data[2]

                    end

                end

            end

            if self.texture ~= nil then
                self.object:set_properties({textures = {self.texture}})
            end

        end,
    })

    minetest.register_globalstep(function()

        local now = os.time()

        for puncher_name, hud_info in pairs(hud_info_by_puncher_name_table) do

            local hud2, hud3, hud_expire_time = unpack(hud_info)
            if now > hud_expire_time then

                local puncher = minetest.get_player_by_name(puncher_name)
                if puncher then

                    local hud2_def = puncher:hud_get(hud2)
                    if hud2_def and hud2_def.name == "anvil_background" then
                        puncher:hud_remove(hud2)
                    end

                    local hud3_def = puncher:hud_get(hud3)
                    if hud3_def and hud3_def.name == "anvil_foreground" then
                        puncher:hud_remove(hud3)
                    end

                end

                hud_info_by_puncher_name_table[puncher_name] = nil

            end

        end

    end)

    unilib.register_node("unilib:machine_anvil_fancy", "anvil:anvil", mode, {
        -- From anvil:anvil
        description = S("Fancy Anvil"),
        -- N.B. Replaced the original mod's stone texture with this texture set, which looks more
        --      like the craft recipe
        tiles = {
            "unilib_metal_bronze_block.png",
            "unilib_metal_steel_block.png",
        },
        groups = {cracky = 2},
        sounds = unilib.sound_table.metal,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.3, 0.5, -0.4, 0.3},
                {-0.35, -0.4, -0.25, 0.35, -0.3, 0.25},
                {-0.3, -0.3, -0.15, 0.3, -0.1, 0.15},
                {-0.35, -0.1, -0.2, 0.35, 0.1, 0.2},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.3, 0.5, -0.4, 0.3},
                {-0.35, -0.4, -0.25, 0.35, -0.3, 0.25},
                {-0.3, -0.3, -0.15, 0.3, -0.1, 0.15},
                {-0.35, -0.1, -0.2, 0.35, 0.1, 0.2},
            },
        },

        after_place_node = function(pos, placer, itemstack)

            local meta = minetest.get_meta(pos)
            local stackmeta = itemstack:get_meta()
            if stackmeta:get_int("shared") == 1 then

                meta:set_int("shared", 1)
                meta:set_string("infotext", S("Shared Fancy Anvil"))

            else

                meta:set_string("owner", placer:get_player_name() or "")
                meta:set_string("infotext", S("@1's Fancy Anvil", placer:get_player_name()))

            end

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            if listname ~= "input" then
                return 0
            end

            local player_name = player:get_player_name()
            if stack:get_wear() == 0 then

                minetest.chat_send_player(player_name, S("This anvil is only for damaged tools"))
                return 0

            end

            local stack_name = stack:get_name()
            if unilib.tool_no_repair_table[stack_name] ~= nil then

                minetest.chat_send_player(player_name, unilib.tool_no_repair_table[stack_name])
                return 0

            end

            if meta:get_inventory():room_for_item("input", stack) then
                return stack:get_count()
            end

            return 0

        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            if listname ~= "input" then
                return 0
            end

            return stack:get_count()

        end,

        can_dig = function(pos, player)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()

            if not inv:is_empty("input") then
                return false
            end

            return true

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("input", 1)

        end,

        on_punch = function(pos, node, puncher)

            if not pos or not node or not puncher then
                return
            end

            local wielded = puncher:get_wielded_item()
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local owner = meta:get_string("owner")
            local shared = meta:get_int("shared") == 1
            local puncher_name = puncher:get_player_name()
            if not shared and owner ~= puncher_name then
                return
            end

            if wielded:get_count() == 0 then

                if not inv:is_empty("input") then

                    local return_stack = inv:get_stack("input", 1)
                    inv:set_stack("input", 1, nil)

                    local wield_index = puncher:get_wield_index()
                    puncher:get_inventory():set_stack("main", wield_index, return_stack)
                    if shared then
                        meta:set_string("infotext", S("Shared Fancy Anvil"))
                    else
                        meta:set_string("infotext", S("@1's Fancy Anvil", owner))
                    end

                    remove_item(pos, node)

                end

            end

            -- Only punching with the hammer is supposed to work
            if wielded:get_name() ~= "unilib:tool_hammer_blacksmith" then
                return
            end

            local input = inv:get_stack("input", 1)

            -- Only tools can be repaired
            if not input or input:is_empty() then
                return
            end

            -- 65535 is max damage
            local damage_state = 40 - math.floor(input:get_wear() / 1638)

            local tool_name = input:get_name()

            if input:get_wear() > 0 then

                local hud2, hud3, hud3_def, _

                if hud_info_by_puncher_name_table[puncher_name] then

                    hud2, hud3, _ = unpack(hud_info_by_puncher_name_table[puncher_name])
                    hud3_def = puncher:hud_get(hud3)

                end

                if hud3_def and hud3_def.name == "anvil_foreground" then

                    puncher:hud_change(hud3, "number", damage_state)

                else

                    hud2 = puncher:hud_add({
                        name = "anvil_background",
                        hud_elem_type = "statbar",

                        alignment = {x = 0, y = 0},
                        direction = 0,
                        number = 40,
                        offset = {x = -320, y = 0},
                        position = {x = 0.5, y = 0.65},
                        size = {x = 32, y = 32},
                        text = "unilib_misc_cloud_ordinary.png^[colorize:#ff0000:256",
                    })

                    hud3 = puncher:hud_add({
                        name = "anvil_foreground",
                        hud_elem_type = "statbar",

                        alignment = {x = 0, y = 0},
                        direction = 0,
                        number = damage_state,
                        offset = {x = -320, y = 0},
                        position = {x = 0.5, y = 0.65},
                        size = {x = 32, y = 32},
                        text = "unilib_misc_cloud_ordinary.png^[colorize:#00ff00:256",
                    })

                end

                hud_info_by_puncher_name_table[puncher_name] = {hud2, hud3, os.time() + hud_timeout}

            end

            -- Tell the player when the job is done
            if input:get_wear() == 0 then

                -- ...but only once
                if 0 < meta:get_int("informed") then
                    return
                end

                meta:set_int("informed", 1)
                local tool_desc
                local meta_description = input:get_meta():get_string("description")
                if "" ~= meta_description then
                    tool_desc = meta_description
                elseif minetest.registered_items[tool_name] and
                        minetest.registered_items[tool_name].description then
                    tool_desc = minetest.registered_items[tool_name].description
                else
                    tool_desc = tool_name
                end

                minetest.chat_send_player(
                    puncher_name,
                    S("Your @1 has been repaired successfully", unilib.get_first_line(tool_desc))
                )

                return

            else

                pos.y = pos.y + item_displacement
                minetest.sound_play({name = "unilib_machine_anvil_fancy_clang"}, {pos = pos})
                minetest.add_particlespawner({
                    amount = 10,
                    time = 0.1,

                    collisiondetection = true,
                    minacc = {x = 0, y = -10, z = 0},
                    maxacc = {x = 0, y = -10, z = 0},
                    minexptime = 0.5,
                    maxexptime = 1,
                    minpos = pos,
                    maxpos = pos,
                    minsize = 1,
                    maxsize = 1,
                    minvel = {x = 2, y = 3, z = 2},
                    maxvel = {x = -2, y = 1, z = -2},
                    texture = "unilib_machine_anvil_fancy_spark.png",
                    vertical = false,
                })
            end

            -- Do the actual repair. -5000 equals what technic toolshop does in 5 seconds
            input:add_wear(-5000)
            inv:set_stack("input", 1, input)

            -- Damage the hammer slightly
            wielded:add_wear(100)
            puncher:set_wielded_item(wielded)

        end,

        on_rightclick = function(pos, node, clicker, itemstack)

            if not clicker or not itemstack then
                return
            end

            local meta = minetest.get_meta(pos)
            local name = clicker:get_player_name()
            local owner = meta:get_string("owner")
            local shared = meta:get_int("shared") == 1

            if name ~= owner and not shared then
                return itemstack
            end

            if itemstack:get_count() == 0 then

                local inv = meta:get_inventory()
                if not inv:is_empty("input") then

                    local return_stack = inv:get_stack("input", 1)
                    inv:set_stack("input", 1, nil)

                    local wield_index = clicker:get_wield_index()
                    clicker:get_inventory():set_stack("main", wield_index, return_stack)
                    if shared then
                        meta:set_string("infotext", S("Shared Fancy Anvil"))
                    else
                        meta:set_string("infotext", S("@1's Fancy Anvil", owner))
                    end

                    remove_item(pos, node)
                    return return_stack

                end
            end

            local this_def = minetest.registered_nodes[node.name]
            if this_def.allow_metadata_inventory_put(
                pos, "input", 1, itemstack:peek_item(), clicker
            ) > 0 then

                local s = itemstack:take_item()
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                inv:add_item("input", s)
                local meta_description = s:get_meta():get_string("description")
                if "" ~= meta_description then

                    if shared then

                        meta:set_string("infotext", S("Shared Fancy Anvil"))

                    else

                        meta:set_string(
                            "infotext", S("@1's Fancy Anvil", owner) .. "\n" ..
                                    unilib.get_first_line(meta_description)
                        )

                    end

                end

                meta:set_int("informed", 0)
                update_item(pos, node)

            end

            return itemstack

        end,

        preserve_metadata = function(pos, oldnode, oldmeta, drops)

            if next(drops) and tonumber(oldmeta.shared) == 1 then

                local meta = drops[next(drops)]:get_meta()
                meta:set_int("shared", 1)
                meta:set_string("description", S("Shared Fancy Anvil"))

            end

            return drops

        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:machine_anvil_fancy",
        recipe = {
            {"unilib:metal_bronze_ingot", "unilib:metal_bronze_ingot", "unilib:metal_bronze_ingot"},
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"}
        }
    })
    if unilib.pkg_executed_table["item_paper_ordinary"] ~= nil then

        -- When placed in the crafting grid with paper, generate a "shared" anvil
        local anvil_stack = ItemStack("unilib:machine_anvil_fancy")
        anvil_stack:get_meta():set_int("shared", 1)
        anvil_stack:get_meta():set_string("description", S("Shared Fancy Anvil"))
        unilib.register_craft({
            output = anvil_stack:to_string(),
            type = "shapeless",
            recipe = {"unilib:machine_anvil_fancy", "unilib:item_paper_ordinary"}
        })

    end

    -- Automatically restore entities lost due to /clearobjects or similar
    unilib.register_lbm({
        label = "Restore anvil entities [machine_anvil_fancy]",
        name = "unilib:lbm_machine_anvil_fancy_restore",
        nodenames = {"unilib:machine_anvil_fancy"},

        run_at_every_load = true,

        action = function(pos, node, active_object_count, active_object_count_wider)

            local test_pos = {x = pos.x, y = pos.y + item_displacement, z = pos.z}
            if #minetest.get_objects_inside_radius(test_pos, 0.5) > 0 then
                return
            end

            update_item(pos, node)

        end
    })

end
