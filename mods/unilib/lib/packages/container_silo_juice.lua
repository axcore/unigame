---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    drinks
-- Code:    MIT
-- Media:   CC by SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_silo_juice = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.drinks.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function update_silo(pos, inputstack, inputcount)

    -- Adapted from drinks/drink_machines.lua, was drinks.drinks_silo()

    local meta = minetest.get_meta(pos)
    local empty_vessel = unilib.pkg.shared_drinks.empty_convert_table[inputstack]

    unilib.pkg.shared_drinks.add_available(
        unilib.pkg.shared_drinks.empty_size_table[empty_vessel],
        empty_vessel,
        256,
        pos,
        inputstack,
        inputcount
    )

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_silo_juice.init()

    return {
        description = "Juice Silo",
        notes = "Provides a simple way to store juice. Add or retrieve juice from the silo" ..
                " using buckets, bottles or glasses",
        depends = {"container_barrel_juice", "shared_drinks"},
    }

end

function unilib.pkg.container_silo_juice.exec()

    unilib.register_node("unilib:container_silo_juice", "drinks:liquid_silo", mode, {
        -- From drinks:liquid_silo
        description = S("Juice Silo"),
        tiles = {name = "unilib_container_silo_juice.png"},
        groups = {choppy = 2, dig_immediate = 2},
        -- (no sounds)

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
        },
        drawtype = "mesh",
        mesh = "unilib_container_silo_juice.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
        },

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)

            -- Adding juice
            if listname == "src" then

                local inputstack = stack:get_name()
                local inputcount = stack:get_count()

                if unilib.pkg.shared_drinks.vessel_convert_table[inputstack] then
                    return inputcount
                else
                    return 0
                end

            -- Removing juice
            elseif listname == "dst" then

                -- Make sure there is juice to remove
                local juice = meta:get_string("fruit")
                if juice ~= "empty" then

                    local inputstack = stack:get_name()
                    local inputcount = stack:get_count()

                    if unilib.pkg.shared_drinks.empty_size_table[inputstack] then
                        return inputcount
                    else
                        return 0
                    end

                else

                    return 0

                end

            end

        end,

        can_dig = function(pos)

            local meta = minetest.get_meta(pos);
            local inv = meta:get_inventory()
            if inv:is_empty("src") and
                    inv:is_empty("dst") and
                    tonumber(meta:get_string("fullness")) == 0 then
                return true
            else
                return false
            end

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("main", 8*4)
            inv:set_size("src", 1)
            inv:set_size("dst", 1)
            meta:set_string("fullness", 0)
            meta:set_string("fruit", "empty")
            meta:set_string("infotext", "Empty Juice Silo")
            meta:set_string("formspec",
                "size[8,8]" ..
                "label[0,0;" .. S("Fill with the juice of your choice.") .. "]" ..
                "label[0,0.4;" .. S("Only one type of juice can be stored.") .. "]" ..
                "label[1,1.2;" .. S("Add juice here") .. "]" ..
                "label[4,1.2;" .. S("The silo is empty") .. "]" ..
                "label[1,2.2;" .. S("Retrieve juice here") .. "]" ..
                "button[0,3;3,1;purge;" .. S("Discard juice") .. "]" ..
                "label[3,3.2;" .. S("(This button completely empties the silo)") .. "]" ..
                "list[current_name;src;0,1;1,1;]" ..
                "list[current_name;dst;0,2;1,1;]" ..
                "list[current_player;main;0,4;8,5;]"
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local instack = inv:get_stack("src", 1)
            local outstack = inv:get_stack("dst", 1)
            local outputstack = outstack:get_name()
            local inputstack = instack:get_name()
            local outputcount = outstack:get_count()
            local inputcount = instack:get_count()
            local fruit = unilib.pkg.shared_drinks.vessel_convert_table[inputstack]
            local fruit_in = meta:get_string("fruit")

            if fruit_in == "empty" then

                meta:set_string("fruit", fruit)
                local fruit_name = minetest.registered_nodes[instack:get_name()]
                if fruit_name == nil then
                    fruit_name = minetest.registered_craftitems[instack:get_name()]
                end

                meta:set_string("fruit_name", string.lower(fruit_name.juice_description))
                local vessel = unilib.pkg.shared_drinks.empty_convert_table[inputstack]
                update_silo(pos, inputstack, inputcount)

            end

            if fruit == fruit_in then

                local vessel = unilib.pkg.shared_drinks.empty_convert_table[inputstack]
                update_silo(pos, inputstack, inputcount)

            end

            if unilib.pkg.shared_drinks.empty_size_table[outputstack] then

                unilib.pkg.shared_drinks.retrieve_available(
                    unilib.pkg.shared_drinks.empty_size_table[outputstack],
                    256,
                    outputstack,
                    pos,
                    outputcount
                )

            end

        end,

        on_receive_fields = function(pos, formname, fields, sender)

            if fields["purge"] then

                local meta = minetest.get_meta(pos)
                local fullness = 0
                local fruit_name = "no"
                meta:set_string("fullness", 0)
                meta:set_string("fruit", "empty")
                meta:set_string("infotext", S("Empty Juice Silo"))
                meta:set_string(
                    "formspec",
                    unilib.pkg.shared_drinks.juice_storage_formspec(fruit_name, fullness, 256)
                )

            end

       end,
    })
    unilib.register_craft({
        -- From drinks:liquid_silo
        output = "unilib:container_silo_juice",
        recipe = {
            {"unilib:container_barrel_juice"},
            {"unilib:container_barrel_juice"},
            {"unilib:container_barrel_juice"},
        },
    })

end
