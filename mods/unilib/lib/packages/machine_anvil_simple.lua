---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_anvil_simple = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.cottages.add_mode

-- N.B. The formspec provided by the cottages mod is untidy, so I have rearranged it
--[[
local anvil_formspec = "size[8,8]" ..
        "image[7,3;1,1;unilib_tool_hammer_blacksmith.png]" ..
        "list[current_name;input;2.5,1.5;1,1;]" ..
        "list[current_name;hammer;5,3;1,1;]" ..
        "label[2.5,1.0;" .. S("Workpiece") .. ":]" ..
        "label[6.0,2.7;" .. S("Optional") .. "]" ..
        "label[6.0,3.0;" .. S("storage for") .. "]" ..
        "label[6.0,3.3;" .. S("your hammer") .. "]" ..
        "label[0,-0.5;" .. S("Anvil") .. "]" ..
        "label[0,3.0;" .. S("Punch anvil with hammer") .. "]" ..
        "label[0,3.3;" .. S("to repair tool in slot") .. "]" ..
        "list[current_player;main;0,4;8,4;]"
]]--
local anvil_formspec = "size[8,7]" ..
        "image[0,1;1,1;unilib_tool_pick_stone.png]" ..
        "image[0,2;1,1;unilib_tool_hammer_blacksmith.png]" ..
        "list[current_name;input;1,1;1,1;]" ..
        "list[current_name;hammer;1,2;1,1;]" ..
        "label[0.1,0.1;" .. FS("Simple Anvil (punch with hammer to repair tools)") .. "]" ..
        "label[2,1.2;" .. FS("Tool slot") .. "]" ..
        "label[2,2.2;" .. FS("Optional storage for hammers") .. "]" ..
        "list[current_player;main;0,3;8,4;]"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_anvil_simple.init()

    return {
        description = "Simple anvil",
        notes = "Use together with a hammer to repair tools. If you don't want inappropriate" ..
                " tools from technic (and similar mods) to be repairable, add the" ..
                " \"shared_anvil\" package to your remix",
        depends = "metal_steel",
        optional = "shared_anvil",
    }

end

function unilib.pkg.machine_anvil_simple.exec()

    unilib.register_node("unilib:machine_anvil_simple", "cottages:anvil", mode, {
        -- From cottages:anvil
        description = S("Simple Anvil"),
        tiles = {"unilib_metal_iron_wrought_block.png"},
        groups = {cracky = 2},
        -- N.B. no sounds in original code
        sounds = unilib.global.sound_table.metal,

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

        after_place_node = function(pos, placer)

            local meta = core.get_meta(pos)
            meta:set_string("owner", placer:get_player_name() or "")
            meta:set_string(
                "infotext",
                S("Simple Anvil (owned by %s)"):format((meta:get_string("owner") or ""))
            )
            meta:set_string(
                "formspec",
                anvil_formspec,
                "label[4,1.2;" .. FS("Owner: %s"):format(meta:get_string("owner") or "") .. "]"
            )

        end,

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            local meta = core.get_meta(pos)
            if player and
                    player:get_player_name() ~= meta:get_string("owner") and
                    from_list ~= "input" then
                return 0
            else
                return count
            end

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = core.get_meta(pos)

            if player and
                    player:get_player_name() ~= meta:get_string("owner") and
                    listname ~= "input" then
                return 0
            end

            if listname == "hammer" and
                    stack and
                    stack:get_name() ~= "unilib:tool_hammer_blacksmith" then
                return 0
            end

            if listname == "input" and (
                stack:get_wear() == 0 or
                unilib.global.tool_no_repair_table[stack:get_name()] ~= nil
            ) then

                core.chat_send_player(
                    player:get_player_name(),
                    S("The tool slot is only for damaged tools")
                )

                return 0

            end

            if listname == "input" and
                    unilib.global.tool_no_repair_table[stack:get_name()] ~= nil then

                core.chat_send_player(
                    player:get_player_name(),
                    S(unilib.global.tool_no_repair_table[stack:get_name()])
                )

                return 0

            end

            return stack:get_count()

        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            local meta = core.get_meta(pos)
            if player and
                    player:get_player_name() ~= meta:get_string("owner") and
                    listname ~= "input" then
                return 0
            end

            return stack:get_count()

        end,

        can_dig = function(pos,player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local owner = meta:get_string("owner")

            if (
                not(inv:is_empty("input")) or
                not(inv:is_empty("hammer")) or
                not(player) or
                (owner and owner ~= "" and player:get_player_name() ~= owner)
            ) then
               return false
            else
                return true
            end

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("infotext", S("Simple Anvil"))
            local inv = meta:get_inventory()
            inv:set_size("input", 1)
            inv:set_size("hammer", 1)
            meta:set_string("formspec", anvil_formspec)

        end,

        on_punch = function(pos, node, puncher)

            if not(pos) or not(node) or not(puncher) then
                return
            end

            -- Only punching with the hammer works
            local wielded = puncher:get_wielded_item()
            if not(wielded) or
                    not(wielded:get_name()) or
                    wielded:get_name() ~= "unilib:tool_hammer_blacksmith" then
                return
            end

            local name = puncher:get_player_name()
            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local input = inv:get_stack("input", 1)

            -- Only tools can be repaired
            if not(input) or
                    input:is_empty() or
                    unilib.global.tool_no_repair_table[input:get_name()] ~= nil then

                meta:set_string(
                    "formspec",
                    anvil_formspec,
                    "label[4,1.2;" .. FS("Owner: %s"):format(meta:get_string("owner") or "") .. "]"
                )

                return

            end

            -- Minetest max damage is 65535
            -- N.B. Because 65536 / 40 is slightly higher than 1638, this unilib calculation may
            --      produce a slightly higher value (e.g. 21 rather than 20)
--          local damage_state = 40 - math.floor(input:get_wear() / 1638)
            local damage_state = 40 -
                    math.floor(input:get_wear() / (unilib.constant.max_tool_wear / 40))

            -- Just to make sure that it really can't get repaired if it should not (e.g. if the
            --      check of placing the item in the input slot failed somehow)
            if puncher and name and unilib.global.tool_no_repair_table[input:get_name()] ~= nil then

                core.chat_send_player(
                    name,
                    S(unilib.global.tool_no_repair_table[input:get_name()])
                )

                return

            end

            -- Limit tool repairability, if enabled
            local input_meta = input:get_meta()
            local max_repair = input_meta:get_string("max_repair")
            if max_repair == "" then

                -- This tool has never been repaired by unilib anvils
                max_repair = "0"
                input_meta:set_string("max_repair", max_repair)

            end

            max_repair = tonumber(max_repair)
            if max_repair >= input:get_wear() then

                core.chat_send_player(
                    puncher:get_player_name(),
                    S("Your tool has reached its repair limit")
                )

                return

            end

            -- Update the HUD
            local tool_name = input:get_name()
            local hud_image = ""
            if tool_name and core.registered_items[tool_name] then

                if core.registered_items[tool_name].inventory_image then

                    hud_image = core.registered_items[tool_name].inventory_image

                elseif core.registered_items[tool_name].textures and
                        type(core.registered_items[tool_name].textures) == "table" then

                    hud_image = core.registered_items[tool_name].textures[1]

                elseif core.registered_items[tool_name].textures and
                        type(core.registered_items[tool_name].textures) == "string" then

                    hud_image = core.registered_items[ tool_name ].textures

                end

            end

            local hud1 = puncher:hud_add({
                name = "anvil_1",
                type = "image",

                alignment = {x = 0, y = 0},
                position = {x = 0.5, y = 0.5},
                scale = {x = 15, y = 15},
                text = hud_image,
            })

            local hud2 = nil
            local hud3 = nil

            if input:get_wear() > 0 then

                hud2 = puncher:hud_add({
                    name = "anvil_2",
                    type = "statbar",

                    alignment = {x = 0, y = 0},
                    direction = 0,  -- Left to right
                    number = 40,
                    position = {x = 0.5, y = 0.65},
                    offset = {x = -320, y = 0},
                    size = {x = 32, y = 32},
                    text = "unilib_misc_cloud_ordinary.png^[colorize:#ff0000:256",
                })

                hud3 = puncher:hud_add({
                    name = "anvil_3",
                    type = "statbar",

                    alignment = {x = 0, y = 0},
                    direction = 0,  -- Left to right
                    number = damage_state,
                    offset = {x = -320, y = 0},
                    position = {x = 0.5, y = 0.65},
                    size = {x = 32, y = 32},
                    text = "unilib_misc_cloud_ordinary.png^[colorize:#00ff00:256",
                })

            end

            core.after(2, function()

                if puncher then
                    if hud1 then puncher:hud_remove(hud1) end
                    if hud2 then puncher:hud_remove(hud2) end
                    if hud3 then puncher:hud_remove(hud3) end
                end

            end)

            -- Notify the player when the job is done (commented out in original code, but included
            --      here to match the behaviour of the fancy anvil)
            if input:get_wear() == 0 then

                core.chat_send_player(
                    puncher:get_player_name(),
                    S("Your tool has been repaired successfully")
                )

                return

            end

            -- Adjust tool repairability limit, if enabled
            if unilib.setting.tool_limit_repair_factor > 0 then

                max_repair = max_repair + math.floor(
                    unilib.constant.max_tool_wear * unilib.setting.tool_limit_repair_factor
                )

                input_meta:set_string("max_repair", max_repair)

            end

            -- Do the actual repair, equal to what technic toolship does in 5 seconds
            local this_repair =
                    math.floor(unilib.constant.max_tool_wear * unilib.setting.tool_repair_factor)
            if (input:get_wear() - this_repair) < max_repair then
                input:set_wear(max_repair)
            else
                input:add_wear(this_repair * -1)
            end

            -- Damage the hammer slightly
            wielded:add_wear(100)
            puncher:set_wielded_item(wielded)

            -- Update the tool's description (if toolranks-style tooltips are visible)
            if unilib.setting.toolranks_enable_flag then

                local def_table = input:get_definition()
                local description = def_table.original_description or ""
                local dug = tonumber(input_meta:get_string("dug")) or 0

                input_meta:set_string(
                    "description",
                    unilib.tools.prepare_toolranks_description(
                        description, def_table.tool_type, dug, max_repair
                    )
                )

            end

            -- Return the tool to its inventory
            inv:set_stack("input", 1, input)

        end,
    })
    unilib.register_craft({
        output = "unilib:machine_anvil_simple",
        recipe = {
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
            {"", "unilib:metal_steel_ingot", ""},
            {"unilib:metal_steel_ingot", "unilib:metal_steel_ingot", "unilib:metal_steel_ingot"},
        },
    })

end
