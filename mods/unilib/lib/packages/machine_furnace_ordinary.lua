---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.machine_furnace_ordinary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.default.add_mode

-- Pipeworks compatibility
local pipeworks_flag = false
if minetest.get_modpath("pipeworks") then
    pipeworks_flag = true
end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.machine_furnace_ordinary.init()

    return {
        description = "Ordinary furnace",
        mod_optional = "pipeworks",
        depends = "shared_default_furnace",
    }

end

function unilib.pkg.machine_furnace_ordinary.exec()

    local inactive_img_list = {
        "unilib_machine_furnace_ordinary_top.png",
        "unilib_machine_furnace_ordinary_bottom.png",
        "unilib_machine_furnace_ordinary_side.png",
        "unilib_machine_furnace_ordinary_side.png",
        "unilib_machine_furnace_ordinary_side.png",
        "unilib_machine_furnace_ordinary_front.png"
    }

    local active_img_list = {
        "unilib_machine_furnace_ordinary_top.png",
        "unilib_machine_furnace_ordinary_bottom.png",
        "unilib_machine_furnace_ordinary_side.png",
        "unilib_machine_furnace_ordinary_side.png",
        "unilib_machine_furnace_ordinary_side.png",
        {
            image = "unilib_machine_furnace_ordinary_front_active.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1.5,
            },
        }
    }

    local inactive_group_table = {cracky = 2}
    -- N.B. active_furnace = 1 not in original code
    local active_group_table = {active_furnace = 1, cracky = 2, not_in_creative_inventory = 1}

    local tube_table = nil

    local after_dig_node = nil
    local after_place_node = nil
    local inactive_on_receive_fields = nil
    local active_on_receive_fields = nil
    local on_rotate = nil

    if pipeworks_flag then

        for i = 1, 5 do

            inactive_img_list[i] = inactive_img_list[i] .. "^unilib_tube_connection_stone.png"
            active_img_list[i] = inactive_img_list[i] .. "^unilib_tube_connection_stone.png"

        end

        inactive_group_table.tubedevice = 1
        inactive_group_table.tubedevice_receiver = 1
        active_group_table.tubedevice = 1
        active_group_table.tubedevice_receiver = 1

        tube_table = unilib.pkg.shared_default_furnace.get_tube_table

        after_dig_node = pipeworks.after_dig

        after_place_node = pipeworks.after_place

        inactive_on_receive_fields = unilib.pkg.shared_default_furnace.inactive_on_receive_fields

        active_on_receive_fields = unilib.pkg.shared_default_furnace.active_on_receive_fields

        on_rotate = pipeworks.on_rotate

    end

    unilib.register_node("unilib:machine_furnace_ordinary", "default:furnace", mode, {
        -- From default:furnace
        description = S("Ordinary Furnace"),
        tiles = inactive_img_list,
        groups = inactive_group_table,
        sounds = unilib.sound_table.stone,

        is_ground_content = false,
        paramtype2 = "facedir",
        tube = tube_table,

        after_dig_node = after_dig_node,

        after_place_node = after_place_node,

        allow_metadata_inventory_move =
                unilib.pkg.shared_default_furnace.allow_metadata_inventory_move,

        allow_metadata_inventory_put =
                unilib.pkg.shared_default_furnace.allow_metadata_inventory_put,

        allow_metadata_inventory_take =
                unilib.pkg.shared_default_furnace.allow_metadata_inventory_take,

        can_dig = unilib.pkg.shared_default_furnace.can_dig,

        on_blast = function(pos)

            local drops = {}
            unilib.get_inventory_drops(pos, "src", drops)
            unilib.get_inventory_drops(pos, "fuel", drops)
            unilib.get_inventory_drops(pos, "dst", drops)
            drops[#drops + 1] = "unilib:machine_furnace_ordinary"
            minetest.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            inv:set_size('src', 1)
            inv:set_size('fuel', 1)
            inv:set_size('dst', 4)

            unilib.pkg.shared_default_furnace.furnace_node_timer(
                pos,
                0,
                "unilib:machine_furnace_ordinary",
                "unilib:machine_furnace_ordinary_active"
            )

        end,

        on_metadata_inventory_move = function(pos)
            minetest.get_node_timer(pos):start(1.0)
        end,

        on_metadata_inventory_put = function(pos)

            -- Start timer function, it will sort out whether furnace can burn or not
            minetest.get_node_timer(pos):start(1.0)

        end,

        on_metadata_inventory_take = function(pos)

            -- Check whether the furnace is empty or not
            minetest.get_node_timer(pos):start(1.0)

        end,

        on_receive_fields = inactive_on_receive_fields,

        on_rotate = on_rotate,

        on_timer = function(pos, elapsed)

            return unilib.pkg.shared_default_furnace.furnace_node_timer(
                pos,
                elapsed,
                "unilib:machine_furnace_ordinary",
                "unilib:machine_furnace_ordinary_active"
            )

        end,
    })
    unilib.register_craft({
        -- From default:furnace
        output = "unilib:machine_furnace_ordinary",
        recipe = {
            {"group:stone", "group:stone", "group:stone"},
            {"group:stone", "", "group:stone"},
            {"group:stone", "group:stone", "group:stone"},
        }
    })
    if unilib.mtgame_tweak_flag then

        unilib.register_craft({
            -- From aotearoa/crafting.lua
            output = "unilib:machine_furnace_ordinary",
            recipe = {
                {"group:soft_stone", "group:soft_stone", "group:soft_stone"},
                {"group:soft_stone", "", "group:soft_stone"},
                {"group:soft_stone", "group:soft_stone", "group:soft_stone"},
            }
        })

    end

    unilib.register_node("unilib:machine_furnace_ordinary_active", "default:furnace_active", mode, {
        -- From default:furnace_active
        description = S("Ordinary Furnace"),
        tiles = active_img_list,
        groups = active_group_table,
        sounds = unilib.sound_table.stone,

        drop = "unilib:machine_furnace_ordinary",
        is_ground_content = false,
        light_source = 8,
        paramtype2 = "facedir",
        tube = tube_table,

        after_dig_node = after_dig_node,

        after_place_node = after_place_node,

        allow_metadata_inventory_move =
                unilib.pkg.shared_default_furnace.allow_metadata_inventory_move,

        allow_metadata_inventory_put =
                unilib.pkg.shared_default_furnace.allow_metadata_inventory_put,

        allow_metadata_inventory_take =
                unilib.pkg.shared_default_furnace.allow_metadata_inventory_take,

        can_dig = unilib.pkg.shared_default_furnace.can_dig,

        on_receive_fields = active_on_receive_fields,

        on_rotate = on_rotate,

        on_timer = function(pos, elapsed)

            return unilib.pkg.shared_default_furnace.furnace_node_timer(
                pos,
                elapsed,
                "unilib:machine_furnace_ordinary",
                "unilib:machine_furnace_ordinary_active"
            )

        end,
    })

end
