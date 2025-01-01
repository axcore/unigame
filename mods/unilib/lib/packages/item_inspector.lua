---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    replacer
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_inspector = {}

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end
local mode = unilib.global.imported_mod_table.replacer.add_mode

-- Some common groups, and nodes whose textures can be used to represent the groups. The table is
--      populated by the code below
local group_placeholder_table = {}

-- Image replacement tables. In the original code, used to add support for RealTest. unilib does not
--      support RealTest, so the table remains empty
local image_replacement_table = {}

---------------------------------------------------------------------------------------------------
-- Local functions (from replacer/inspect.lua)
---------------------------------------------------------------------------------------------------

local function insert_dye(part_name, mini_list)

    -- Adapted from code in inspect.lua itself
    -- The first item in "mini_list" is a dye type, e.g. "red"

    local colour = mini_list[1]
    local def_table = core.registered_items[part_name .. colour]
    if def_table and def_table.groups then

        for k, v in pairs(def_table.groups) do

            if k ~= "dye" then
                group_placeholder_table["group:dye," .. k] = "dye:" .. colour
            end

        end

        group_placeholder_table["group:flower,colour_" .. colour] = "dye:" .. colour

    end

end

local function get_image_button_link(stack_string)

    -- Was replacer.image_button_link()

    local group = ""
    if image_replacement_table[stack_string] then
        stack_string = image_replacement_table[stack_string]
    end

    if group_placeholder_table[stack_string] then

        stack_string = group_placeholder_table[stack_string]
        group = "G"

    end

    local stack = ItemStack(stack_string)
    local new_node_name = stack_string
    if stack and stack:get_name() then
        new_node_name = stack:get_name()
    end

    return tostring(stack_string) .. ";" .. tostring(new_node_name) .. ";" .. group

end

local function add_circular_saw_recipe(full_name, recipe_list)

    -- Was replacer.add_circular_saw_receipe()
    -- Adds a recipe to "recipe_list", in which .type is set to "saw" (for the original moreblocks
    --      circular saw), or "mark1" / "mark2" / "mark3" / "mark4" (for the saws in the
    --      "machine_saw_circular" package)
    -- The new recipe is handled in a special way by show_crafting()

    if not full_name then
        return
    end

    local mod_name, item_name = unilib.utils.split_name(full_name)

    if mod_name == "unilib" and
            unilib.global.pkg_executed_table["machine_saw_circular"] ~= nil and
            unilib.global.stair_deconvert_table[full_name] ~= nil then

        -- "full_name" is a stair node, but not necessarily one that can be cut by a circular saw,
        --      so we'll have to check for all possibilities
        for i, mini_list in ipairs(unilib.global.stair_ordered_table) do

            for _, suffix in ipairs(mini_list) do

                local saw_def_table =
                        core.registered_nodes["unilib:machine_saw_circular_mark" .. tostring(i)]

                -- e.g. suffix = "_stair_simple"
                if item_name:sub(-#suffix) == suffix and saw_def_table ~= nil then

                    -- Node found that can be created with this circular saw
                    recipe_list[#recipe_list + 1] = {
                        method = "saw",
                        type = "mark" .. tostring(i),
                        items = {unilib.global.stair_deconvert_table[full_name]},
                        output = full_name,
                    }

                    return recipe_list

                end

            end

        end

    end

    if not mod_name ~= "default " or not core.get_modpath("moreblocks") or not circular_saw or
            not circular_saw.names or full_name == "moreblocks:circular_saw" then
        return
    end

    local help_list = full_name:split(":")
    if not help_list or #help_list ~= 2 or help_list[1] == "stairs" then
        return
    end

    mini_help_list = help_list[2]:split("_")

    if not mini_help_list or #mini_help_list < 2 or (
        mini_help_list[1] ~= "micro" and mini_help_list[1] ~= "panel" and
        mini_help_list[1] ~= "stair" and mini_help_list[1] ~= "slab" and
        mini_help_list[1] ~= "slope"
    ) then
        return
    end

    help_list[1] = "default"
    local basic_node_name = help_list[1] .. ":" .. mini_help_list[2]

    -- Node found that fits into the saw
    recipe_list[#recipe_list + 1] = {
        method = "saw",
        type = "saw",
        items = {basic_node_name},
        output = full_name,
    }

    return recipe_list

end

local function add_colormachine_recipe(node_name, recipe_list)

    -- Was replacer.add_colormachine_receipe()

    if not core.get_modpath("colormachine") or not colormachine then
        return
    end

    local result = colormachine.get_node_name_painted(node_name, "")
    if not result or not result.possible or #result.possible < 1 then
        return
    end

    -- Paintable node found
    recipe_list[#recipe_list + 1] = {
        method = "colormachine",
        type = "colormachine",
        items = {result.possible[1]},
        output = node_name,
    }

    return recipe_list

end

local function show_crafting(name, node_name, fields)

    -- Was replacer.inspect_show_crafting()

    if not(name) then
        return
    end

    local recipe_nr = 1
    if not node_name then

        node_name = fields.node_name
        recipe_nr = tonumber(fields.recipe_nr)

    end

    -- Turn it into an item stack so that we can handle dropped stacks etc
    local stack = ItemStack(node_name)
    node_name = stack:get_name()

    -- The player may ask for recipes for the indigrents in the current recipe
    if fields then

        for k, v in pairs(fields) do

            if v and v == "" and (
                core.registered_items[k] or
                core.registered_nodes[k] or
                core.registered_craftitems[k] or
                core.registered_tools[k]
            ) then
                node_name = k
                recipe_nr = 1
            end

        end

    end

    local result = core.get_all_craft_recipes(node_name)
    if not result then
        result = {}
    end

    -- Add special recipes for nodes created by machines
    add_circular_saw_recipe(node_name, result)
    add_colormachine_recipe(node_name, result)

    -- Offer all alternate crafting recipes using prev/next buttons
    if fields and fields.prev_recipe and recipe_nr > 1 then
        recipe_nr = recipe_nr - 1
    elseif fields and fields.next_recipe and recipe_nr < #result then
        recipe_nr = recipe_nr + 1
    end

    local description = nil
    if core.registered_nodes[node_name] then

        if core.registered_nodes[node_name].description and
                core.registered_nodes[node_name].description ~= "" then
            description = "\"" .. core.registered_nodes[node_name].description .. "\" block"
        elseif core.registered_nodes[node_name].name then
            description = "\"" .. core.registered_nodes[node_name].name .. "\" block"
        else
            description = " - no description provided - block"
        end

    elseif core.registered_items[node_name] then

        if core.registered_items[node_name].description and
                core.registered_items[node_name].description~= "" then
            description = "\"" .. core.registered_items[node_name].description .. "\" item"
        elseif core.registered_items[node_name].name then
            description = "\"" .. core.registered_items[node_name].name .. "\" item"
        else
            description = " - no description provided - item"
        end

    end

    if not description or description == "" then
        description = " - no description provided - "
    end

    -- Formspec offsets for all items in the formspec, below the initial/final text
    local offset_x = 1.5
    local offset_y = 1.5

    --[[
    local formspec = "size[6,6]" ..
        "label[0,5.5;This is a " .. F(description) .. ".]" ..
        "button_exit[5.0,4.3;1,0.5;quit;Exit]" ..
        "label[0,0;Name:]" ..
        -- Invisible field for passing on information
        "field[20,20;0.1,0.1;node_name;node_name;" .. node_name .. "]" ..
        -- Another invisible field
        "field[21,21;0.1,0.1;recipe_nr;recipe_nr;" .. tostring(recipe_nr) .. "]" ..
        "label[1,0;" .. tostring(node_name) .. "]" ..
        "item_image_button[5,2;1.0,1.0;" .. tostring(node_name) .. ";normal;]"
    ]]--
    local formspec = "size[8,6]" ..
        -- Name
        "label[0,0;" .. FS("Name") .. ":]" ..
        -- (Invisible field for passing on information)
        "field[20,20;0.1,0.1;node_name;node_name;" .. F(node_name) .. "]" ..
        -- (Another invisible field)
        "field[21,21;0.1,0.1;recipe_nr;recipe_nr;" .. tostring(recipe_nr) .. "]" ..
        "label[1.5,0;" .. F(tostring(node_name)) .. "]" ..
        -- Description
        "label[0,0.3;" .. FS("Description") .. ":]" ..
        "label[1.5,0.3;" .. unilib.utils.get_first_line(F(description)) .. "]" ..
        -- Data/Protection
        "label[0,0.6;" .. FS("Data") .. ":]" ..
        "label[0,0.9;" .. FS("Protection") .. ":]" ..
        -- Exit button
        "button_exit[" .. tostring(2 + offset_x) .. "," .. tostring(3.3 + offset_y) ..
        ";1,0.5;quit;" .. FS("Exit") .. "]" ..
        -- Output
        "image[" .. tostring(3 + offset_x) .. "," .. tostring(1 + offset_y) ..
                ";1,1;unilib_gui_furnace_arrow_bg.png^[transformR270]" ..
        "item_image_button[" .. tostring(4 + offset_x) .. "," ..
        tostring(1 + offset_y) .. ";1.0,1.0;" .. tostring(node_name) .. ";normal;]"

    -- Provide additional information regarding the node that has been inspected
    --[[
    if fields.pos then

        formspec = formspec .. "label[0.0,0.3;Located at " .. F(core.pos_to_string(fields.pos))

        if fields.param2 then
            formspec = formspec .. " with param2=" .. tostring(fields.param2)
        end

        if fields.light then
            formspec = formspec .. " and receiving " .. tostring(fields.light) .. " light"
        end

        formspec = formspec .. ".]"

    end
    ]]--
    if fields.pos then

        formspec = formspec .. "label[1.5,0.6;Pos=" .. F(core.pos_to_string(fields.pos))

        if fields.param2 then
            formspec = formspec .. ", param2=" .. tostring(fields.param2)
        end

        if fields.light then
            formspec = formspec .. ", light=" .. tostring(fields.light)
        end

        formspec = formspec .. "]"

    else

        formspec = formspec .. "label[1.5,0.6;" .. FS("n/a") .. "]"

    end

    -- Show information about protection
    --[[
    if fields.protected_info and fields.protected_info ~= "" then

        formspec = formspec .. "label[0.0,4.5;" .. F(fields.protected_info) .. "]"

    end
    ]]--
    if fields.protected_info and fields.protected_info ~= "" then

        formspec = formspec .. "label[1.5,0.9;" .. F(fields.protected_info) .. "]"

    else

        formspec = formspec .. "label[1.5,0.9;" .. FS("n/a") .. "]"

    end

    -- Add optional buttons
    --[[
    if not result or recipe_nr > #result or recipe_nr < 1 then
        recipe_nr = 1
    end

    if result and recipe_nr > 1 then
        formspec = formspec .. "button[3.8,5;1,0.5;prev_recipe;prev]"
    end

    if result and recipe_nr < #result then
        formspec = formspec .. "button[5.0,5.0;1,0.5;next_recipe;next]"
    end
    ]]--
    if not result or recipe_nr > #result or recipe_nr < 1 then
        recipe_nr = 1
    end

    if result and recipe_nr > 1 then

        formspec = formspec .. "button[" .. tostring(0 + offset_x) .. "," ..
                tostring(3.3 + offset_y) .. ";1,0.5;prev_recipe;" .. FS("Prev") .. "]"

    end

    if result and recipe_nr < #result then

        formspec = formspec .. "button[" .. tostring(1 + offset_x) .. "," ..
                tostring(3.3 + offset_y) .. ";1,0.5;next_recipe;" .. FS("Next") .. "]"

    end

    if not result or #result < 1 then

--      formspec = formspec .. "label[3,1;No recipes.]"
        formspec = formspec .. "label[" .. tostring(4 + offset_x) .. "," ..
                    tostring(2.15 + offset_y) .. ";" .. FS("No recipes") .. "]"

        if core.registered_nodes[node_name] and core.registered_nodes[node_name].drop then

            local drop = core.registered_nodes[node_name].drop
            if drop then

                if type(drop) == "string" and drop ~= node_name then

--                  formspec = formspec .. "label[2,1.6;Drops on dig:]" ..
--                          "item_image_button[2,2;1.0,1.0;" .. get_image_button_link(drop) .. "]"
                    formspec = formspec .. "label[" .. offset_x .. "," .. offset_y ..
                            ";" .. FS("Drops on dig") .. ":]item_image_button[" .. offset_x ..
                            "," .. tostring(offset_y + 1) .. ";1.0,1.0;" ..
                            get_image_button_link(drop) .. "]"

                elseif type(drop) == "table" and drop.items then

                    local droplist = {}
                    for _, drops in ipairs(drop.items) do

                        for _, item in ipairs(drops.items) do

                            -- Avoid duplicates, but include the item itself
                            droplist[item] = 1

                        end

                    end

--                  local i = 1
--                  formspec = formspec .. "label[2,1.6;May drop on dig:]"
                    -- Maximum two rows of buttons
                    local i = 4
                    formspec = formspec .. "label[" .. offset_x .. "," .. offset_y ..
                            ";" .. FS("May drop on dig") .. ":]"

                    for k, v in pairs(droplist) do

--                      formspec = formspec .. "item_image_button[" .. (((i - 1) % 3) + 1) ..
--                              "," .. math.floor(((i - 1) / 3) + 2) .. ";1.0,1.0;" ..
--                              get_image_button_link(k) .. "]"
                        formspec = formspec .. "item_image_button[" .. (((i - 1) % 3) + offset_x) ..
                                "," .. math.floor(((i - 1) / 3) + offset_y) .. ";1.0,1.0;" ..
                                get_image_button_link(k) .. "]"

                        -- Maximum two rows of buttons
                        i = i + 1
                        if i > 6 then
                            break
                        end

                    end

                end

            end

        end

    else

--      formspec = formspec .. "label[1,5;Alternate " .. tostring(recipe_nr) .. "/" ..
--              tostring(#result) .. "]"
        formspec = formspec .. "label[" .. tostring(4 + offset_x) .. "," ..
                tostring(2.15 + offset_y) .. ";" .. FS("Recipe") .. " " .. tostring(recipe_nr) ..
                "/" .. tostring(#result) .. "]"

        -- Reverse order; default recipes (and thus the most relevant ones) are usually the oldest
        local recipe = result[#result + 1 - recipe_nr]
        if recipe.type == "normal" and recipe.items then

            local width = recipe.width
            if not width or width == 0 then
                width = 3
            end

            for i = 1, 9 do

                if recipe.items[i] then

--                  formspec = formspec .. "item_image_button[" .. (((i - 1) % width) + 1) ..
--                            ","  .. (math.floor((i - 1) / width) + 1) .. ";1.0,1.0;" ..
--                          get_image_button_link(recipe.items[i]) .. "]"
                    formspec = formspec .. "item_image_button[" .. (((i - 1) % width) + offset_x) ..
                            ","  .. (math.floor((i - 1) / width) + offset_y) .. ";1.0,1.0;" ..
                            get_image_button_link(recipe.items[i]) .. "]"

                end

            end

        elseif recipe.type == "cooking" and recipe.items and #recipe.items == 1 and
                recipe.output == "" then

--          formspec = formspec .. "item_image_button[1,1;3.4,3.4;" ..
--                  get_image_button_link("unilib:machine_furnace_ordinary_active") .. "]" ..
--                  "item_image_button[2.9,2.7;1.0,1.0;" ..
--                  get_image_button_link(recipe.items[1]) .. "]" ..
--                  "label[1.0,0;" .. tostring(recipe.items[1]) .. "]" ..
--                  "label[0,0.5;This can be used as a fuel.]"
--                  get_image_button_link(recipe.items[1]) .. "]"
            formspec = formspec .. "item_image_button[" ..
                    offset_x .. "," .. offset_y .. ";3,3;" ..
                    get_image_button_link("unilib:machine_furnace_ordinary_active") .. "]" ..
                    "item_image_button[" .. tostring(0.1 + offset_x) .. "," ..
                    tostring(0.1 + offset_y) .. ";1.25,1.25;" ..
                    get_image_button_link(recipe.items[1]) .. "]" ..
                    "label[0,5.6;" .. FS("This can be used as a fuel") .. "]"

        elseif recipe.type == "cooking" and recipe.items and #recipe.items == 1 then

--          formspec = formspec .. "item_image_button[1,1;3.4,3.4;" ..
--                  get_image_button_link("unilib:machine_furnace_ordinary") .. "]" ..
--                  "item_image_button[2.9,2.7;1.0,1.0;" ..
--                  get_image_button_link(recipe.items[1]) .. "]"
            formspec = formspec .. "item_image_button[" ..
                    offset_x .. "," .. offset_y .. ";3,3;" ..
                    get_image_button_link("unilib:machine_furnace_ordinary") .. "]" ..
                    "item_image_button[" .. tostring(0.1 + offset_x) .. "," ..
                    tostring(0.1 + offset_y) .. ";1.25,1.25;" ..
                    get_image_button_link(recipe.items[1]) .. "]"

        elseif recipe.type == "colormachine" and recipe.items and #recipe.items == 1 then

--          formspec = formspec .. "item_image_button[1,1;3.4,3.4;" ..
--                  get_image_button_link("colormachine:colormachine") .. "]" ..
--                  "item_image_button[2,2;1.0,1.0;" ..
--                  get_image_button_link(recipe.items[1]) .. "]"
            formspec = formspec .. "item_image_button[" ..
                    offset_x .. "," .. offset_y .. ";3,3;" ..
                    get_image_button_link("colormachine:colormachine") .. "]" ..
                    "item_image_button[" .. tostring(0.1 + offset_x) .. "," ..
                    tostring(0.1 + offset_y) .. ";1.25,1.25;" ..
                    get_image_button_link(recipe.items[1]) .. "]"

        elseif recipe.type == "saw" and recipe.items and #recipe.items == 1 then

--          formspec = formspec .. "item_image_button[1,1;3.4,3.4;" ..
--                  get_image_button_link("moreblocks:circular_saw") .. "]" ..
--                  "item_image_button[2,0.6;1.0,1.0;" ..
--                  get_image_button_link(recipe.items[1]) .. "]"
            formspec = formspec .. "item_image_button[" ..
                    offset_x .. "," .. offset_y .. ";3,3;" ..
                    get_image_button_link("moreblocks:circular_saw") .. "]" ..
                    "item_image_button[" .. tostring(0.1 + offset_x) .. "," ..
                    tostring(0.1 + offset_y) .. ";1.25,1.25;" ..
                    get_image_button_link(recipe.items[1]) .. "]"

        elseif recipe.method == "saw" and recipe.items and #recipe.items == 1 then

--          formspec = formspec .. "item_image_button[1,1;3.4,3.4;" ..
--                  get_image_button_link("unilib:machine_saw_circular_" .. recipe.type) .. "]" ..
--                  "item_image_button[2,0.6;1.0,1.0;" ..
--                  get_image_button_link(recipe.items[1]) .. "]"
            formspec = formspec .. "item_image_button[" ..
                    offset_x .. "," .. offset_y .. ";3,3;" ..
                    get_image_button_link("unilib:machine_saw_circular_" .. recipe.type) .. "]" ..
                    "item_image_button[" .. tostring(0.1 + offset_x) .. "," ..
                    tostring(0.1 + offset_y) .. ";1.25,1.25;" ..
                    get_image_button_link(recipe.items[1]) .. "]"

        else

--          formspec = formspec .. "label[3,1;Error: Unkown recipe.]"
            formspec = formspec .. "label[" .. offset_x .. "," .. tostring(1.5 + offset_y) ..
                    ";" .. FS("Error: Unknown recipe") .. "]"

        end

        -- Show how many of the items the recipe will yield
        --[[
        local outstack = ItemStack(recipe.output)
        if outstack and outstack:get_count() and outstack:get_count() > 1 then
            formspec = formspec .. "label[5.5,2.5;" .. tostring(outstack:get_count()) .. "]"
        end
        ]]--
        local outstack = ItemStack(recipe.output)
        if outstack and outstack:get_count() and outstack:get_count() > 1 then

            formspec = formspec .. "label[" .. tostring(4.05 + offset_x) .. "," ..
                    tostring(1.45 + offset_y) .. ";" .. tostring(outstack:get_count()) .. "]"

        end

    end

    core.show_formspec(name, "unilib:formspec_item_inspector", formspec)

end

local function form_input_handler(player, formname, fields)

    -- Was replacer.form_input_handler()
    -- Translate general formspec calls back to specific calls

    if formname and formname == "unilib:formspec_item_inspector" and player and not fields.quit then

        show_crafting(player:get_player_name(), nil, fields)
        return

    end

end

local function do_inspect(itemstack, user, pointed_thing, mode, show_recipe_flag)

    -- Was replacer.inspect()

    if user == nil or pointed_thing == nil then
        return nil
    end

    local name = user:get_player_name()
    local key_table = user:get_player_control()
    if key_table["sneak"] or key_table["aux1"] then
        show_recipe_flag = true
    end

    if pointed_thing.type == "object" then

        local text = "This is "
        local ref = pointed_thing.ref
        if not ref then

            text = text .. "a broken object. No further information about it is available." ..
                    " It is located"

        elseif ref:is_player() then

            text = text .. "your fellow player \"" .. tostring(ref:get_player_name()) .. "\""

        else

            local luaob = ref:get_luaentity()
            if luaob and luaob.get_staticdata then

                text = text .. "entity \"" .. tostring(luaob.name) .. "\""
                local sdata = luaob:get_staticdata()
                if sdata then

                    sdata = core.deserialize(sdata)
                    if sdata.itemstring then

                        text = text .. " [" .. tostring(sdata.itemstring) .. "]"
                        if show_recipe_flag then

                            -- The fields part is used here to provide additional information about
                            --      the entity
                            show_crafting(
                                name,
                                sdata.itemstring,
                                {pos = pos, luaob = luaob}
                            )

                        end

                    end

                    if sdata.age then

                        text = text .. ", dropped " .. tostring(math.floor(sdata.age / 60)) ..
                                " minutes ago"

                    end

                end

            else

                text = text .. "object \"" .. tostring(ref:get_entity_name()) .. "\""

            end

        end

        text = text .. " at " .. core.pos_to_string(ref:get_pos())
        core.chat_send_player(name, text)
        return nil

    elseif pointed_thing.type ~= "node" then

        core.chat_send_player(
            name,
            S(
                "Node inspection error: This is an unknown item of type '@1'." ..
                        " No information available.",
                tostring(pointed_thing.type)
            )
        )

        return nil

    end

    local pos = core.get_pointed_thing_position(pointed_thing, mode)
    local node = core.get_node_or_nil(pos)

    if node == nil then

        core.chat_send_player(
            name,
            S(
                "Node inspection error: Target node not yet loaded. Please wait a moment for the" ..
                        " server to catch up."
            )
        )

        return nil

    end

    local text = " [" .. tostring(node.name) .. "] with param2=" .. tostring(node.param2) ..
            " at " .. core.pos_to_string(pos) .. "."

    if not core.registered_nodes[node.name] then

        text = "This node is an UNKOWN block" .. text

    else

        text = "This is a \"" .. tostring(
            core.registered_nodes[node.name].description or " - no description provided -"
        ) .. "\" block" .. text

    end

    local protected_info = ""
    if core.is_protected(pos, name) then
        protected_info = "You can\'t dig this node. It is protected."
    elseif core.is_protected(pos, "_THIS_NAME_DOES_NOT_EXIST_") then
        protected_info = "You can dig this node, but others can\'t."
    end

    text = text .. " " .. protected_info

    if show_recipe_flag then

        -- Get node light
        local light = core.get_node_light(pos, nil)
        if light == 0 then
            light = core.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})
        end

        -- The fields part is used here to provide additional information about the node
        show_crafting(
            name,
            node.name,
            {pos = pos, param2 = node.param2, light = light, protected_info = protected_info}
        )

    end

    -- No item will be removed from inventory
    return nil

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_inspector.init()

    return {
        description = "Node inspection tool",
        notes = "Left-click any node, while wielding the tool, to open the formspec",
        depends = {"item_stick_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.item_inspector.exec()

    unilib.register_tool("unilib:item_inspector", "replacer:inspect", mode, {
        -- From replacer:inspect
        description = S("Node Inspection Tool"),
        inventory_image = "unilib_item_inspector.png",
        groups = {},

        -- It's OK to interact with water
        liquids_pointable = true,
        node_placement_prediction = nil,
        wield_image = "",
        wield_scale = {x = 1, y = 1, z = 1},

        on_place = function(itemstack, placer, pointed_thing)
           return do_inspect(itemstack, placer, pointed_thing, nil, true)
        end,

        on_use = function(itemstack, user, pointed_thing)
           return do_inspect(itemstack, user, pointed_thing, nil, true)
        end,
    })
    unilib.register_craft({
        -- From replacer:inspect
        output = "unilib:item_inspector",
        recipe = {
            {"unilib:torch_ordinary"},
            {"unilib:item_stick_ordinary"},
        },
    })

end

function unilib.pkg.item_inspector.post()

    -- Populate the group placeholder table. Note that some of these entries were not in the
    --      original mod code, but are nevertheless used by ../lib/system/final/final_compat_ui.lua

    --[[
    group_placeholder_table["group:wood"] = "default:wood"
    group_placeholder_table["group:tree"] = "default:tree"
    group_placeholder_table["group:sapling"]= "default:sapling"
    group_placeholder_table["group:stick"] = "default:stick"
    group_placeholder_table["group:stone"] = "default:cobble"
    group_placeholder_table["group:sand"] = "default:sand"
    group_placeholder_table["group:leaves"] = "default:leaves"
    group_placeholder_table["group:wood_slab"] = "stairs:slab_wood"
    group_placeholder_table["group:wool"] = "wool:white"
    ]]--

    if unilib.global.pkg_executed_table["stone_ordinary"] ~= nil then

        group_placeholder_table["group:stone"] = "unilib:stone_ordinary"
        group_placeholder_table["group:cobble"] = "unilib:stone_ordinary"

    end

    if unilib.global.pkg_executed_table["sand_ordinary"] ~= nil then
        group_placeholder_table["group:sand"] = "unilib:sand_ordinary"
    end

    if unilib.global.pkg_executed_table["tree_apple"] ~= nil then

        group_placeholder_table["group:tree"] = "unilib:tree_apple_trunk"
        group_placeholder_table["group:wood"] = "unilib:tree_apple_wood"
        group_placeholder_table["group:leaves"] = "unilib:tree_apple_leaves"
        group_placeholder_table["group:sapling"]= "unilib:tree_apple_sapling"

        group_placeholder_table["group:wood_stair_slab"] = "unilib:tree_apple_wood_stair_slab"

    end

    if unilib.global.pkg_executed_table["item_stick_ordinary"] ~= nil then
        group_placeholder_table["group:stick"] = "unilib:item_stick_ordinary"
    end

    if unilib.global.pkg_executed_table["wool_basic"] ~= nil then
        group_placeholder_table["group:wool"] = "wool:white"
    end

    if unilib.global.pkg_executed_table["item_book_ordinary"] ~= nil then
        group_placeholder_table["group:book"] = "unilib:item_book_ordinary"
    end

    if unilib.global.pkg_executed_table["vessel_bottle_glass_empty"] ~= nil then
        group_placeholder_table["group:vessel"] = "unilib:vessel_bottle_glass_empty"
    end

    -- Update group placeholders to unilib dyes or, if none are available, the original
    --      minetest_game dyes
    --[[
    if core.get_modpath("dye") and dye and dye.basecolors then

        for i, colour in ipairs(dye.basecolors) do

            local def_table = core.registered_items["dye:" .. colour]
            if def_table and def_table.groups then

                for k, v in pairs(def_table.groups) do

                    if k ~= "dye" then
                        group_placeholder_table["group:dye," .. k] = "dye:" .. colour
                    end

                end

                group_placeholder_table["group:flower,color_" .. colour] = "dye:" .. colour

            end

        end

    end
    ]]--
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        for i, mini_list in pairs(unilib.pkg.dye_basic.dye_list) do
            insert_dye("unilib:dye_", mini_list)
        end

    elseif core.get_modpath("dye") and dye and dye.dyes then

        for i, mini_list in ipairs(dye.dyes) do
            insert_dye("dye:", mini_list)
        end

    end

    -- Establish a callback so that input from the player-specific formspec gets handled
    core.register_on_player_receive_fields(form_input_handler)

end
