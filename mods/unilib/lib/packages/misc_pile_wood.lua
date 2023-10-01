---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_pile_wood = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

local formspec =
    "size[8,7;]" ..
    "list[context;pile;0,0.3;8,2;]" ..
    "list[current_player;main;0,2.85;8,1;]" ..
    "list[current_player;main;0,4.08;8,3;8]" ..
    "listring[context;pile]" ..
    "listring[current_player;main]" ..
    unilib.get_hotbar_bg(0, 2.85)

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec(inv)

    -- Was get_bbq_woodpile_formspec()

    local formspec = formspec
    local invlist = inv and inv:get_list("pile")

    -- Inventory slots overlay
    local vx, vy = 0, 0.3
    for i = 1, 16 do

        if i == 9 then

            vx = 0
            vy = vy + 1

        end

        if not invlist or invlist[i]:is_empty() then

            formspec = formspec .. "image[" .. vx .. "," .. vy ..
                    ";1,1;unilib_misc_pile_wood_slot.png]"

        end

        vx = vx + 1

    end

    return formspec

end

local function do_register(data_table)

    -- Adapted from bbq/woodpile.lua
    -- Create a wood pile for the specified tree type
    -- N.B. This version of the wood pile only accepts trunks, wood, leaves and sapling from the
    --      correct tree type (the wood pile in the original code accepted anything)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "apple"
    --      orig_name (str): e.g. "bbq:woodpile"
    --      ingredient (str): e.g. "unilib:tree_apple_trunk"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Wood Pile (Apple Tree Wood)"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local ingredient = data_table.ingredient

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Wood Pile")

    local full_name = "unilib:misc_pile_wood_" .. part_name

    unilib.register_node(full_name, orig_name, replace_mode, {
        description = unilib.brackets(S("Wood Pile"), description),
        tiles = {
            "unilib_misc_pile_wood_" .. part_name .. "_top.png",
            "unilib_misc_pile_wood_" .. part_name .. "_top.png",
            "unilib_misc_pile_wood_" .. part_name .. "_side.png",
            "unilib_misc_pile_wood_" .. part_name .. "_side.png",
            "unilib_misc_pile_wood_" .. part_name .. "_front.png",
            "unilib_misc_pile_wood_" .. part_name .. "_front.png",
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.sound_table.wood,

        -- N.B. drop not in original code; added to match code in "misc_pile_logs" package
        drop = ingredient .. " 7",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",

        allow_metadata_inventory_put = function(pos, listname, index, stack)

            -- Original to unilib
            -- This version of the wood pile only accepts trunks, wood, leaves and sapling from
            --      the correct tree type

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local stack_name = stack:get_name()

            if (
                minetest.get_item_group(stack_name, "tree") == 0 and
                minetest.get_item_group(stack_name, "wood") == 0 and
                minetest.get_item_group(stack_name, "leaves") == 0 and
                minetest.get_item_group(stack_name, "sapling") == 0
            ) or not string.find(stack_name, "^unilib:tree_" .. part_name .. "_") then
                return 0
            else
                return stack:get_count()
            end

        end,

        can_dig = function(pos,player)

            local inv = minetest.get_meta(pos):get_inventory()
            return inv:is_empty("pile")

        end,

        on_blast = function(pos)

            local drops = {}
            unilib.get_inventory_drops(pos, "pile", drops)
            drops[#drops + 1] = full_name
            minetest.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", get_formspec(nil))
            local inv = meta:get_inventory()
            inv:set_size("pile", 8 * 2)

        end,

        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff in wood pile at " ..
                minetest.pos_to_string(pos)
            )

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", get_formspec(meta:get_inventory()))

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.log(
                "action",
                player:get_player_name() .. " moves stuff to wood pile at " ..
                minetest.pos_to_string(pos)
            )

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", get_formspec(meta:get_inventory()))

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.log(
                "action",
                player:get_player_name() .. " takes stuff from wood pile at " ..
                minetest.pos_to_string(pos)
            )

            local meta = minetest.get_meta(pos)
            meta:set_string("formspec", get_formspec(meta:get_inventory()))

        end,
    })
    -- N.B. Original craft recipe conflicts with recipe in "shared_fachwerk" package
    --[[
    unilib.register_craft_3x3({
        output = full_name,
        ingredient = ingredient,
    })
    ]]--
    unilib.register_craft({
        output = full_name,
        recipe = {
            {"", ingredient, ""},
            {ingredient, ingredient, ingredient},
            {ingredient, ingredient, ingredient},
        },
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_pile_wood.init()

    return {
        description = "Wood pile set",
        notes = "This package creates wood piles from a limited range of super trees. Wood" ..
                " piles differ from log piles, in that they act as containers for trunks, wood," ..
                " leaves and saplings for a specific tree type",
    }

end

function unilib.pkg.misc_pile_wood.post()

    local pile_list = {
        -- minetest_game trees
        {
            part_name = "acacia",
            orig_name = "bbq:woodpile_acacia",
        },
        {
            part_name = "apple",
            orig_name = "bbq:woodpile",
        },
        {
            part_name = "aspen",
            orig_name = "bbq:woodpile_aspen",
        },
        {
            part_name = "jungle",
            orig_name = "bbq:woodpile_jungle",
        },
        {
            part_name = "pine",
            orig_name = "bbq:woodpile_pine",
        },
    }

    for _, mini_table in pairs(pile_list) do

        local data_table = unilib.tree_table[mini_table.part_name]
        local ingredient = mini_table.ingredient or
                "unilib:tree_" .. mini_table.part_name .. "_wood"

        if unilib.super_tree_table[mini_table.part_name] ~= nil and
                unilib.pkg_executed_table["tree_" .. mini_table.part_name] ~= nil and
                minetest.registered_nodes[ingredient] ~= nil then

            do_register({
                part_name = mini_table.part_name,
                orig_name = mini_table.orig_name,
                ingredient = ingredient,

                replace_mode = mode,
                description = unilib.brackets(S("Wood Pile"), data_table.description),
            })

        end

    end

end
