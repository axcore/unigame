---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    airtanks
-- Code:    MIT
-- Media:   MIT/CC0/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.device_compressor_air = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.airtanks.add_mode

local bg_colour = "#808080"
local tank_inv_size = 4 * 4
-- (Matches the value used in the "device_airtank_bronze" package)
local max_uses = 30
if unilib.setting.airtanks_capacity_max == 2 then
    max_uses = max_uses * 2
elseif unilib.setting.airtanks_capacity_max == 3 then
    max_uses = max_uses * 3
end

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function can_put(pos, listname, index, itemstack)

    -- Was test_can_put()
    -- Ensures only valid items can be placed into compressor inventories

    if listname == "tanks" then

        if core.get_item_group(itemstack:get_name(), "airtank") > 0 then

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            if inv:get_stack(listname, index):get_count() == 0 then
                return 1
            end

        end

        return 0

    elseif listname == "fuel" then

        local output_table, _ = core.get_craft_result({
            items = {itemstack:get_name()},
            method = "fuel",
            width = 1,
        })

        if output_table.time ~= 0 then
            return itemstack:get_count()
        end

        return 0

    else

        return itemstack:get_count()

    end

end

local function find_tank(inv)

    -- Was find_most_fillable()

    local most_fillable_index = 0
    local most_fillable_capacity = 0
    local most_fillable_needs = max_uses + 1
    local most_fillable_stack
    local most_fillable_def_table

    for i = 1, tank_inv_size do

        local tank_stack = inv:get_stack("tanks", i)

        local count = tank_stack:get_count()
        if count > 1 then

            unilib.utils.show_error(
                "device_compressor_air package: invalid tank stack in compressor at " ..
                    core.pos_to_string(pos)
            )
            return false

        elseif count == 1 then

            local tank_def_table = tank_stack:get_definition()
            local tank_capacity = tank_def_table.use_count
            local tank_needs

            if tank_def_table.filled_name then
                tank_needs = tank_capacity      -- (Empty tank)
            else
                tank_needs = tank_capacity * (tank_stack:get_wear() / 65535)
            end

            -- Ignore tanks that are already full
            if tank_needs > 0 then

                -- Fill biggest tanks first
                if tank_capacity > most_fillable_capacity then

                    most_fillable_needs = max_uses + 1
                    most_fillable_capacity = tank_capacity

                end

                -- Fill tanks closest to being full first
                if tank_needs < most_fillable_needs then
                    most_fillable_needs = tank_needs
                end

                if most_fillable_capacity == tank_capacity and
                        most_fillable_needs == tank_needs then

                    most_fillable_index = i
                    most_fillable_stack = tank_stack
                    most_fillable_def_table = tank_def_table

                end

            end

        end

    end

    return most_fillable_index, most_fillable_stack, most_fillable_def_table

end

local function compressor_timestep_with_fuel(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    local fuel_time = meta:get_float("fuel_time")

    if (fuel_time < 1 and inv:is_empty("fuel")) or inv:is_empty("tanks") then
        return false
    end

    local most_fillable_index, most_fillable_stack, most_fillable_def_table = find_tank(inv)
    if most_fillable_index == 0 then
        return false
    end

    -- We now have a tank to fill. Do we have enough fuel?
    if fuel_time < 1 then

        -- (There should be something here, or the code above would already have exited)
        local fuel_item = inv:get_stack("fuel", 1)
        fuel_item:set_count(1)

        local other_fuel_item = inv:remove_item("fuel", fuel_item)
        local output_table = core.get_craft_result({
            items = {other_fuel_item:get_name()},
            method = "fuel",
            width = 1,
        })

        fuel_time = fuel_time + output_table.time

    end

    if fuel_time < 1 then

        -- Notes from original code:
        -- This fuel source is producing less than 1 second of burn time; unexpected, but possible
        -- Don't refill yet, just update the fuel burned and try again
        -- (This is an edge case so I'm not too worried about efficiency here)
        meta:set_float("fuel_time", fuel_time)
        return true

    end

    fuel_time = fuel_time - 1
    local wear_per_use = unilib.constant.max_tool_wear / most_fillable_def_table.use_count
    if most_fillable_def_table.filled_name then

        -- We're starting with a completely empty tank, turn it into a full tank and add wear
        most_fillable_stack = ItemStack(most_fillable_def_table.filled_name)
        most_fillable_stack:set_wear(unilib.constant.max_tool_wear - wear_per_use)

    else

        most_fillable_stack:set_wear(math.max(most_fillable_stack:get_wear() - wear_per_use, 0))

    end

    inv:set_stack("tanks", most_fillable_index, most_fillable_stack)
    meta:set_float("fuel_time", fuel_time)

    return true

end

local function compressor_timestep_without_fuel(pos)

    local meta = core.get_meta(pos)
    local inv = meta:get_inventory()
    if inv:is_empty("tanks") then
        return false
    end

    local most_fillable_index, most_fillable_stack, most_fillable_def_table = find_tank(inv)
    if most_fillable_index == 0 then
        return false
    end

    local wear_per_use = unilib.constant.max_tool_wear / most_fillable_def_table.use_count
    if most_fillable_def_table.filled_name then

        -- We're starting with a completely empty tank, turn it into a full tank and add wear
        most_fillable_stack = ItemStack(most_fillable_def_table.filled_name)
        most_fillable_stack:set_wear(unilib.constant.max_tool_wear - wear_per_use)

    else

        most_fillable_stack:set_wear(math.max(most_fillable_stack:get_wear() - wear_per_use, 0))

    end

    inv:set_stack("tanks", most_fillable_index, most_fillable_stack)
    return true

end

local function ensure_timer(pos)

    -- Whenever an inventory action is performed, makes sure there's a timer running
    local timer = core.get_node_timer(pos)
    if not timer:is_started() then
        timer:start(1)
    end

end

local function get_formspec(remaining_time)

    -- Was get_compressor_formspec()

    if unilib.setting.airtanks_compressor_fuel_flag then

        return "size[8,9]" ..
            "label[1,1.5;" .. S("Fuel") .. "]" ..
            "list[context;fuel;1,2;1,1;]" ..
            -- N.B. Added a box because it's hard to see the coal against the formspec background
            "box[0,2;0.8,0.9;" .. bg_colour .. "]" ..
            "image[0,2;1,1;unilib_mineral_coal_lump.png]" ..
            "label[1,3;" .. S("Pressure: @1", remaining_time) .. "]" ..
            "label[3,0;" .. S("Air tanks") .. "]" ..
            "list[context;tanks;3,0.5;4,4;]" ..
            "list[current_player;main;0,4.85;8,1;]" ..
            "list[current_player;main;0,6.08;8,3;8]" ..
            "listring[context;tanks]" ..
            "listring[current_player;main]"

    else

        return "size[8,9]" ..
            "label[2,0;" .. S("Air tanks") .. "]" ..
            "list[context;tanks;2,0.5;4,4;]" ..
            "list[current_player;main;0,4.85;8,1;]" ..
            "list[current_player;main;0,6.08;8,3;8]" ..
            "listring[context;tanks]" ..
            "listring[current_player;main]"

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.device_compressor_air.init()

    return {
        description = "Air compressor",
        notes = "Used to refill air tanks. Right-click the compressor to open its window, then" ..
                " place some fuel and one or more non-full tanks. If the Minetest setting is" ..
                " disabled, then the compressor doesn't need fuel",
        depends = {"metal_steel", "mineral_mese"},
    }

end

function unilib.pkg.device_compressor_air.exec()

    local c_mese = "unilib:mineral_mese_crystal_fragment"
    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:device_compressor_air", "airtanks:compressor", mode, {
        -- From airtanks:compressor
        description = S("Air Compressor"),
        tiles = {
            "unilib_device_compressor_air_bottom.png^[transformR90",
            "unilib_device_compressor_air_bottom.png^[transformR90",
            "unilib_device_compressor_air_side.png"
        },
        groups = {airtanks_compressor = 1, handy = 1, oddly_breakable_by_hand = 1},
        sounds = unilib.global.sound_table.metal,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, -0.4375, -0.5, 0.25, 0.0625, 0.5},
                {-0.3125, -0.5, -0.375, 0.3125, 0.125, 0.375},
                {-0.125, 0.125, -0.25, 0.125, 0.4375, 0.25},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local stack = inv:get_stack(from_list, from_index)
            return can_put(pos, to_list, to_index, stack)

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
            return can_put(pos, listname, index, stack)
        end,

        can_dig = function(pos, player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("fuel") and inv:is_empty("tanks")

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size("fuel", 1)
            inv:set_size("tanks", tank_inv_size)
            meta:set_float("fuel_time", 0)
            meta:set_string("formspec", get_formspec(0))

        end,

        on_metadata_inventory_move = ensure_timer,

        on_metadata_inventory_put = ensure_timer,

        on_metadata_inventory_take = ensure_timer,

        on_timer = function(pos, elapsed)

            local meta = core.get_meta(pos)
            local last_return_flag = true

            while elapsed > 0 and last_return_flag == true do

                if unilib.setting.airtanks_compressor_fuel_flag then
                    last_return_flag = compressor_timestep_with_fuel(pos)
                else
                    last_return_flag = compressor_timestep_without_fuel(pos)
                end

                elapsed = elapsed - 1

            end

            if last_return_flag == true then

                core.sound_play("unilib_device_compressor_air", {pos = pos, gain = 0.5})
                core.get_node_timer(pos):start(1)
                meta:set_string("last_state", "success")

            elseif meta:get("last_state") == "success" then

                core.sound_play("unilib_device_compressor_air_fail", {pos = pos, gain = 0.5})
                meta:set_string("last_state", "fail")

            end

            meta:set_string("formspec", get_formspec(math.floor(meta:get_float("fuel_time"))))

        end
    })
    core.register_craft({
        -- From airtanks:compressor
        output = "unilib:device_compressor_air",
        recipe = {
            {"", c_steel, ""},
            {c_steel, c_mese, c_steel},
            {"group:wood", c_steel, "group:wood"},
        },
    })

end
