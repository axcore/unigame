---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_replacer_artisanal = {}

local S = unilib.intllib
local FS = function(...) return core.formspec_escape(S(...)) end
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function initialise_metadata(meta, pname)

    -- Initialise metadata
    meta:set_string("preserve_rotation", "false")
    -- If true, place nodes on left click (and "replace_mode" will be false)
    meta:set_string("place_mode", "false")
    -- If true, replace nodes on left click (and "place_mode" will be false)
    meta:set_string("replace_mode", "true")
    -- The replacement node inventory is a string with each node name listed (multiple times, if
    --      necessary), and separated by whitespace. (Note that setting a metadata value to an
    --      empty string removes the key-value pair altogether)
--  meta:set_string("nri", "")

end

local function create_detached_inventory(meta, pname)

    -- On first use, and after every server restart, create the detached inventory that specifies
    --       which replacement nodes are used, and how often
    -- That detached inventory is reset every time the formspec is open, using our actual list of
    --      replacement nodes, which we store in the tool's metadata

    local detached_inv = core.create_detached_inventory(
        "item_replacer_artisanal_" .. pname,
        {
            allow_move = function()

                -- Moving nodes within the replacement node inventory is accetapble
                return count

            end,

            allow_put = function(inv, listname, index, stack, player)

                -- Refuse the move, but create a copy of the itemstack in the detached inventory.
                --      The copy stops existing if the player removes it from that same inventory
                local full_name = stack:get_name()

                -- (Only nodes can be added to the replacement node inventory)
                if core.registered_nodes[full_name] ~= nil then

                    local copy_stack = ItemStack(full_name .. " " .. stack:get_count())
                    inv:add_item("main", copy_stack)

                end

                return 0

            end,

            allow_take = function(inv, listname, index, stack, player)

                -- Refuse the move, but remove the itemstack from the replacement node inventory
                local full_name = stack:get_name()
                local copy_stack = ItemStack(full_name .. " " .. stack:get_count())
                inv:remove_item("main", copy_stack)

                return 0

            end,
        },
        pname
    )

    detached_inv:set_size("main", 8)

end

local function repopulate_detached_inventory(meta, pname)

    -- Empty the current detached inventory
    local inv = core.get_inventory({
        type = "detached", name = "item_replacer_artisanal_" .. pname,
    })
    inv:set_list("main", {})

    -- The real node replacement inventory is stored in metadata as a string, with node names
    --      separated by whitespace
    local nri_list = unilib.utils.split_string_by_whitespace(meta:get_string("nri"))
    local nri_table = {}
    local no_duplicate_list = {}

    -- Compile a frequency table
    for _, full_name in ipairs(nri_list) do

        if nri_table[full_name] == nil then

            nri_table[full_name] = 1
            table.insert(no_duplicate_list, full_name)

        else

            nri_table[full_name] = nri_table[full_name] + 1

        end

    end

    -- Repopulate the list
    for _, full_name in pairs(no_duplicate_list) do
        inv:add_item("main", ItemStack(full_name .. " " .. nri_table[full_name]))
    end

end

local function get_formspec(meta, pname)

    -- Metadata should already be initialised, but we'll check anyway
    if not meta:contains("preserve_rotation") then
        initialise_metadata(meta, pname)
    end

    -- The detached inventory doesn't survive a server restart
    local inv = core.get_inventory({
        type = "detached", name = "item_replacer_artisanal_" .. pname,
    })

    if inv == nil then
        create_detached_inventory(meta, pname)
    end

    -- The detached inventory is repopulated from metadata, every time this formspec is opened
    repopulate_detached_inventory(meta, pname)

    return "size[8,7.2]" ..
        "label[2,0;" .. FS("Artisanal Node Replacement Tool") .. "]" ..
        "checkbox[5.3,0.475;place_mode;" .. FS("Place nodes") .. ";" ..
                meta:get_string("place_mode") .. "]" ..
        "checkbox[5.3,0.975;replace_mode;" .. FS("Replace nodes") .. ";" ..
                meta:get_string("replace_mode") .. "]" ..
        "checkbox[5.3,1.675;preserve_rotation;" .. FS("Preserve rotation") .. ";" ..
                meta:get_string("preserve_rotation") .. "]" ..
        "list[detached:item_replacer_artisanal_" .. pname .. ";main;1,0.7;4,2;]" ..
        "list[current_player;main;0,3.05;8,1;]" ..
        "list[current_player;main;0,4.28;8,3;8]" ..
        "listring[current_player;main]" ..
        "listring[context;main]"

end

local function do_replace(itemstack, user, pointed_thing)

    -- Handle left-clicks while wielding the tool, which replaces the pointed node with one from
    --      the player's inventory, depending on the probabilities specified by the replacement
    --      node inventory

    if user == nil or pointed_thing == nil then
        return nil
    end

    local pname = user:get_player_name()
    if pointed_thing.type ~= "node" then

       core.chat_send_player(pname, S("Node replacement error: No node"))
       return nil

    end

    local meta = itemstack:get_meta()
    local pos
    if meta:get_string("place_mode") == "true" then
        pos = core.get_pointed_thing_position(pointed_thing, 0)
    else
        pos = core.get_pointed_thing_position(pointed_thing, false)
    end

    local target_node = core.get_node_or_nil(pos)
    if target_node == nil then

        core.chat_send_player(
            pname,
            S(
                "Node replacement error: Target node not yet loaded. Please wait a moment for" ..
                " the server to catch up."
            )
        )

        return nil

    end

    -- If someone else owns the node then we can't change it
    if unilib.pkg.shared_replacer.is_owned(pos, user) then
        return nil
    end

    -- Check the blacklist (we check it a second time, for the replacement node, further below)
    if target_node.name and
            target_node.name ~= "" and
            unilib.pkg.shared_replacer.blacklist_table[target_node.name] then

        core.chat_send_player(
            pname,
            S(
                "Node replacement error: Replacing blocks of the type \"@1\" is not allowed" ..
                        " on this server. Replacement failed.",
                (target_node.name or "?")
            )
        )

        return nil

    end

    -- If the user has not added anything to the node replacement inventory, prompt them to do so
    if not meta:contains("nri") then

        core.chat_send_player(
            pname,
            S(
                "Node replacement error: While wielding this tool, right-click to choose some" ..
                        " replacement nodes."
            )
        )

        return nil

    end

    -- Compile a list of nodes currently in the node replacement inventory, and which are available
    --      to be placed in the world (because they're also in the player's "main" inventory)
    local inv = core.get_inventory({type = "player", name = pname})
    local nri_list = unilib.utils.split_string_by_whitespace(meta:get_string("nri"))
    local available_list = {}

    for _, full_name in ipairs(nri_list) do

        if inv:contains_item("main", full_name) then
            table.insert(available_list, full_name)
        end

    end

    if #available_list == 0 then

        core.chat_send_player(pname, S("Node replacement error: You have run out of nodes!"))
        return nil

    end

    -- Choose a replacement node at random, and check the blacklist again
    local replace_name = available_list[math.random(1, #available_list)]
    if target_node.name == replace_name then

        -- Don't swap identical nodes
        return nil

    elseif unilib.pkg.shared_replacer.blacklist_table[replace_name] then

        core.chat_send_player(
            pname,
            S(
                "Node replacement error: Placing blocks of the type \"@1\" with the replacer" ..
                        " is not allowed on this server. Replacement failed.",
                (replace_name or "?")
            )
        )

        return nil

    end

    -- In survival mode, the player has to provide the node he wants to place
    if not unilib.utils.is_creative(name) then

        -- Give the player the item by simulating digging if possible
        if target_node.name ~= "air" and target_node.name ~= "ignore" then

            core.node_dig(pos, target_node, user)

            local dug_node = core.get_node_or_nil(pos)
            if not dug_node or dug_node.name == target_node.name then

                -- Some nodes - like liquids - cannot be dug, but they are buildable_to and
                --      thus can be replaced
                local def_table = core.registered_nodes[target_node.name]
                if def_table == nil or not def_table.buildable_to then

                    core.chat_send_player(
                        pname,
                        S(
                            "Node replacement error: Replacing \"@1\" with \"@2\" failed. Unable" ..
                                    " to remove old node.",
                            (target_node.name or "air"),
                            (replace_name or "?")
                        )
                    )

                    return nil

                end

            end

       end

       -- Consume the item
       inv:remove_item("main", replace_name .. " 1")

    end

    -- Replace the item
    if meta:get_string("preserve_rotation") ~= "true" then

        core.add_node(pos, {name = replace_name})

    else

        core.add_node(
            pos, {name = replace_name, param1 = target_node.param1, param2 = target_node.param2}
        )

    end

    -- No item will be removed from the player's "main" inventory
    return nil

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_replacer_artisanal.init()

    return {
        description = "Artisanal node replacement tool",
        notes = "A modified version of the \"normal\" tool, which places the same node again and" ..
                " again; this tool places a random node from a selection. It's intended for" ..
                " creating interesting paths and walls, for example by randomly placing both" ..
                " smoothstone and cobble in an area. To set up the tool, wield it and then" ..
                " right-click. Drag one or more nodes from your inventory into the grid at the" ..
                " top. The grid represents the probability of each node being placed. If you" ..
                " drag one smoothstone and one cobblestone, they each have an equal chance of" ..
                " being placed every time the tool is used; but if you drag three smoothstones" ..
                " and one cobblestone, then there's only a 25% chance that the cobblestone will" ..
                " be placed. When the formspec is open, you can switch between placing a node" ..
                " next to the one you've clicked, or replacing the node you've clicked" ..
                " altogether. (This is a bit different from the \"normal\" tool, which uses both" ..
                " left- and right-clicks for those purposes.)",
        depends = {"container_chest_ordinary", "item_stick_ordinary", "shared_replacer"},
    }

end

function unilib.pkg.item_replacer_artisanal.exec()

    unilib.register_tool("unilib:item_replacer_artisanal", nil, mode, {
        -- Original to unilib
        description = S("Artisanal Node Replacement Tool"),
        inventory_image = "unilib_item_replacer_artisanal.png",
        groups = {},
        -- (no sounds)

        node_placement_prediction = nil,
        -- The replacer must store information, so only one can be stacked
        stack_max = 1,
        wield_image = "",
        wield_scale = {x = 1, y = 1, z = 1},

        on_place = function(itemstack, placer, pointed_thing)

            local meta = itemstack:get_meta()
            local pname = placer:get_player_name()

            if not meta:contains("preserve_rotation") then

                initialise_metadata(meta, pname)

                -- This line is required to preserve metadata
                placer:set_wielded_item(itemstack)

            end

            -- Handle right-clicks while wielding the tool, which opens the formspec
            core.show_formspec(
                pname,
                "unilib:formspec_item_replacer_artisanal",
                get_formspec(meta, pname)
            )

        end,

        on_use = function(itemstack, user, pointed_thing)
            return do_replace(itemstack, user, pointed_thing)
        end,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:item_replacer_artisanal",
        recipe = {
            {"unilib:container_chest_ordinary_locked", "", ""},
            {"", "unilib:item_stick_ordinary", ""},
            {"", "", "unilib:container_chest_ordinary_locked"},
        },
    })

    core.register_on_player_receive_fields(function(player, formname, fields)

        local itemstack = player:get_wielded_item()
        local meta = itemstack:get_meta()

        -- The player has interacted with our formspec
        if not formname or
                formname ~= "unilib:formspec_item_replacer_artisanal" or
                not fields then
            return false
        end

        if fields.preserve_rotation then

            meta:set_string("preserve_rotation", fields.preserve_rotation)

            -- This line is required to preserve metadata
            player:set_wielded_item(itemstack)

        elseif fields.place_mode then

            meta:set_string("place_mode", fields.place_mode)
            if fields.place_mode == "true" then
                meta:set_string("replace_mode", "false")
            else
                meta:set_string("replace_mode", "true")
            end

        elseif fields.replace_mode then

            meta:set_string("replace_mode", fields.replace_mode)
            if fields.replace_mode == "true" then
                meta:set_string("place_mode", "false")
            else
                meta:set_string("place_mode", "true")
            end

        end

        -- Update the replacement node inventory (the metadata value "nri") using the contents of
        --      the detached inventory
        local pname = player:get_player_name()
        local inv = core.get_inventory({
            type = "detached", name = "item_replacer_artisanal_" .. pname,
        })

        local nri_list = {}
        local stack_list = inv:get_list("main")

        for _, stack in ipairs(stack_list) do

            local full_name = stack:get_name()
            local total = stack:get_count()
            if total > 0 then

                for i = 1, total do
                    table.insert(nri_list, full_name)
                end

            end

        end

        meta:set_string("nri", table.concat(nri_list, " "))

        -- This line is required to preserve metadata
        player:set_wielded_item(itemstack)

        -- (Selecting one checkbox deselects the other; redraw the formspec to make that visible)
        if not fields.quit and (fields.place_mode or fields.replace_mode) then

            if not fields.quit then

                core.show_formspec(
                    pname,
                    "unilib:formspec_item_replacer_artisanal",
                    get_formspec(meta, pname)
                )

            end

        end

        -- All done
        return true

    end)

end
