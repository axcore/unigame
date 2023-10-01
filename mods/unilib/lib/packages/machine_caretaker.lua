---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    chunkkeeper
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_caretaker = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.chunkkeeper.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function allow_metadata_inventory_put(pos, listname, index, stack, player)

    -- Add fuel
    local meta = minetest.get_meta(pos)
    local count = stack:get_count()
    local inv = meta:get_inventory()

    if player:get_player_name() ~= meta:get_string("owner") or
            meta:get_string("owner") == "" then

        if not minetest.check_player_privs(player, {protection_bypass = true}) then
            return count
        end

    end

    if listname ~= "main" then

        -- Invalid inventory name
        return count

    end

    local recipe = minetest.get_craft_result({
        method = "fuel",
        items = {stack},
    })

    if not recipe then

        -- Failed getting recipes for stack
        return count

    elseif recipe.time == 0 then

        -- Didn't get a burnable item
        return count

    end

    local timer = meta:get_int("time_left")
    timer = timer + ((recipe.time * count) * unilib.pkg.shared_chunkkeeper.fuel_multiplier)
    meta:set_int("time_left", timer)
    unilib.pkg.shared_chunkkeeper.update_formspec(pos)
    stack:clear()
    inv:set_list("main", {})

    -- Eat all fuel, this will make the fuel itself vanish, but the timer will increase
    return -1

end

local function on_construct(pos, node)

    local meta = minetest.get_meta(pos)
    meta:set_int("super_user", 0)
    meta:set_int("time_left", 0)
    meta:set_int("running", 0)
    meta:set_int("hide_owner", 0)
    meta:set_string("owner", "")
    local inv = meta:get_inventory()
    inv:set_size("main", 1)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_caretaker.init()

    return {
        description = "Caretaker machine",
        notes = "When placed, keeps the surrounding mapblock loaded into Minetest memory, but" ..
                " requires fuel to work",
        depends = {"metal_gold", "metal_steel", "mineral_diamond", "shared_chunkkeeper"},
    }

end

function unilib.pkg.machine_caretaker.exec()

    unilib.register_node("unilib:machine_caretaker_off", "chunkkeeper:keeper_off", mode, {
        -- From chunkkeeper:keeper_off
        description = unilib.brackets(S("Caretaker Machine"), S("Off")),
        tiles = {
            "unilib_machine_caretaker_top_off.png",
            "unilib_machine_caretaker_bottom.png",
        },
        -- N.B. Original code included handy = 1
        groups = {oddly_breakable_by_hand = 3},
        -- (no sounds)

        drop = "unilib:machine_caretaker_off",
        is_ground_content = false,

        after_place_node = unilib.pkg.shared_chunkkeeper.after_place_node,

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        on_construct = on_construct,

        on_receive_fields = unilib.pkg.shared_chunkkeeper.on_receive_fields,

        on_timer = function(pos, elapsed)
            return unilib.pkg.shared_chunkkeeper.process_fuel(pos)
        end,
    })
    unilib.register_craft({
        -- From chunkkeeper:keeper_off
        output = "unilib:machine_caretaker_off",
        recipe = {
            {"", "unilib:mineral_diamond_gem", ""},
            {"unilib:metal_steel_ingot", "unilib:mineral_diamond_gem", "unilib:metal_steel_ingot"},
            {"unilib:metal_steel_ingot", "unilib:metal_gold_ingot", "unilib:metal_steel_ingot"}
        }
    })

    unilib.register_node("unilib:machine_caretaker_on", "chunkkeeper:keeper_on", mode, {
        -- From chunkkeeper:keeper_on
        description = unilib.brackets(S("Caretaker Machine"), S("On")),
        tiles = {
            {
                name = "unilib_machine_caretaker_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 32,
                    aspect_h = 32,
                    length = 2.0
                }
            },
            "unilib_machine_caretaker_bottom.png",
        },
        -- N.B. Original code included handy = 1, lacked not_in_creative_inventory = 1,
        groups = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 3},
        -- (no sounds)

        drop = "unilib:machine_caretaker_off",
        is_ground_content = false,

        after_place_node = unilib.pkg.shared_chunkkeeper.after_place_node,

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        on_construct = on_construct,

        on_receive_fields = unilib.pkg.shared_chunkkeeper.on_receive_fields,

        on_timer = function(pos, elapsed)
            return unilib.pkg.shared_chunkkeeper.process_fuel(pos)
        end,
    })

end
