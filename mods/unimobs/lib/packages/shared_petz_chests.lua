---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_petz_chests = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

-- Was petz.chest.open_chests
local open_chest_table = {}
-- Was petz.christmas_cards = {}
local xmas_card_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function chest_lid_obstructed(pos)

    -- Adapted from default/chests.lua

    local above_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
    local def_table = core.registered_nodes[core.get_node(above_pos).name]

    -- Allow ladders, signs, wallmounted things and torches to not obstruct a chest
    if def_table and (
        def_table.drawtype == "airlike" or
        def_table.drawtype == "signlike" or
        def_table.drawtype == "torchlike" or
        (def_table.drawtype == "nodebox" and def_table.paramtype2 == "wallmounted")
    ) then
        return false
    else
        return true
    end

end

local function get_formspec(pos)

    -- Was petz.chest.get_chest_formspec()

    local spos = pos.x .. "," .. pos.y .. "," .. pos.z
    local meta = core.get_meta(pos)

    local xmas_msg = meta:get_string("xmas_msg")
    if not xmas_msg or xmas_msg == "" then
        xmas_msg = S("Merry Christmas")
    end

    return "size[8,7]" ..
        "image[0,0;1,1;unilib_container_present_christmas_inv.png]" ..
        "label[1,0;" .. xmas_msg.."]" ..
        "list[nodemeta:" .. spos .. ";main;2,1.3;4,1;]" ..
        "list[current_player;main;0,2.85;8,1;]" ..
        "list[current_player;main;0,4.08;8,3;8]" ..
        "listring[nodemeta:" .. spos .. ";main]" ..
        "listring[current_player;main]" ..
        unilib.misc.get_hotbar_bg(0, 2.85)

end

local function close_lid(pname)

    -- Was petz.chest.chest_lid_close()

    local chest_open_info = open_chest_table[pname]
    local pos = chest_open_info.pos
    local sound = chest_open_info.sound
    local swap = chest_open_info.swap

    open_chest_table[pname] = nil
    for k, v in pairs(open_chest_table) do

        if vector.equals(v.pos, pos) then
            return true
        end

    end

    core.after(0.2, function()

        local node = core.get_node(pos)
        -- If the chest has already been replaced, do nothing
        if node.name ~= swap .. "_open" then
            return
        end

        core.swap_node(pos, {name = swap, param2 = node.param2})
        core.sound_play(sound, {gain = 0.3, pos = pos, max_hear_distance = 10})

    end)

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_chests.register_chest(data_table)

    -- Was petz.register_chest()
    -- Creates a petz-specific chest
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "ordinary"
    --      orig_name_list (list or nil): The closed and open chests, in that order, e.g.
    --          {"default:chest", "default:chest_open"},
    --      def_table (table): The partial definition table. See the packages mentioned above for
    --          practical examples
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local orig_name_list = data_table.orig_name_list or {nil, nil}
    local def_table = data_table.def_table

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local full_name = "unilib:container_" .. part_name

    def_table.drawtype = "mesh"
    def_table.is_ground_content = false
--  def_table.legacy_facedir_simple = true
    def_table.paramtype = "light"
    def_table.paramtype2 = "facedir"
    def_table.visual = "mesh"

    def_table.after_place_node = function(pos, placer, itemstack, pointed_thing)

        if placer:is_player() then

            local pname = placer:get_player_name()
            local formspec = "size[6,4]" ..
                "image[1,0;1,1;unilib_container_present_christmas_card.png]" ..
                "label[2,0;" .. S("Christmas Card") .. "]" ..
                "field[1,2;5,1;xmas_msg;" .. S("Compose a message") .. ":;]" ..
                "button_exit[2,3;2,1;write;" .. S("Write") .. "]"

            xmas_card_table[pname] = pos
            core.show_formspec(pname, "unilib:form_shared_petz_chest_msg", formspec)

        end

    end

    def_table.can_dig = function(pos,player)

        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        return inv:is_empty("main")

    end

    def_table.on_blast = function(pos)

        local drop_list = {}

        unilib.misc.get_inventory_drops(pos, "main", drop_list)
        drop_list[#drop_list + 1] = full_name
        core.remove_node(pos)

        return drop_list

    end

    def_table.on_construct = function(pos)

        local meta = core.get_meta(pos)
        meta:set_string("infotext", def_table.description)
        local inv = meta:get_inventory()
        inv:set_size("main", 4 * 1)

    end

    --[[
    def_table.on_metadata_inventory_move = function(
        pos, from_list, from_index, to_list, to_index, count, player
    )
        unilib.utils.log(
            "action",
            player:get_player_name() .. " moves items in chest at " .. core.pos_to_string(pos)
        )

    end

    def_table.on_metadata_inventory_put = function(pos, listname, index, stack, player)

        unilib.utils.log(
            "action",
            player:get_player_name() .. " moves " .. stack:get_name() .. " to chest at " ..
                    core.pos_to_string(pos)
        )

    end

    def_table.on_metadata_inventory_take = function(pos, listname, index, stack, player)

        unilib.utils.log(
            "action",
            player:get_player_name() .. " takes " .. stack:get_name() .. " from chest at " ..
                    core.pos_to_string(pos)
        )

    end
    ]]--

    unilib.utils.set_inventory_action_loggers(def_table, "chest")

    def_table.on_rightclick = function(pos, node, clicker)

        core.sound_play(def_table.sound_open, {gain = 0.3, pos = pos, max_hear_distance = 10})

        if not chest_lid_obstructed(pos) then
            core.swap_node(pos, {name = full_name .. "_open", param2 = node.param2})
        end

        core.after(
            0.2,
            core.show_formspec,
            clicker:get_player_name(),
            "unilib:form_shared_petz_chest_default",
            get_formspec(pos)
        )

        open_chest_table[clicker:get_player_name()] =
                {pos = pos, sound = def_table.sound_close, swap = full_name}

    end

    local def_opened_table = table.copy(def_table)
    local def_closed_table = table.copy(def_table)

    def_opened_table.mesh = "unilib_chest_open.obj"
    for i = 1, #def_opened_table.tiles do

        if type(def_opened_table.tiles[i]) == "string" then
            def_opened_table.tiles[i] = {name = def_opened_table.tiles[i], backface_culling = true}
        elseif def_opened_table.tiles[i].backface_culling == nil then
            def_opened_table.tiles[i].backface_culling = true
        end

    end

    def_opened_table.drop = full_name
    def_opened_table.groups.not_in_creative_inventory = 1
    def_opened_table.selection_box = {
        type = "fixed",
        fixed = {-1/2, -1/2, -1/2, 1/2, 3/16, 1/2},
    }

    def_opened_table.can_dig = function()
        return false
    end

    def_opened_table.on_blast = function() end

    def_closed_table.mesh = nil
    def_closed_table.drawtype = nil
    -- Swap textures around for "normal" drawtype to make them match the mesh
    def_closed_table.tiles[6] = def_table.tiles[5]
    def_closed_table.tiles[5] = def_table.tiles[3]
    def_closed_table.tiles[3] = def_table.tiles[3] .. "^[transformFX"

    unilib.register_node(full_name, orig_name_list[1], replace_mode, def_closed_table)
    unilib.register_node(full_name .. "_open", orig_name_list[2], replace_mode, def_opened_table)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_petz_chests.init()

    return {
        description = "Shared functions for chests (from petz)",
    }

end

function unilib.pkg.shared_petz_chests.exec()

    core.register_on_leaveplayer(function(player)

        -- N.B. Two separate core.register_on_leaveplayer() calls in original code
        local pname = player:get_player_name()
        if open_chest_table[pname] then
            close_lid(pname)
        end

        xmas_card_table[player:get_player_name()] = nil

    end)

    core.register_on_player_receive_fields(function(player, formname, fields)

        if formname ~= "unilib:form_shared_petz_chest_default" then
            return
        end

        if not player or not fields.quit then
            return
        end

        local pname = player:get_player_name()
        if not open_chest_table[pname] then
            return
        end

        close_lid(pname)
        return true

    end)

    core.register_on_player_receive_fields(function(player, formname, fields)

        if formname ~= "unilib:form_shared_petz_chest_msg" then
            return
        end

        if not player or not fields.quit then
            return
        end

        local pos = xmas_card_table[player:get_player_name()]
        if pos and fields.xmas_msg then

            local meta = core.get_meta(pos)
            meta:set_string("xmas_msg", core.formspec_escape(fields.xmas_msg))

        end

        return true

    end)

end
