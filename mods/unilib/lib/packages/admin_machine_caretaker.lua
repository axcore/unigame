---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    chunkkeeper
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.admin_machine_caretaker = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.chunkkeeper.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function allow_metadata_inventory_put(pos, listname, index, stack, player)

    -- Add fuel
    local count = stack:get_count()
    -- Invalid, there is no need to add time for a infinite time
    return count

end

local function on_construct(pos, node)

    local meta = minetest.get_meta(pos)
    meta:set_int("super_user", 1)
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

function unilib.pkg.admin_machine_caretaker.init()

    return {
        description = "Admin caretaker machine",
        notes = "When placed, keeps the surrounding mapblock loaded into Minetest memory." ..
                " Requires no fuel and runs forever",
        depends = "shared_chunkkeeper",
    }

end

function unilib.pkg.admin_machine_caretaker.exec()

    unilib.register_node("unilib:admin_machine_caretaker_off", "chunkkeeper:keeper_inf_off", mode, {
        -- From chunkkeeper:keeper_inf_off
        description = unilib.brackets(S("Admin Caretaker Machine"), S("Off")),
        -- N.B. Unlike original code, using tweaked textures, so admin/non-admin machines look
        --      different
        tiles = {
            "unilib_admin_machine_caretaker_top_off.png",
            "unilib_admin_machine_caretaker_bottom.png",
        },
        -- N.B. Original code included handy = 1
        -- N.B. not_in_creative_inventory not in original code
        groups = {
            not_in_creative_inventory = unilib.show_admin_item_group, oddly_breakable_by_hand = 3,
        },
        -- (no sounds)

        drop = "unilib:admin_machine_caretaker_off",
        is_ground_content = false,

        after_place_node = unilib.pkg.shared_chunkkeeper.after_place_node,

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        on_construct = on_construct,

        on_receive_fields = unilib.pkg.shared_chunkkeeper.on_receive_fields,

        on_timer = function(pos, elapsed)

            -- Needs to run for changing persistence
            return unilib.pkg.shared_chunkkeeper.process_fuel(pos)

        end,
    })

    unilib.register_node("unilib:admin_machine_caretaker_on", "chunkkeeper:keeper_inf_on", mode, {
        -- From chunkkeeper:keeper_inf_on
        description = unilib.brackets(S("Admin Caretaker Machine"), S("On")),
        tiles = {
            {
                name = "unilib_admin_machine_caretaker_animated.png",
                animation = {
                    type = "vertical_frames",
                    aspect_w = 32,
                    aspect_h = 32,
                    length = 2.0
                }
            },
            "unilib_admin_machine_caretaker_bottom.png",
        },
        -- N.B. Original code included handy = 1, lacked not_in_creative_inventory = 1,
        groups = {not_in_creative_inventory = 1, oddly_breakable_by_hand = 3},
        -- (no sounds)

        drop = "unilib:admin_machine_caretaker_off",
        is_ground_content = false,

        after_place_node = unilib.pkg.shared_chunkkeeper.after_place_node,

        allow_metadata_inventory_put = allow_metadata_inventory_put,

        on_construct = on_construct,

        on_receive_fields = unilib.pkg.shared_chunkkeeper.on_receive_fields,

        on_timer = function(pos, elapsed)

            -- Needs to run for changing persistence
            return unilib.pkg.shared_chunkkeeper.process_fuel(pos)

        end,
    })

end
