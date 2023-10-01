---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_threshing = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

-- N.B. The formspec provided by the cottages mod is untidy, so I have rearranged it
--[[
local thresh_formspec = "size[8,8]" ..
        "image[1.5,0;1,1;unilib_item_stick_ordinary.png]" ..
        "image[0,1;1,1;unilib_crop_wheat_harvest.png]" ..
        "button_exit[6.8,0.0;1.5,0.5;public;" .. S("Public?") .. "]" ..
        "list[current_name;harvest;1,1;2,1;]" ..
        "list[current_name;straw;5,0;2,2;]" ..
        "list[current_name;seeds;5,2;2,2;]" ..
        "label[1,0.5;" .. S("Harvested wheat:") .. "]" ..
        "label[4,0.0;" .. S("Straw:") .. "]" ..
        "label[4,2.0;" .. S("Seeds:") .. "]" ..
        "label[0,-0.5;" .. S("Threshing floor") .. "]" ..
        "label[0,2.5;" .. S("Punch threshing floor with a stick") .. "]" ..
        "label[0,3.0;" .. S("to get straw and seeds from wheat.") .. "]" ..
        "list[current_player;main;0,4;8,4;]"
]]--
local thresh_formspec = "size[8,8]" ..
        "label[0,0;" .. S("Threshing Machine") .. "]" ..
        "button_exit[0,0.7;1.5,0.5;public;" .. S("Public?") .. "]" ..
        "image[0,2;1,1;unilib_crop_wheat_harvest.png]" ..
        "label[1,1.5;" .. S("Harvested wheat:") .. "]" ..
        "list[current_name;harvest;1,2;2,1;]" ..
        "image[0,3;1,1;unilib_item_stick_ordinary.png]" ..
        "label[1,3.2;" .. S("Punch machine with a stick") .. "]" ..
        "label[5,0.0;" .. S("Straw:") .. "]" ..
        "list[current_name;straw;6,0;2,2;]" ..
        "label[5,2.0;" .. S("Seeds:") .. "]" ..
        "list[current_name;seeds;6,2;2,2;]" ..
        "list[current_player;main;0,4;8,4;]"

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_threshing.init()

    return {
        description = "Threshing machine",
        notes = "Right-click to add wheat, then hit the machine with a stick to thresh the" ..
                " wheat into straw mats and wheat seeds",
        depends = {
            "bed_mat_straw",
            "container_chest_ordinary",
            "crop_wheat",
            "shared_cottages",
            "stone_ordinary",
            "tree_jungle",
        },
    }

end

function unilib.pkg.machine_threshing.exec()

    unilib.register_node("unilib:machine_threshing", "cottages:threshing_floor", mode, {
        -- From cottages:threshing_floor
        description = S("Threshing Machine"),
        tiles = {
            "unilib_misc_wood_rustic_dark.png^unilib_crop_wheat_harvest.png",
            "unilib_misc_wood_rustic_dark.png",
            "unilib_misc_wood_rustic_dark.png^unilib_item_stick_ordinary.png",
        },
        groups = {choppy = 2, cracky = 2},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.wood,

        drawtype = "nodebox",
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.50, -0.5, -0.50, 0.50, -0.40, 0.50},
                {-0.50, -0.4, -0.50, -0.45, -0.20, 0.50},
                { 0.45, -0.4, -0.50, 0.50, -0.20, 0.50},
                {-0.45, -0.4, -0.50, 0.45, -0.20, -0.45},
                {-0.45, -0.4, 0.45, 0.45, -0.20, 0.50},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.50, -0.5,-0.50, 0.50, -0.20, 0.50},
            }
        },

        after_place_node = function(pos, placer)

            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name() or "")
            meta:set_string(
                "infotext",
                S("Private Threshing Machine (owned by %s)"):format(meta:get_string("owner") or "")
            )
            meta:set_string(
                "formspec",
                thresh_formspec .. "label[1.5,0.65;" ..
                S("Owner: %s"):format(meta:get_string("owner") or "") .. "]"
            )
            meta:set_string("public", "private")

        end,

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            local meta = minetest.get_meta(pos)
            if not(unilib.pkg.shared_cottages.player_can_use(meta, player)) then
                return 0
            else
                return count
            end

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            if listname == "straw" or
                    listname == "seeds" or
                    (
                        listname == "harvest" and
                        stack and
                        stack:get_name() ~= "unilib:crop_wheat_harvest"
                    ) then
                return 0
            end

            if not(unilib.pkg.shared_cottages.player_can_use(meta, player)) then
                return 0
            else
                return stack:get_count()
            end

        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            if not(unilib.pkg.shared_cottages.player_can_use(meta, player)) then
                return 0
            else
                return stack:get_count()
            end

        end,

        can_dig = function(pos, player)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local owner = meta:get_string("owner")

            if not(inv:is_empty("harvest")) or
                    not(inv:is_empty("straw")) or
                    not(inv:is_empty("seeds")) or
                    not(player) or
                    (owner and owner ~= "" and player:get_player_name() ~= owner) then
               return false
            else
               return true
            end

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", S("Public Threshing Machine"))
            local inv = meta:get_inventory()
            inv:set_size("harvest", 2)
            inv:set_size("straw", 4)
            inv:set_size("seeds", 4)
            meta:set_string("formspec", thresh_formspec)
            meta:set_string("public", "public")

        end,

        on_punch = function(pos, node, puncher)

            if not(pos) or not(node) or not(puncher) then
                return
            end

            -- Only punching with a stick is supposed to work
            local wielded = puncher:get_wielded_item()
            if not(wielded) or
                    not(wielded:get_name()) or
                    not(minetest.registered_items[wielded:get_name()]) or
                    not(minetest.registered_items[wielded:get_name()].groups) or
                    not(minetest.registered_items[wielded:get_name()].groups.stick) then
                return
            end

            local name = puncher:get_player_name()
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()

            local input = inv:get_list("harvest")
            -- (We have two input slots)
            local stack1 = inv:get_stack("harvest", 1)
            local stack2 = inv:get_stack("harvest", 2)

            if (stack1:is_empty() and stack2:is_empty()) or
                    (not(stack1:is_empty()) and stack1:get_name() ~= "unilib:crop_wheat_harvest") or
                    (not(stack2:is_empty()) and stack2:get_name() ~= "unilib:crop_wheat_harvest")
                    then

                meta:set_string(
                    "formspec",
                    thresh_formspec .. "label[1.5,0.65;" ..
                    S("Owner: %s"):format(meta:get_string("owner") or "") .. "]"
                )

                return

            end

            -- Process 10-40 wheat for each punch (average 25)
            local anz_wheat = 10 + math.random(0, 30)
            -- We already made sure there is only wheat inside
            local found_wheat = stack1:get_count() + stack2:get_count()

            -- do not process more wheat than is present in the input slots
            if found_wheat < anz_wheat then
                anz_wheat = found_wheat
            end

            local overlay1 = "^unilib_crop_wheat_harvest.png"
            local overlay2 = "^unilib_misc_straw_ordinary.png"
            local overlay3 = "^unilib_crop_wheat_seed.png"

            -- This can be enlarged by a multiplicator if desired
            local anz_straw = anz_wheat
            local anz_seeds = anz_wheat

            if inv:room_for_item("straw", "unilib:bed_mat_straw " .. tostring(anz_straw)) and
                    inv:room_for_item("seeds", "unilib:crop_wheat_seed " .. tostring(anz_seeds))
                    then

                -- The player gets two kinds of output
                inv:add_item("straw", "unilib:bed_mat_straw " .. tostring(anz_straw))
                inv:add_item("seeds", "unilib:crop_wheat_seed " .. tostring(anz_seeds))
                -- Consume the wheat
                inv:remove_item("harvest", "unilib:crop_wheat_harvest " .. tostring(anz_wheat))

                local anz_left = found_wheat - anz_wheat
                if anz_left == 0 then
                    overlay1 = ""
                end

            end

            local hud0 = puncher:hud_add({
                name = "threshing_0",
                hud_elem_type = "image",

                alignment = {x = 0, y = 0},
                position = {x = 0.5, y = 0.5},
                scale = {x = 38, y = 38},
                text = "unilib_misc_wood_rustic_dark.png^[colorize:#888888:128",
            })

            local hud1 = puncher:hud_add({
                name = "threshing_1",
                hud_elem_type = "image",

                alignment = {x = 0, y = 0},
                position = {x = 0.4, y = 0.5},
                scale = {x = 15, y = 15},
                text = "unilib_misc_wood_rustic_dark.png" .. overlay1,
            })

            local hud2 = puncher:hud_add({
                name = "threshing_2",
                hud_elem_type = "image",

                alignment = {x = 0, y = 0},
                position = {x = 0.6, y = 0.35},
                scale = {x = 15, y = 15},
                text = "unilib_misc_wood_rustic_dark.png" .. overlay2,
            })

            local hud3 = puncher:hud_add({
                name = "threshing_3",
                hud_elem_type = "image",

                alignment = {x = 0, y = 0},
                position = {x = 0.6, y = 0.65},
                scale = {x = 15, y = 15},
                text = "unilib_misc_wood_rustic_dark.png" .. overlay3,
            })

            local hud4 = puncher:hud_add({
                name = "threshing_4",
                hud_elem_type = "text",

                alignment = {x = 0, y = 0},
                number = 0x00CC00,
                position = {x = 0.4, y = 0.5},
                -- Bounding rectangle of the text
                scale = {x = 100, y = 100},
                text = tostring(found_wheat - anz_wheat),
            })

            if not(anz_straw) then
                anz_straw = "0"
            end

            if not(anz_seed) then
                anz_seed = "0"
            end

            local hud5 = puncher:hud_add({
                name = "threshing_5",
                hud_elem_type = "text",

                alignment = {x = 0, y = 0},
                number = 0x00CC00,
                position = {x = 0.6, y = 0.35},
                -- Bounding rectangle of the text
                scale = {x = 100, y = 100},
                text = "+ " .. tostring(anz_straw) .. " straw",
            })

            local hud6 = puncher:hud_add({
                name = "threshing_6",
                hud_elem_type = "text",

                alignment = {x = 0, y = 0},
                number = 0x00CC00,
                position = {x = 0.6, y = 0.65},
                -- Bounding rectangle of the text
                scale = {x = 100, y = 100},
                text = "+ " .. tostring(anz_seed) .. " seeds",
            })

            minetest.after(2, function()

                if( puncher ) then

                    if(hud1) then puncher:hud_remove(hud1) end
                    if(hud2) then puncher:hud_remove(hud2) end
                    if(hud3) then puncher:hud_remove(hud3) end
                    if(hud4) then puncher:hud_remove(hud4) end
                    if(hud5) then puncher:hud_remove(hud5) end
                    if(hud6) then puncher:hud_remove(hud6) end
                    if(hud0) then puncher:hud_remove(hud0) end

                end

            end)

        end,

        on_receive_fields = function(pos, formname, fields, sender)

            unilib.pkg.shared_cottages.switch_public(
                pos, formname, fields, sender, S("Threshing Machine")
            )

        end,
    })
    unilib.register_craft({
        -- From cottages:threshing_floor
        output = "unilib:machine_threshing",
        recipe = {
            {
                "unilib:tree_jungle_wood",
                "unilib:container_chest_ordinary_locked",
                "unilib:tree_jungle_wood",
            },
            {
                "unilib:tree_jungle_wood",
                "unilib:stone_ordinary",
                "unilib:tree_jungle_wood",
            },
        },
    })

end
