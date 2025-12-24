---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_wheel_spinning = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

local cbox = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.25, 0.5, 0.3125, 0.1875},
}

-- Ammount of silk to craft a bobbin in a spinning wheel
-- N.B. This local variable replaces petz.settings.silk_to_bobbin
local silk_per_bobbin = 3

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_wheel_spinning.init()

    return {
        description = "Spinning wheel",
        notes = "Produces silk bobbins more quickly than can be crafted by hand. Bobbins are" ..
                " produced when silkworm cocoons are put in the wheel",
        depends = {"component_bobbin_silk", "misc_cocoon_silkworm"},
    }

end

function unilib.pkg.machine_wheel_spinning.exec()

    unilib.register_node("unilib:machine_wheel_spinning", "petz:spinning_wheel", mode, {
        -- From petz:spinning_wheel
        description = S("Spinning Wheel"),
        tiles = {"unilib_machine_wheel_spinning_loaded.png"},
        groups = {bendy = 2, cracky = 1, snappy = 1},
        sounds = unilib.global.sound_table.wood,

        collision_box = cbox,
        drawtype = "mesh",
        mesh = "unilib_machine_wheel_spinning.b3d",
        paramtype = "light",
        selection_box = cbox,

        after_place_node = function(pos, placer, itemstack, pointed_thing)

            local meta_itemstack = itemstack:get_meta()
            local silk_count
            if meta_itemstack:contains("silk_count") then
                silk_count = meta_itemstack:get_int("silk_count")
            else
                silk_count = 1
            end

            local meta = core.get_meta(pos)
            meta:set_int("silk_count", silk_count)
            meta:set_string("infotext", S("Silk Count") .. " = " .. silk_count)

        end,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            local pname = player:get_player_name()
            local meta = core.get_meta(pos)
            local silk_count = meta:get_int("silk_count")

            if itemstack:get_name() == "unilib:misc_cocoon_silkworm" then

                if silk_count == silk_per_bobbin then

                    core.chat_send_player(
                        pname, S("First, remove the silk bobbin from the spinning wheel")
                    )

                elseif silk_count == (silk_per_bobbin - 1) then

                    silk_count = silk_count + 1
                    meta:set_int("silk_count", silk_count)
                    meta:set_string("infotext", S("Silk Count") .. " = " .. tostring(silk_count))
                    itemstack:take_item()
                    core.chat_send_player(pname, S("A silk bobbin has been created!"))
                    return itemstack

                else

                    silk_count = silk_count + 1
                    meta:set_int("silk_count", silk_count)
                    meta:set_string("infotext", S("Silk Count") .. " = "..tostring(silk_count))
                    itemstack:take_item()

                    local need_count = silk_per_bobbin - silk_count
                    if need_count == 1 then

                        core.chat_send_player(
                            pname,
                            S(
                                "In order to create the bobbin, you must add one more silkworm" ..
                                        " cocoon"
                            )
                        )

                    else

                        core.chat_send_player(
                            pname,
                            S(
                                "In order to create the bobbin, you must add @1 more silkworm" ..
                                        " cocoons",
                                tostring(need_count)
                            )
                        )

                    end

                    return itemstack

                end

            elseif silk_count == silk_per_bobbin then

                -- Get the bobbin...
                local inv = player:get_inventory()

                -- ...firstly checking for room in the inventory
                if inv:room_for_item("main", "unilib:component_bobbin_silk") then

                    local itemstack_name = itemstack:get_name()
                    local stack = ItemStack("unilib:component_bobbin_silk 1")
                    if (
                        itemstack_name == "unilib:component_bobbin_silk" or itemstack_name == ""
                    ) and itemstack:get_count() < itemstack:get_stack_max() then
                        itemstack:add_item(stack)
                    else
                        inv:add_item("main", stack)
                    end

                    -- Reset the silk count
                    meta:set_int("silk_count", 0)
                    meta:set_string("infotext", S("Silk Count") .. " = 0")
                    core.chat_send_player(pname, S("You have crafted a silk bobbin!"))
                    return itemstack

                else

                    core.chat_send_player(
                        pname, S("There isn't enough room in your inventory for the silk bobbin")
                    )

                end

            end

        end,

        preserve_metadata = function(pos, oldnode, oldmeta, drop_list)
            drop_list[1]:get_meta():set_int("silk_count", core.get_meta(pos):get_int("silk_count"))
        end,
    })
    unilib.register_craft({
        -- From petz:spinning_wheel
        type = "shaped",
        output = "unilib:machine_wheel_spinning",
        recipe = {
            {"", "group:wood", ""},
            {"group:wood", "unilib:component_bobbin_silk", "group:wood"},
            {"", "group:wood", ""},
        },
    })

end
