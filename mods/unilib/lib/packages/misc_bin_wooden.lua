---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    trash_can
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_bin_wooden = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.trash_can.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_bin_wooden.init()

    return {
        description = "Wooden rubbish bin",
        notes = "If the Minetest setting is enabled, items can be thrown into the bin",
    }

end

function unilib.pkg.misc_bin_wooden.exec()

    local def_table = {
        description = S("Wooden Rubbish Bin"),
        tiles = {
            "unilib_misc_bin_wooden_top.png",
            "unilib_misc_bin_wooden_top.png",
            "unilib_misc_bin_wooden.png"
        },
        groups = {choppy = 2, flammable = 3, oddly_breakable_by_hand = 2, snappy = 1},
        -- (no sounds)

        drawtype = "nodebox",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        node_box = {
            type = "fixed",
            fixed = {
                {-0.375, -0.5, 0.3125, 0.375, 0.5, 0.375},
                {0.3125, -0.5, -0.375, 0.375, 0.5, 0.375},
                {-0.375, -0.5, -0.375, 0.375, 0.5, -0.3125},
                {-0.375, -0.5, -0.375, -0.3125, 0.5, 0.375},
                {-0.3125, -0.5, -0.3125, 0.3125, -0.4375, 0.3125},
            },
        },
        paramtype = "light",

        can_dig = function(pos,player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("main")

        end,

        -- N.B. No .on_blast() function, either here or in original code; destroying the bin should
        --      destroy its contents

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec",
                "size[8,9]" ..
                "button[0,0;3,1;empty;" .. FS("Empty rubbish bin") .. "]" ..
                "list[context;trashlist;3,1;2,3;]" ..
                "list[current_player;main;0,5;8,4;]" ..
                "listring[]"
            )
            meta:set_string("infotext", S("Wooden Rubbish Bin"))

            local inv = meta:get_inventory()
            inv:set_size("main", 8 * 4)
            inv:set_size("trashlist", 2 * 3)

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in rubbish bin at " ..
                        core.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to rubbish bin at " ..
                        core.pos_to_string(pos)

            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from rubbish bin at " ..
                        core.pos_to_string(pos)
            )

        end,
        ]]--

        on_receive_fields = function(pos, formname, fields, sender)

            if fields.empty then

                local meta = core.get_meta(pos)
                local inv = meta:get_inventory()
                inv:set_list("trashlist", {})
                core.sound_play(
                    "unilib_misc_bin",
                    {to_player = sender:get_player_name(), gain = 1.0}
                )
                --[[
                unilib.utils.log(
                    "action",
                    sender:get_player_name() .. " empties rubbish bin at " ..
                            core.pos_to_string(pos)
                )
                ]]--
                unilib.utils.log_player_action(sender, "empties rubbish bin at", pos)

            end

        end,
    }

    unilib.utils.set_inventory_action_loggers(def_table, "rubhish bin")
    unilib.register_node(
        -- From trash_can:trash_can_wooden
        "unilib:misc_bin_wooden", "trash_can:trash_can_wooden", mode, def_table
    )

    unilib.register_craft({
        -- From trash_can:trash_can_wooden
        output = "unilib:misc_bin_wooden",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"group:wood", "", "group:wood"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

    -- Remove any items thrown into rubbish bin
    -- N.B. This code has been moved to /lib/effects/builtin/built_item.lua
    --[[
    if unilib.setting.trash_can_throw_flag then

        local old_on_step = core.registered_entities["__builtin:item"].on_step

        core.registered_entities["__builtin:item"].on_step = function(self, dtime, ...)

            local item_pos = self.object:get_pos()
            -- Round the values (not essential, but makes logs look nicer)
            item_pos.y = item_pos.y - 0.325
            item_pos = vector.round(item_pos)

            if core.get_node(item_pos).name == "unilib:misc_bin_wooden" then

                local item_stack = ItemStack(self.itemstring)
                local inv = core.get_inventory({type = "node", pos = item_pos})
                local leftover = inv:add_item("trashlist", item_stack)

                if leftover:get_count() == 0 then

                    self.object:remove()
                    unilib.utils.log(
                        "action",
                        item_stack:to_string() .. " added to rubbish bin at " ..
                                core.pos_to_string(item_pos)
                    )

                elseif item_stack:get_count() - leftover:get_count() ~= 0 then

                    self.set_item(self, leftover:to_string())
                    unilib.utils.log(
                        "action",
                        item_stack:to_string() .. " added to rubbish bin at " ..
                                core.pos_to_string(item_pos) .. " with " ..
                                leftover:to_string() .. " left over"
                    )

                end

                return

            end

            old_on_step(self, dtime, ...)

        end

    end
    ]]--

end
