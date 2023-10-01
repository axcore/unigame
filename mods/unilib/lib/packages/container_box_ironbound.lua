---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_storage
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_box_ironbound = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.castle_storage.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local get_formspec = function(pos)

    local spos = pos.x .. "," .. pos.y .. "," ..pos.z
    --[[
    local formspec =
        "size[8,9]"..
        "list[nodemeta:" .. spos .. ";main;,0;8,4;]"..
        "list[current_player;main;,5;8,4;]"
    ]]--
    local formspec =
        "size[8,7.7]"..
        "list[nodemeta:" .. spos .. ";main;,0.2;8,3;]"..
        "list[current_player;main;,3.7;8,4;]" ..
        "listring[nodemeta:" .. spos .. ";main]" ..
        "listring[current_player;main]"

    return formspec

end

local function has_privilege(meta, player)

    local name = ""
    if player then

        if minetest.check_player_privs(player, "protection_bypass") then
            return true
        end

        name = player:get_player_name()

    end

    if name ~= meta:get_string("owner") then
        return false
    end

    return true

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_box_ironbound.init()

    return {
        description = "Ironbound box",
        notes = "A locked container that only the owner can access",
        depends = "metal_steel",
    }

end

function unilib.pkg.container_box_ironbound.exec()

    unilib.register_node(
        -- From castle_storage:ironbound_chest
        "unilib:container_box_ironbound",
        "castle_storage:ironbound_chest",
        mode,
        {
            description = S("Ironbound Box"),
            tiles = {
                "unilib_container_box_ironbound_top.png",
                "unilib_container_box_ironbound_top.png",
                "unilib_container_box_ironbound_side.png",
                "unilib_container_box_ironbound_side.png",
                "unilib_container_box_ironbound_back.png",
                "unilib_container_box_ironbound_front.png",
            },
            groups = {cracky = 2},
            sounds = unilib.sound_table.wood,

            drawtype = "nodebox",
            node_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.3125, 0.5, -0.0625, 0.3125},
                    {-0.5, -0.0625, -0.25, 0.5, 0, 0.25},
                    {-0.5, 0, -0.1875,0.5, 0.0625, 0.1875},
                    {-0.5, 0.0625, -0.0625, 0.5, 0.125, 0.0625},
                },
            },
            paramtype = "light",
            paramtype2 = "facedir",
            selection_box = {
                type = "fixed",
                fixed = {
                    {-0.5, -0.5, -0.4, 0.5, 0.2, 0.4},
                },
            },

            after_place_node = function(pos, placer)

                local meta = minetest.get_meta(pos)
                meta:set_string("owner", placer:get_player_name() or "")
                meta:set_string(
                    "infotext", S("Ironbound Box (owned by @1)", meta:get_string("owner"))
                )

            end,

            allow_metadata_inventory_move = function(
                pos, from_list, from_index, to_list, to_index, count, player
            )
                local meta = minetest.get_meta(pos)
                if not has_privilege(meta, player) then

                    unilib.log(
                        "action",
                        S(
                            "@1 tried to access a locked box belonging to @2 at @3",
                            player:get_player_name(),
                            meta:get_string("owner"),
                            minetest.pos_to_string(pos)
                        )
                    )

                    return 0

                end

                return count

            end,

            allow_metadata_inventory_put = function(pos, listname, index, stack, player)

                local meta = minetest.get_meta(pos)
                if not has_privilege(meta, player) then

                    unilib.log(
                        "action",
                        S(
                            "@1 tried to access a locked box belonging to @2 at @3",
                            player:get_player_name(),
                            meta:get_string("owner"),
                            minetest.pos_to_string(pos)
                        )
                    )

                    return 0

                end

                return stack:get_count()

            end,

            allow_metadata_inventory_take = function(pos, listname, index, stack, player)

                local meta = minetest.get_meta(pos)
                if not has_privilege(meta, player) then

                    unilib.log(
                        "action",
                        S(
                            "@1 tried to access a locked box belonging to @2 at @3",
                            player:get_player_name(),
                            meta:get_string("owner"),
                            minetest.pos_to_string(pos)
                        )
                    )

                    return 0

                end

                return stack:get_count()

            end,

            on_construct = function(pos)

                local meta = minetest.get_meta(pos)
                meta:set_string("infotext", S("Ironbound Box"))
                meta:set_string("owner", "")
                local inv = meta:get_inventory()
                -- N.B. Size was 8 * 4 in original code; reduced it, as the box is smaller than an
                --      ordinary chest
                inv:set_size("main", 8 * 3)

            end,

            can_dig = function(pos,player)

                local meta = minetest.get_meta(pos);
                local inv = meta:get_inventory()
                return inv:is_empty("main") and has_privilege(meta, player)

            end,

            on_blast = function() end,

            on_metadata_inventory_move = function(
                pos, from_list, from_index, to_list, to_index, count, player
            )
                unilib.log(
                    "action",
                    player:get_player_name() .. " moves stuff in ironbound box at " ..
                            minetest.pos_to_string(pos)
                )

            end,

            on_metadata_inventory_put = function(pos, listname, index, stack, player)

                unilib.log(
                    "action",
                    player:get_player_name() .. " moves stuff to ironbound box at " ..
                            minetest.pos_to_string(pos)
                )

            end,

            on_metadata_inventory_take = function(pos, listname, index, stack, player)

                unilib.log(
                    "action",
                    player:get_player_name() .. " takes stuff from ironbound box at " ..
                            minetest.pos_to_string(pos)
                )

            end,

            on_rightclick = function(pos, node, clicker)

                local meta = minetest.get_meta(pos)
                if has_privilege(meta, clicker) then

                    minetest.show_formspec(
                        clicker:get_player_name(),
                        "unilib:container_box_ironbound",
                        get_formspec(pos)
                    )

                end

            end,
        }
    )
    -- N.B. Original code used "default:wood"
    unilib.register_craft({
        -- From castle_storage:ironbound_chest
        output = "unilib:container_box_ironbound",
        recipe = {
            {"group:wood", "unilib:metal_steel_ingot", "group:wood"},
            {"group:wood", "unilib:metal_steel_ingot", "group:wood"},
        },
    })

end
