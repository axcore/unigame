---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_pile_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

local formspec =
    "size[8,7;]" ..
    "list[context;pile;0,0.3;8,2;]" ..
    "list[current_player;main;0,2.85;8,1;]" ..
    "list[current_player;main;0,4.08;8,3;8]" ..
    "listring[context;pile]" ..
    "listring[current_player;main]" ..
    unilib.misc.get_hotbar_bg(0, 2.85)

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

local function combine_textures(part_name)

    local trunk_img = "unilib_tree_" .. part_name .. "_trunk.png"
    local rotate_img = "(" .. trunk_img .. "^[transformFXR90" .. ")"
    local top_img = "unilib_tree_" .. part_name .. "_trunk_top.png"

    local comb_top_img = "[combine:48x48" ..
            ":0,0=" .. trunk_img ..
            ":0,16=" .. trunk_img ..
            ":0,32=" .. trunk_img ..
            ":16,0=" .. trunk_img ..
            ":16,16=" .. trunk_img ..
            ":16,32=" .. trunk_img ..
            ":32,0=" .. trunk_img ..
            ":32,16=" .. trunk_img ..
            ":32,32=" .. trunk_img ..
            "^unilib_misc_pile_wood_top_overlay.png"

    local comb_side_img = "[combine:48x48" ..
            ":0,0=" .. rotate_img ..
            ":0,8=" .. top_img ..
            ":0,16=" .. rotate_img ..
            ":0,24=" .. top_img ..
            ":0,32=" .. rotate_img ..
            ":0,40=" .. top_img ..

            ":16,0=" .. rotate_img ..
            ":16,8=" .. top_img ..
            ":16,16=" .. rotate_img ..
            ":16,24=" .. top_img ..
            ":16,32=" .. rotate_img ..
            ":16,40=" .. top_img ..

            ":32,0=" .. rotate_img ..
            ":32,8=" .. top_img ..
            ":32,16=" .. rotate_img ..
            ":32,24=" .. top_img ..
            ":32,32=" .. rotate_img ..
            ":32,40=" .. top_img ..
            "^unilib_misc_pile_wood_side_overlay.png"

    local comb_front_img = "[combine:48x48" ..
            ":0,0=" .. top_img ..
            ":0,8=" .. rotate_img ..
            ":0,16=" .. top_img ..
            ":0,24=" .. rotate_img ..
            ":0,32=" .. top_img ..
            ":0,40=" .. rotate_img ..

            ":16,0=" .. top_img ..
            ":16,8=" .. rotate_img ..
            ":16,16=" .. top_img ..
            ":16,24=" .. rotate_img ..
            ":16,32=" .. top_img ..
            ":16,40=" .. rotate_img ..

            ":32,0=" .. top_img ..
            ":32,8=" .. rotate_img ..
            ":32,16=" .. top_img ..
            ":32,24=" .. rotate_img ..
            ":32,32=" .. top_img ..
            ":32,40=" .. rotate_img ..
            "^unilib_misc_pile_wood_front_overlay.png"

    return  comb_top_img, comb_side_img, comb_front_img

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

    -- "orig_name" is specified for the five minetest_game woods, for which BBQ provides a full set
    --      of textures; for everything else, create composite textures
    local comb_top_img = "unilib_misc_pile_wood_" .. part_name .. "_top.png"
    local comb_side_img = "unilib_misc_pile_wood_" .. part_name .. "_side.png"
    local comb_front_img = "unilib_misc_pile_wood_" .. part_name .. "_front.png"
    if orig_name == nil then
        comb_top_img, comb_side_img, comb_front_img = combine_textures(part_name)
    end

    local def_table = {
        description = unilib.utils.brackets(S("Wood Pile"), description),
        tiles = {
            comb_top_img,
            comb_top_img,
            comb_front_img,
            comb_front_img,
            comb_side_img,
            comb_side_img,
        },
        groups = {choppy = 3, flammable = 3, oddly_breakable_by_hand = 2},
        sounds = unilib.global.sound_table.wood,

        -- N.B. drop not in original code; added to match code in "misc_pile_logs" package
        drop = ingredient .. " 7",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",

        allow_metadata_inventory_put = function(pos, listname, index, stack)

            -- Original to unilib
            -- This version of the wood pile only accepts trunks, wood, leaves and sapling from
            --      the correct tree type

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local stack_name = stack:get_name()

            if (
                core.get_item_group(stack_name, "tree") == 0 and
                core.get_item_group(stack_name, "wood") == 0 and
                core.get_item_group(stack_name, "leaves") == 0 and
                core.get_item_group(stack_name, "sapling") == 0
            ) or not string.find(stack_name, "^unilib:tree_" .. part_name .. "_") then
                return 0
            else
                return stack:get_count()
            end

        end,

        can_dig = function(pos,player)

            local inv = core.get_meta(pos):get_inventory()
            return inv:is_empty("pile")

        end,

        on_blast = function(pos)

            local drops = {}
            unilib.misc.get_inventory_drops(pos, "pile", drops)
            drops[#drops + 1] = full_name
            core.remove_node(pos)
            return drops

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_formspec(nil))
            local inv = meta:get_inventory()
            inv:set_size("pile", 8 * 2)

        end,

        --[[
        on_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items in wood pile at " ..
                        core.pos_to_string(pos)
            )

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_formspec(meta:get_inventory()))

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " moves items to wood pile at " ..
                        core.pos_to_string(pos)
            )

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_formspec(meta:get_inventory()))

        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)

            unilib.utils.log(
                "action",
                player:get_player_name() .. " takes items from wood pile at " ..
                        core.pos_to_string(pos)
            )

            local meta = core.get_meta(pos)
            meta:set_string("formspec", get_formspec(meta:get_inventory()))

        end,
        ]]--
    }

    unilib.utils.set_inventory_action_loggers(def_table, "wood pile")
    unilib.register_node(full_name, orig_name, replace_mode, def_table)

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
        notes = "This package creates wood piles from the full range of super trees. Wood piles" ..
                " differ from log piles, in that they act as containers for trunks, wood, leaves" ..
                " and saplings for a specific tree type",
    }

end

function unilib.pkg.misc_pile_wood.post()

    local orig_name_table = {
        acacia = "bbq:woodpile_acacia",
        apple = "bbq:woodpile",
        aspen = "bbq:woodpile_aspen",
        jungle = "bbq:woodpile_jungle",
        pine = "bbq:woodpile_pine",
    }

    for part_name, _ in pairs(unilib.global.super_tree_table) do

        local data_table = unilib.global.tree_table[part_name]
        local ingredient = "unilib:tree_" .. part_name .. "_wood"

        if unilib.global.super_tree_table[part_name] ~= nil and
                unilib.global.pkg_executed_table["tree_" .. part_name] ~= nil and
                core.registered_nodes[ingredient] ~= nil then

            do_register({
                part_name = part_name,
                orig_name = orig_name_table[part_name],
                ingredient = ingredient,

                replace_mode = mode,
                description = unilib.utils.brackets(S("Wood Pile"), data_table.description),
            })

        end

    end

end
