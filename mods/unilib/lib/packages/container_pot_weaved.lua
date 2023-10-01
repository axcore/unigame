---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.container_pot_weaved = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.earthbuild.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function is_owner(pos, name)

    local owner = minetest.get_meta(pos):get_string("owner")
    if owner == "" or owner == name or minetest.check_player_privs(name, "protection_bypass") then
        return true
    end

    return false

end

local function get_storage_formspec(pos)

    local formspec ="size[8,7]" ..
            "list[current_name;main;0,0.3;8,2]" ..
            "list[current_player;main;0,2.85;8,1]" ..
            "list[current_player;main;0,4.08;8,3;8]" ..
            "listring[current_name;main]" ..
            "listring[current_player;main]"

    return formspec

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_pot_weaved.init()

    return {
        description = "Weaved pot",
    }

end

function unilib.pkg.container_pot_weaved.exec()

    unilib.register_node("unilib:container_pot_weaved", "earthbuild:basket", mode, {
        -- From earthbuild:basket
        description = S("Weaved pot"),
        tiles = {
            "unilib_container_pot_weaved_top.png",
            "unilib_container_pot_weaved_top.png",
            "unilib_container_pot_weaved.png",
            "unilib_container_pot_weaved.png",
            "unilib_container_pot_weaved.png",
            "unilib_container_pot_weaved.png",
        },
        groups = {oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.leaves,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.25, 0.375, -0.25, 0.25, 0.5, 0.25},
                {-0.375, -0.25, -0.375, 0.375, 0.3125, 0.375},
                {-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125},
                {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25},
                {-0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125},
            },
        },
        paramtype = "light",
        use_texture_alpha = "clip",

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            if is_owner(pos, player:get_player_name()) then
                return count
            end

            return 0

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            if is_owner(pos, player:get_player_name()) and
                    not string.match(stack:get_name(), "backpacks:") then
                return stack:get_count()
            end

            return 0

        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            if is_owner(pos, player:get_player_name()) then
                return stack:get_count()
            end

            return 0

        end,

        can_dig = function(pos, player)

            local inv = minetest.get_meta(pos):get_inventory()
            local name = ""
            if player then
                name = player:get_player_name()
            end

            return is_owner(pos, name) and inv:is_empty("main")

        end,

        on_blast = function() end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", get_storage_formspec(pos, 8, 2))
            local inv = meta:get_inventory()
            inv:set_size("main", 8*2)
            meta:set_string("infotext", S("Weaved Pot"))

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            -- N.B. This callback and its log message not in original code
            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff in weaved pot at " ..
                        minetest.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            -- N.B. This callback and its log message not in original code
            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff to weaved pot at " ..
                        minetest.pos_to_string(pos)
            )

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            -- N.B. This callback and its log message not in original code
            unilib.log(
                "action",
                player:get_player_name() .. " takes stuff from weaved pot at " ..
                        minetest.pos_to_string(pos)
            )

        end,
    })
    unilib.register_craft({
        -- From earthbuild:basket
        output = "unilib:container_pot_weaved",
        recipe = {
            {"unilib:misc_mat_woven", "unilib:misc_mat_woven", "unilib:misc_mat_woven"},
            {"unilib:misc_mat_woven", "", "unilib:misc_mat_woven"},
            {"unilib:misc_mat_woven", "unilib:misc_mat_woven", "unilib:misc_mat_woven"},
        }
    })
    unilib.register_craft({
        -- From earthbuild:basket
        type = "fuel",
        recipe = "unilib:container_pot_weaved",
        burntime = 8,
    })

end
