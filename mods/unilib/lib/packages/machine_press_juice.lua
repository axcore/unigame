---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    drinks
-- Code:    MIT
-- Media:   CC by SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_press_juice = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.drinks.add_mode

local barrel_full_msg = S("The barrel is full of juice")
local collect_msg = S("Collect your juice")
local juicing_msg = S("Juicing...")
local more_fruit_msg = S("You need more fruit!")
local no_mix_msg = S("You can't mix juices!")
local ready_msg = S("Ready for juicing")
local silo_full_msg = S("The silo is full of juice")

-- Formspecs
local put_fruit_msg = S("Put fruit here")
local put_container_msg = S("Put container here")
local ratio1_msg = S("4 fruits to a glass")
local ratio2_msg = S("8 fruits to a bottle")
local ratio3_msg = S("16 fruits to a bucket")
local button_msg = S("Squeeze Juice")

local base_formspec =
    "label[1,1;" .. F(put_fruit_msg) .. "]" ..
    "label[1,2;" .. F(put_container_msg) .. "]" ..
    "label[5,0;" .. F(ratio1_msg) .. "]" ..
    "label[5,0.5;" .. F(ratio2_msg) .. "]" ..
    "label[5,1.0;" .. F(ratio3_msg) .. "]" ..
    "button[5,1.9;3,1;press;" .. F(button_msg) .. "]" ..
    "list[current_name;src;0,0.8;1,1;]" ..
    "list[current_name;dst;0,1.8;1,1;]" ..
    "list[current_player;main;0,3;8,4;]"

local press_idle_formspec =
    "size[8,7]" ..
    "label[0,0;" .. FS("Fresh juice is just a squish away!") .. "]" ..
    base_formspec

local press_running_formspec =
    "size[8,7]" ..
    "label[0,0;" .. FS("Fresh juice coming right up...") .. "]" ..
    base_formspec

local press_error_formspec =
    "size[8,7]" ..
    "label[0,0;" .. FS("You need to add more fruit!") .. "]" ..
    base_formspec

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_press_juice.init()

    return {
        description = "Juice press",
        notes = "A machine for creating drinks out of various fruits and vegetables. Right-click" ..
                " the press to begin juicing. If the press is placed above a barrel or silo, and" ..
                " ordinary papyrus is used as the \"container\", then the juice is transferred" ..
                " to the barrel or silo",
        depends = {
            "bucket_steel",
            "item_stick_ordinary",
            "metal_steel",
            "shared_drinks",
            "vessel_glass_empty",
        },
        optional = {
            "container_barrel_juice",
            "container_silo_juice",
            "plant_papyrus_ordinary",
            "vessel_bottle_glass_empty",
            "vessel_bottle_steel_empty",
        },
    }

end

function unilib.pkg.machine_press_juice.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:machine_press_juice", "drinks:juice_press", mode, {
        -- From drinks:juice_press
        description = S("Juice Press"),
        tiles = {name = "unilib_machine_press_juice.png"},
        groups = {choppy = 2, dig_immediate = 2},
        -- (no sounds)

        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        },
        drawtype = "mesh",
        -- N.B. is_ground_content = false not in original code
        is_ground_content = false,
        mesh = "unilib_machine_press_juice.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        },
        use_texture_alpha = "clip",

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            if listname == "dst" then

                if unilib.global.empty_bucket_table[stack:get_name()] ~= nil or
                        stack:get_name() == "unilib:vessel_glass_empty" or
                        stack:get_name() == "unilib:vessel_bottle_glass_empty" or
                        stack:get_name() == "unilib:vessel_bottle_steel_empty" or
                        stack:get_name() == "unilib:plant_papyrus_ordinary" then
                    return 1
                else
                    return 0
                end

            else

                return 99

            end

        end,

        can_dig = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            if inv:is_empty("src") and inv:is_empty("dst") then
                return true
            else
                return false
            end

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("main", 8 * 4)
            inv:set_size("src", 1)
            inv:set_size("dst", 1)
            meta:set_string("infotext", S("Empty Juice Press"))
            meta:set_string("formspec", press_idle_formspec)

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            meta:set_string("infotext", ready_msg)

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            local timer = core.get_node_timer(pos)
            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            timer:stop()
            meta:set_string("infotext", ready_msg)
            meta:set_string("formspec", press_idle_formspec)

        end,

        on_receive_fields = function(pos, formname, fields, sender)

            if fields["press"] then

                local meta = core.get_meta(pos)
                local inv = meta:get_inventory()
                local timer = core.get_node_timer(pos)
                local instack = inv:get_stack("src", 1)

                local fruitstack = instack:get_name()
                local item_name = unilib.utils.get_item_name(fruitstack)
                local fruit = unilib.pkg.shared_drinks.ingredient_convert_table[item_name]

                if unilib.pkg.shared_drinks.juiceable_table[fruit] then

                    meta:set_string("fruit", fruit)

                    local outstack = inv:get_stack("dst", 1)
                    local vessel = outstack:get_name()
                    if vessel == "unilib:vessel_glass_empty" then

                        if instack:get_count() >= 4 then

                            meta:set_string("container", "vessel_glass")
                            meta:set_string("fruitnumber", 4)
                            meta:set_string("infotext", juicing_msg)
                            meta:set_string("formspec", press_running_formspec)
                            timer:start(4)

                        else

                            meta:set_string("infotext", more_fruit_msg)
                            meta:set_string("formspec", press_error_formspec)

                        end

                    elseif vessel == "unilib:vessel_bottle_glass_empty" then

                        if instack:get_count() >= 8 then
                            meta:set_string("container", "vessel_bottle_glass")
                            meta:set_string("fruitnumber", 8)
                            meta:set_string("infotext", juicing_msg)
                            meta:set_string("formspec", press_running_formspec)
                            timer:start(8)

                        else

                            meta:set_string("infotext", more_fruit_msg)
                            meta:set_string("formspec", press_error_formspec)

                        end

                    elseif vessel == "unilib:vessel_bottle_steel_empty" then

                        if instack:get_count() >= 8 then

                            meta:set_string("container", "vessel_bottle_steel")
                            meta:set_string("fruitnumber", 8)
                            meta:set_string("infotext", juicing_msg)
                            meta:set_string("formspec", press_running_formspec)
                            timer:start(8)

                        else

                            meta:set_string("infotext", more_fruit_msg)
                            meta:set_string("formspec", press_error_formspec)

                        end

                    elseif unilib.global.empty_bucket_table[vessel] ~= nil then

                        if instack:get_count() >= 16 then

                            -- e.g. unilib:bucket_steel_with_juice_apple
                            meta:set_string("container", unilib.global.empty_bucket_table[vessel])
                            meta:set_string("fruitnumber", 16)
                            meta:set_string("infotext", juicing_msg)
                            meta:set_string("formspec", press_running_formspec)
                            timer:start(16)

                        else

                            meta:set_string("infotext", more_fruit_msg)
                            meta:set_string("formspec", press_error_formspec)

                        end

                    elseif vessel == "unilib:plant_papyrus_ordinary" then

                        if instack:get_count() >= 2 then

                            local under_node = {x = pos.x, y = pos.y - 1, z = pos.z}
                            local under_node_name = core.get_node_or_nil(under_node)
                            local under_node_2 = {x = pos.x, y = pos.y - 2, z = pos.z}
                            local under_node_name_2 = core.get_node_or_nil(under_node_2)

                            if under_node_name.name == "unilib:container_barrel_juice" then

                                local meta_u = core.get_meta(under_node)
                                local stored_fruit = meta_u:get_string("fruit")
                                if fruit == stored_fruit or stored_fruit == "empty" then

                                    meta:set_string("container", "tube")
                                    meta:set_string("fruitnumber", 2)
                                    meta:set_string("infotext", juicing_msg)
                                    -- N.B. This line is not in the original code
                                    meta:set_string("formspec", press_running_formspec)
                                    meta_u:set_string("fruit", fruit)
                                    timer:start(4)

                                else

                                    meta:set_string("infotext", no_mix_msg)

                                end

                            elseif under_node_name_2.name == "unilib:container_silo_juice" then

                                local meta_u = core.get_meta(under_node_2)
                                local stored_fruit = meta_u:get_string("fruit")
                                if fruit == stored_fruit or stored_fruit == "empty" then

                                    meta:set_string("container", "tube")
                                    meta:set_string("fruitnumber", 2)
                                    meta:set_string("infotext", juicing_msg)
                                    -- N.B. This line is not in the original code
                                    meta:set_string("formspec", press_running_formspec)
                                    meta_u:set_string("fruit", fruit)
                                    timer:start(4)

                                else

                                    meta:set_string("infotext", no_mix_msg)

                                end

                            else

                                meta:set_string("infotext", more_fruit_msg)
                                meta:set_string("formspec", press_error_formspec)

                            end

                        end

                    end

                end

            end

        end,

        on_timer = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local container = meta:get_string("container")
            local instack = inv:get_stack("src", 1)
            local outstack = inv:get_stack("dst", 1)
            local fruit = meta:get_string("fruit")
            local fruitnumber = tonumber(meta:get_string("fruitnumber"))

            if container == "tube" then

                local timer = core.get_node_timer(pos)
                local under_node = {x = pos.x, y = pos.y - 1, z = pos.z}
                local under_node_name = core.get_node_or_nil(under_node)
                local under_node_2 = {x = pos.x, y = pos.y - 2, z = pos.z}
                local under_node_name_2 = core.get_node_or_nil(under_node_2)

                if under_node_name.name == "unilib:container_barrel_juice" then

                    local meta_u = core.get_meta(under_node)
                    local fullness = tonumber(meta_u:get_string("fullness"))
                    instack:take_item(tonumber(fruitnumber))
                    inv:set_stack("src", 1, instack)

                    if fullness + 2 > 128 then

                        timer:stop()
                        meta:set_string("infotext", barrel_full_msg)
                        return

                    else

                        local fullness = fullness + 2
                        meta_u:set_string("fullness", fullness)
                        meta_u:set_string(
                            "infotext",
                            S("@1 % full of @2 juice.", (math.floor((fullness / 128) * 100)), fruit)
                        )
                        meta_u:set_string(
                            "formspec",
                            unilib.pkg.shared_drinks.juice_storage_formspec(fruit, fullness, 128)
                        )

                        if instack:get_count() >= 2 then
                            timer:start(4)
                        else
                            meta:set_string("infotext", more_fruit_msg)
                        end

                    end

                elseif under_node_name_2.name == "unilib:container_silo_juice" then

                    local meta_u = core.get_meta(under_node_2)
                    local fullness = tonumber(meta_u:get_string("fullness"))
                    instack:take_item(tonumber(fruitnumber))
                    inv:set_stack("src", 1, instack)

                    if fullness + 2 > 256 then

                        timer:stop()
                        meta:set_string("infotext", silo_full_msg)
                        return

                    else

                        local fullness = fullness + 2
                        meta_u:set_string("fullness", fullness)
                        meta_u:set_string(
                            "infotext",
                            S("@1 % full of @2 juice.", (math.floor((fullness / 256) * 100)), fruit)
                        )
                        meta_u:set_string(
                            "formspec",
                            unilib.pkg.shared_drinks.juice_storage_formspec(fruit, fullness, 256)
                        )

                        if instack:get_count() >= 2 then
                            timer:start(4)
                        else
                            meta:set_string("infotext", more_fruit_msg)
                        end

                    end

                end

            else

                meta:set_string("infotext", collect_msg)
                meta:set_string("formspec", press_idle_formspec)
                instack:take_item(tonumber(fruitnumber))
                inv:set_stack("src", 1, instack)
                -- e.g. unilib:vessel_glass_with_juice_apple
                -- e.g. unilib:bucket_steel_with_juice_apple
                inv:set_stack("dst", 1 , "unilib:" .. container .. "_with_juice_" .. fruit)

            end

        end,
    })
    -- N.B. This craft recipe requires one particular type of empty bucket
    unilib.register_craft({
        -- From drinks:juice_press
        output = "unilib:machine_press_juice",
        -- N.B. As with other code imported from the "drinks" mod, removed slab as an ingredient
        recipe = {
            {c_stick, "unilib:metal_steel_ingot", c_stick},
            {c_stick, "unilib:bucket_steel_empty", c_stick},
            -- N.B. Original code used stairs:slab_wood
            {"group:wood_stair_slab", "group:wood_stair_slab", "unilib:vessel_glass_empty"},
        },
    })

end
