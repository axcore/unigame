---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_mill_hand = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cottages.add_mode

-- N.B. The formspec provided by the cottages mod is untidy, so I have rearranged it
--[[
local mill_formspec = "size[8,8]" ..
        "image[0,1;1,1;unilib_crop_wheat_seed.png]" ..
        "button_exit[6.0,0.0;1.5,0.5;public;" .. S("Public?") .. "]" ..
        "list[current_name;seeds;1,1;1,1;]" ..
        "list[current_name;flour;5,1;2,2;]" ..
        "label[0,0.5;" .. S("Wheat seeds:") .. "]" ..
        "label[4,0.5;" .. S("Flour:") .. "]" ..
        "label[0,-0.3;" .. S("Mill") .. "]" ..
        "label[0,2.5;" .. S("Punch this hand-driven mill") .. "]" ..
        "label[0,3.0;" .. S("to convert wheat seeds into flour") .. "]" ..
        "list[current_player;main;0,4;8,4;]"
]]--
local mill_formspec = "size[8,8]" ..
        "label[0,0;" .. S("Hand Mill") .. "]" ..
        "button_exit[0,0.7;1.5,0.5;public;" .. S("Public?") .. "]" ..
        "label[0,1.5;" .. S("Wheat seeds:") .. "]" ..
        "image[0,2;1,1;unilib_crop_wheat_seed.png]" ..
        "list[current_name;seeds;1,2;1,1;]" ..
        "label[6,1.5;" .. S("Flour:") .. "]" ..
        "list[current_name;flour;6,2;2,2;]" ..

        "image[0,3;1,1;unilib_ingredient_flour_ordinary.png]" ..
        "label[1,3.2;" .. S("Punch mill to grind seeds") .. "]" ..
        "list[current_player;main;0,4;8,4;]"

-- In original code, all but the first ingredients were commented out
-- (If new ingredients are added, the formspect must be updated, but the code below should still be
--      OK)
local product_table = {}
product_table["unilib:crop_wheat_seed"] = "unilib:ingredient_flour_ordinary"
--[[
product_table["unilib:stone_ordinary_cobble"] = "unilib:gravel_ordinary"
product_table["unilib:gravel_ordinary"] = "unilib:sand_ordinary"
product_table["unilib:sand_ordinary"] = "unilib:dirt_ordinary 2"
product_table["unilib:flower_rose_red"] = "unilib:dye_red 6"
product_table["unilib:plant_cactus_ordinary"] = "unilib:dye_green 6"
product_table["unilib:mineral_coal_lump"] = "unilib:dye_black 6"
]]--

-- How many inputs per turn
local max_per_turn = 20
local min_per_turn = 0

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_mill_hand.init()

    return {
        description = "Hand mill",
        notes = "Similar to the threshing machine, but only has one input/output slot and does" ..
                " not require a stick. Grinds wheat seeds into flour",
        depends = {
            "crop_wheat",
            "ingredient_flour_ordinary",
            "metal_steel",
            "shared_cottages",
            "stone_ordinary",
        },
    }

end

function unilib.pkg.machine_mill_hand.exec()

    unilib.register_node("unilib:machine_mill_hand", "cottages:handmill", mode, {
        -- From cottages:handmill
        description = S("Hand Mill"),
        tiles = {"unilib_stone_ordinary.png"},
        groups = {cracky = 2},
        -- N.B. no sounds in original code
        sounds = unilib.sound_table.stone,

        collision_box = {
            type = "fixed",
            fixed = {
                {-0.50, -0.5, -0.50, 0.50, 0.25, 0.50},
            }
        },
        drawtype = "mesh",
        is_ground_content = false,
        mesh = "unilib_machine_mill_hand.obj",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.50, -0.5, -0.50, 0.50, 0.25, 0.50},
            }
        },
        paramtype = "light",
        paramtype2 = "facedir",

        after_place_node = function(pos, placer)

            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name() or "")
            meta:set_string(
                "infotext",
                S("Private Hand Mill (owned by %s)"):format(meta:get_string("owner") or "")
            )
            meta:set_string(
                "formspec",
                mill_formspec .. "label[1.5,0.65;" ..
                S("Owner: %s"):format(meta:get_string("owner") or "") .. "]"
            )
            meta:set_string("public", "private")

        end,

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            local meta = minetest.get_meta(pos)
            if not(cottages.player_can_use(meta, player)) then
                return 0
            else
                return count
            end

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            if listname == "flour" or
                    (
                        listname == "seeds" and
                        stack and
                        not(product_table[stack:get_name()])
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

        can_dig = function(pos,player)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local owner = meta:get_string("owner")

            if not(inv:is_empty("flour")) or
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
            meta:set_string("infotext", S("Hand Mill"))
            local inv = meta:get_inventory()
            inv:set_size("seeds", 1)
            inv:set_size("flour", 4)
            meta:set_string("formspec", mill_formspec)
            meta:set_string("public", "public")

        end,

        on_punch = function(pos, node, puncher)

            if not(pos) or not(node) or not(puncher) then
                return
            end

            local name = puncher:get_player_name()
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local input = inv:get_list("seeds")
            local stack1 = inv:get_stack("seeds", 1)

            if stack1:is_empty() or
                    (
                        not(stack1:is_empty()) and
                        not(product_table[stack1:get_name()])
                    ) then

                if not(stack1:is_empty()) then
                    minetest.chat_send_player(name, S("Nothing happens..."))
                end

                -- Update the formspec
                meta:set_string(
                    "formspec",
                    mill_formspec .. "label[1.5,0.65;" ..
                    S("Owner: %s"):format(meta:get_string("owner") or "") .. "]"
                )

                return

            end

            -- Turning the mill is a slow process; 1-21 flour is generated per turn
            local anz = 1 + math.random(min_per_turn, max_per_turn)
            -- We already made sure there is only wheat seeds inside
            local found = stack1:get_count()

            -- Do not process more wheat than is present in the input slots
            if found < anz then
                anz = found
            end

            local product_stack = ItemStack(product_table[stack1:get_name()])
            local anz_result = anz

            -- Items that produce more
            if product_stack:get_count() > 1 then
                anz_result = anz * product_stack:get_count()
            end

            if inv:room_for_item(
                "flour",
                product_stack:get_name() .. " " .. tostring(anz_result)
            ) then

                inv:add_item("flour", product_stack:get_name() .. " " .. tostring(anz_result))
                inv:remove_item("seeds", stack1:get_name() .. " " .. tostring(anz))

                local anz_left = found - anz
                if anz_left > 0 then

                    minetest.chat_send_player(
                        name,
                        S("Grinding") .. ": " .. unilib.brackets(
                            stack1:get_definition().description,
                            S("%s are left"):format(anz_left)
                        )
                    )

                else

                    minetest.chat_send_player(
                        name,
                        S("Grinding") .. ": " .. unilib.brackets(
                            stack1:get_definition().description,
                            S("none left"):format(anz_left)
                        )
                    )

                end

                -- After each punch, rotate the mill a little
                node.param2 = node.param2 + 1
                if node.param2 > 3 then
                    node.param2 = 0
                end

                minetest.swap_node(pos, node)

            end

        end,

        on_receive_fields = function(pos, formname, fields, sender)

            unilib.pkg.shared_cottages.switch_public(
                pos, formname, fields, sender, S("Hand Mill")
            )

        end,
    })
    unilib.register_craft({
        -- From cottages:handmill
        output = "unilib:machine_mill_hand",
        recipe = {
            {"group:stick", "unilib:stone_ordinary", "group:stick"},
            {"", "unilib:metal_steel_ingot", ""},
            {"", "unilib:stone_ordinary", ""},
        },
    })

end
