---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- misc_edit_formspec.lua
--      Adds a tab to unilib's remix editing formspec
---------------------------------------------------------------------------------------------------

local S = unimobs.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

local warning_formname = "unilib:form_system_gui_warning"

local mob_type_msg = FS("Select a mob type")
local mob_type_tooltip = FS("Mob type, e.g. \"cat_normal\"")
-- A copy of unimobs.petz_global.mob_list, but sorted alphabetically (and re-populated every time
--      the formspec is opened)
local mob_type_list = {}

---------------------------------------------------------------------------------------------------
-- Local functions (misc)
---------------------------------------------------------------------------------------------------

local function check_package_content(content)

    -- Is the "meta_petz_settings" package already added to the Packages tab?
    for line in content:gmatch("[^\n]*") do

        if line:match("^meta_petz_settings%s*$") or
                line:match("^meta_petz_settings[ |]") then
            return true
        end

    end

    -- It's not already added
    return false

end

local function check_label_content(content)

    -- Is the "petz" label already added to the Labels tab?
    for line in content:gmatch("[^\n]*") do

        if line:match("^petz%s*$") then
            return true
        end

    end

    -- It's not already added
    return false

end

local function store_mob_fields(tab_type, fields)

    local data_table = unilib.gui.get_tab_data_from_edit_formspec(tab_type)

    if fields.disable_spawn_btn ~= nil then

        if fields.disable_spawn_btn == "true" then
            data_table["disable_spawn_flag"] = true
        else
            data_table["disable_spawn_flag"] = false
        end

    end

    data_table["spawn_prob"] = unilib.utils.strip_whitespace(fields.spawn_prob_field)
    data_table["spawn_node"] = unilib.utils.strip_whitespace(fields.spawn_node_field)
    data_table["spawn_biome"] = unilib.utils.strip_whitespace(fields.spawn_biome_field)
    data_table["max_height"] = unilib.utils.strip_whitespace(fields.max_height_field)
    data_table["min_height"] = unilib.utils.strip_whitespace(fields.min_height_field)
    data_table["herd_size"] = unilib.utils.strip_whitespace(fields.herd_size_field)
    data_table["predator"] = unilib.utils.strip_whitespace(fields.predator_field)
    data_table["prey"] = unilib.utils.strip_whitespace(fields.prey_field)
    data_table["repel_item"] = unilib.utils.strip_whitespace(fields.repel_item_field)
    data_table["follow_item"] = unilib.utils.strip_whitespace(fields.follow_item_field)
    data_table["feed_item"] = unilib.utils.strip_whitespace(fields.feed_item_field)
    data_table["tame_count"] = unilib.utils.strip_whitespace(fields.tame_count_field)
    data_table["breed_item"] = unilib.utils.strip_whitespace(fields.breed_item_field)
    data_table["breed_distance"] = unilib.utils.strip_whitespace(fields.breed_distance_field)
    data_table["convert_with"] = unilib.utils.strip_whitespace(fields.convert_with_field)
    data_table["convert_to"] = unilib.utils.strip_whitespace(fields.convert_to_field)
    data_table["convert_count"] = unilib.utils.strip_whitespace(fields.convert_count_field)
    data_table["harmful_node"] = unilib.utils.strip_whitespace(fields.harmful_node_field)
    data_table["custom_str"] = unilib.utils.strip_whitespace(fields.custom_str_field)

    unilib.gui.set_tab_data_for_edit_formspec(tab_type, data_table)

end

local function update_package_and_label_content()

    -- Add the "meta_petz_settings" package to the Packages tab, if it's not already there
    -- (Note that, in the earlier call to warning_check_callback(), we have already checked that
    --      "package_data_table" is not nil
    local package_data_table = unilib.gui.get_tab_data_from_edit_formspec("package")
    local package_content = package_data_table.content or ""

    if not check_package_content(package_content) then

        if package_content ~= "" then
            package_content = package_content .. "\n"
        end

        package_data_table.content = package_content .. "meta_petz_settings|unilib"
        unilib.gui.set_tab_data_for_edit_formspec("package", package_data_table)

    end

    -- Add the "petz" label to the Labels tab, if it's not already there
    local label_data_table = unilib.gui.get_tab_data_from_edit_formspec("label")
    local label_content = label_data_table.content or ""

    if not check_label_content(label_content) then

        if label_content ~= "" then
            label_content = label_content .. "\n"
        end

        label_data_table.content = label_content .. "petz"
        unilib.gui.set_tab_data_for_edit_formspec("label", label_data_table)

    end

end

---------------------------------------------------------------------------------------------------
-- Local functions (callbacks)
---------------------------------------------------------------------------------------------------

local function convert_mob_text(tab_type, fields)

    local data_table = unilib.gui.get_tab_data_from_edit_formspec(tab_type)
    local convert_list = unilib.utils.split_string_by_separator(fields.main_convert_field)

    data_table["mob_type"] = convert_list[1] or ""

    if convert_list[2] == "true" then
        data_table["disable_spawn_flag"] = true
    end

    data_table["spawn_prob"] = convert_list[3] or ""
    data_table["spawn_node"] = convert_list[4] or ""
    data_table["spawn_biome"] = convert_list[5] or ""
    data_table["max_height"] = convert_list[6] or ""
    data_table["min_height"] = convert_list[7] or ""
    data_table["herd_size"] = convert_list[8] or ""
    data_table["predator"] = convert_list[9] or ""
    data_table["prey"] = convert_list[10] or ""
    data_table["repel_item"] = convert_list[11] or ""
    data_table["follow_item"] = convert_list[12] or ""
    data_table["feed_item"] = convert_list[13] or ""
    data_table["tame_count"] = convert_list[14] or ""
    data_table["breed_item"] = convert_list[15] or ""
    data_table["breed_distance"] = convert_list[16] or ""
    data_table["convert_with"] = convert_list[17] or ""
    data_table["convert_to"] = convert_list[18] or ""
    data_table["convert_count"] = convert_list[19] or ""
    data_table["harmful_node"] = convert_list[20] or ""
    data_table["custom_str"] = convert_list[21] or ""

    unilib.gui.set_tab_data_for_edit_formspec(tab_type, data_table)

end

local function init_mob_data(remix_name, tab_type)

    -- Called to initialise the "Decorations" tab

    local data_table = unilib.gui.get_tab_data_from_edit_formspec(tab_type)

    data_table["mob_type_index"] = 1
    data_table["disable_spawn_flag"] = false
    data_table["disable_spawn_mode"] = "boolean"

    unilib.gui.set_tab_data_for_edit_formspec(tab_type, data_table)

end

local function get_mob_formspec_section(tab_type)

    local data_table = unilib.gui.get_tab_data_from_edit_formspec(tab_type)
    local remix_name = unilib.gui.get_remix_for_edit_formspec()

    -- The global list is not necessarily in alphabetical order
    mob_type_list = unilib.utils.clone_simple_table(unimobs.petz_global.mob_list)
    table.sort(mob_type_list)

    local formspec =
        "label[1.2,0.2;" .. FS("Add mobs to remix \"@1\"", remix_name) .. "]" ..
        "field[0.3,4.2;3.6,1;mob_type_field;" .. FS("Mob type") .. ";" ..
            (data_table["mob_type"] or "") .. "]" ..
        "field_close_on_enter[mob_type_field;false]" ..
        "tooltip[mob_type_field;" .. mob_type_tooltip .. "]"

    if not unilib.utils.is_table_empty(mob_type_list) then

        formspec = formspec ..
            "dropdown[3.5,4;3.8;mob_type_dbox;" ..
                mob_type_msg .. "," ..
                table.concat(mob_type_list, ",") .. ";" ..
                data_table["mob_type_index"] .. ";true]"

    end

    formspec = formspec ..
        "tooltip[mob_type_dbox;" .. mob_type_tooltip .. "]" ..
        "image_button[7.1,4;0.8,0.8;unilib_gui_insert.png;mob_insert_btn;;;]" ..
        "tooltip[mob_insert_btn;" .. unilib.gui.insert_constants_msg .. "]" ..
        "image_button[7.8,4;0.8,0.8;unilib_gui_unsearch.png;mob_clear_btn;;;]" ..
        "tooltip[mob_clear_btn;" .. unilib.gui.empty_fields_msg .. "]" ..
        "button[8.5,3.9;1.5,1;mob_add_btn;" .. FS("Add") .. "]" ..
        "tooltip[mob_add_btn;" .. FS("Add mob to the list above") .. "]"

    -- N.B. Avoid "chunk has too many syntax levels" error
    formspec = formspec ..
        "checkbox[0,4.95;disable_spawn_btn;" .. FS("Disable spawn") .. ";" ..
            tostring(data_table["disable_spawn_flag"]) .. "]" ..
        "tooltip[disable_spawn_btn;" .. FS("Enable to prevent new mobs spawning") .. "]" ..
        "field[2.5,5.3;1.4,1;spawn_prob_field;" .. FS("Probability") .. ";" ..
            (data_table["spawn_prob"] or "") .. "]" ..
        "field_close_on_enter[spawn_prob_field;false]" ..
        "tooltip[spawn_prob_field;" .. FS("Spawn probability, e.g. 1, 0.6, 0.2") .. "]" ..
        "field[3.8,5.3;3.3,1;spawn_node_field;" .. FS("Spawn node") .. ";" ..
            (data_table["spawn_node"] or "") .. "]" ..
        "field_close_on_enter[spawn_node_field;false]" ..
        "tooltip[spawn_node_field;" .. FS("Mob spawns on these node(s)") .. "]" ..
        "field[7,5.3;3.3,1;spawn_biome_field;" .. FS("Spawn biome") .. ";" ..
            (data_table["spawn_biome"] or "") .. "]" ..
        "field_close_on_enter[spawn_biome_field;false]" ..
        "tooltip[spawn_biome_field;" .. FS("Mob spawns in these biome(s)") .. "]" ..
        "field[0.3,6.4;1.5,1;max_height_field;" .. FS("Max height") .. ";" ..
            (data_table["max_height"] or "") .. "]" ..
        "field_close_on_enter[max_height_field;false]" ..
        "tooltip[max_height_field;" .. FS("Maximum height for spawning") .. "]" ..
        "field[1.7,6.4;1.5,1;min_height_field;" .. FS("Min height") .. ";" ..
            (data_table["min_height"] or "") .. "]" ..
        "field_close_on_enter[min_height_field;false]" ..
        "tooltip[min_height_field;" .. FS("Minimum height for spawning") .. "]" ..
        "field[3.1,6.4;1.5,1;herd_size_field;" .. FS("Herd size") .. ";" ..
            (data_table["herd_size"] or "") .. "]" ..
        "field_close_on_enter[herd_size_field;false]" ..
        "tooltip[herd_size_field;" .. FS("Maximum size of spawned herd") .. "]" ..
        "field[4.5,6.4;3,1;predator_field;" .. FS("Predators") .. ";" ..
            (data_table["predator"] or "") .. "]" ..
        "field_close_on_enter[predator_field;false]" ..
        "tooltip[predator_field;" .. FS("Mob types that are predators") .. "]" ..
        "field[7.4,6.4;2.9,1;prey_field;" .. FS("Prey") .. ";" ..
            (data_table["prey"] or "") .. "]" ..
        "field_close_on_enter[prey_field;false]" ..
        "tooltip[prey_field;" .. FS("Mob types that are prey") .. "]" ..
        "field[0.3,7.5;3,1;repel_item_field;" .. FS("Repelled by") .. ";" ..
            (data_table["repel_item"] or "") .. "]" ..
        "field_close_on_enter[repel_item_field;false]" ..
        "tooltip[repel_item_field;" .. FS("Item(s) that repel this mob") .. "]" ..
        "field[3.2,7.5;3,1;follow_item_field;" .. FS("Follows") .. ";" ..
            (data_table["follow_item"] or "") .. "]" ..
        "field_close_on_enter[follow_item_field;false]" ..
        "tooltip[follow_item_field;" .. FS("Item(s) that attract this mob") .. "]" ..
        "field[6.1,7.5;3,1;feed_item_field;" .. FS("Feed with") .. ";" ..
            (data_table["feed_item"] or "") .. "]" ..
        "field_close_on_enter[feed_item_field;false]" ..
        "tooltip[feed_item_field;" .. FS("Item(s) used to feed this mob") .. "]" ..
        "field[9,7.5;1.3,1;tame_count_field;" .. FS("Tame #") .. ";" ..
            (data_table["tame_count"] or "") .. "]" ..
        "field_close_on_enter[tame_count_field;false]" ..
        "tooltip[tame_count_field;" .. FS("Tame the mob with this many items") .. "]" ..
        "field[0.3,8.6;3,1;breed_item_field;" .. FS("Breed with") .. ";" ..
            (data_table["breed_item"] or "") .. "]" ..
        "field_close_on_enter[breed_item_field;false]" ..
        "tooltip[breed_item_field;" .. FS("Item(s) for breeding this mob") .. "]" ..
        "field[3.2,8.6;1.2,1;breed_distance_field;" .. FS("Distance") .. ";" ..
            (data_table["breed_distance"] or "") .. "]" ..
        "field_close_on_enter[breed_distance_field;false]" ..
        "tooltip[breed_distance_field;" ..
            FS("Maximum distance between breeding mobs, e.g. 1") .. "]" ..
        "field[4.3,8.6;2.9,1;convert_with_field;" .. FS("Convert with") .. ";" ..
            (data_table["convert_with"] or "") .. "]" ..
        "field_close_on_enter[convert_with_field;false]" ..
        "tooltip[convert_with_field;" .. FS("Item(s) used to convert this mob") .. "]" ..
        "field[7.1,8.6;2,1;convert_to_field;" .. FS("Converts to") .. ";" ..
            (data_table["convert_to"] or "") .. "]" ..
        "field_close_on_enter[convert_to_field;false]" ..
        "tooltip[convert_to_field;" .. FS("Mob type of converted mob") .. "]" ..
        "field[9,8.6;1.3,1;convert_count_field;" .. FS("Convert #") .. ";" ..
            (data_table["convert_count"] or "") .. "]" ..
        "field_close_on_enter[convert_count_field;false]" ..
        "tooltip[convert_count_field;" .. FS("Convert the mob with this many items") .. "]" ..
        "field[0.3,9.7;3,1;harmful_node_field;" .. FS("Harmful nodes") .. ";" ..
            (data_table["harmful_node"] or "") .. "]" ..
        "field_close_on_enter[harmful_node_field;false]" ..
        "tooltip[harmful_node_field;" .. FS("Nodes that damage the mob") .. "]" ..
        "field[3.2,9.7;7.1,1;custom_str_field;" .. FS("Custom mob settings") .. ";" ..
            (data_table["custom_str"] or "") .. "]" ..
        "field_close_on_enter[custom_str_field;false]" ..
        "tooltip[custom_str_field;" ..
            FS("See documentation for more details") .. "]"

    return formspec

end

local function respond_to_mob_formspec(pname, tab_type, fields)

    local defn_table = unilib.gui.get_tab_defn_from_edit_formspec(tab_type)
    local data_table = unilib.gui.get_tab_data_from_edit_formspec(tab_type)
    local prop_list = defn_table["prop_list"]

    if fields.mob_clear_btn then

        for _, prop in ipairs(prop_list) do
            data_table[prop] = nil
        end

    elseif fields.mob_type_dbox and fields.mob_type_dbox ~= "1" then

        -- N.B. The first item in the dropbox is the message specified by "mob_type_msg"
        local mob_type_index = tonumber(fields.mob_type_dbox)
        if mob_type_index > 1 then
            data_table["mob_type"] = mob_type_list[mob_type_index - 1]
        end

    else

        local mob_type = unilib.utils.strip_whitespace(fields.mob_type_field)

        store_mob_fields(tab_type, fields)

        if fields.mob_insert_btn then

            -- When using the insert button, don't overwrite the "Mob type" field
            data_table["mob_type"] = mob_type
            -- When the "Disable spawn" button is enabled, use a standard constant rather than a
            --      literal "true" value
            data_table["disable_spawn_mode"] = "constant"

            for _, prop in ipairs(prop_list) do

                if data_table[prop] == nil or data_table[prop] == "" then
                    data_table[prop] = defn_table["constant_table"][prop]
                end

            end

        elseif (
            fields.mob_add_btn or
            (fields.key_enter_field and fields.key_enter_field == "mob_type_field")
        ) and mob_type ~= "" then

            -- When text is sent to the main notepad, empty the "Mob type" field
            data_table["mob_type"] = ""

            -- Prepare the "disable spawn" field
            local disable_str = ""
            if data_table["disable_spawn_flag"] == true then

                if data_table["disable_spawn_mode"] == "constant" then
                    disable_str = "DISABLE_SPAWN"
                else
                    disable_str = "true"
                end

            end

            -- mob_type | disable_spawn_flag | custom_spawn_probability | spawn_node_str | spawn_biome_str | spawn_max_height | spawn_min_height | spawn_herd_size | predator_str | prey_str | repel_item_str | follow_item_str | feed_item_str | custom_tame_count | breed_item_str | max_mating_distance | convert_with_str | convert_to | custom_convert_count | harmful_node_str | custom_str | check
            unilib.gui.update_notepad_in_edit_formspec(
                fields.main_notepad,
                    mob_type ..
                    "|" .. disable_str ..
                    "|" .. data_table["spawn_prob"] ..
                    "|" .. data_table["spawn_node"] ..
                    "|" .. data_table["spawn_biome"] ..
                    "|" .. data_table["max_height"] ..
                    "|" .. data_table["min_height"] ..
                    "|" .. data_table["herd_size"] ..
                    "|" .. data_table["predator"] ..
                    "|" .. data_table["prey"] ..
                    "|" .. data_table["repel_item"] ..
                    "|" .. data_table["follow_item"] ..
                    "|" .. data_table["feed_item"] ..
                    "|" .. data_table["tame_count"] ..
                    "|" .. data_table["breed_item"] ..
                    "|" .. data_table["breed_distance"] ..
                    "|" .. data_table["convert_with"] ..
                    "|" .. data_table["convert_to"] ..
                    "|" .. data_table["convert_count"] ..
                    "|" .. data_table["harmful_node"] ..
                    "|" .. data_table["custom_str"] ..
                    "|"         -- "check" column
            )

        elseif fields.key_enter_field then

            -- User has pressed ENTER in a field other than the "Mob type" field; preserve the
            --      contents of that field for next time
            data_table["mob_type"] = mob_type

        end

    end

    unilib.gui.set_tab_data_for_edit_formspec(tab_type, data_table)
    unilib.gui.redisplay_edit_formspec(pname)

end

local function add_mob_constants(tab_type, fields)

    local defn_table = unilib.gui.get_tab_defn_from_edit_formspec("mob")

    -- N.B. The constants CHECK, CANNOT_SPAWN, DISABLE_SPAWN, DISABLE_BREED and CAN_SPAWN are
    --      commonly used in mob_settings.csv (see the unimobs documentation)
    -- However, they are not required by the widgets in the "Mobs" tab, so they don't appear in
    --      "defn_table"
    unilib.gui.update_notepad_in_edit_formspec(
        fields.main_notepad,
        "CHECK|check\n" ..
            "CANNOT_SPAWN|true\n" ..
            "DISABLE_SPAWN|true\n" ..
            "DISABLE_BREED|\n" ..
            "CAN_SPAWN|\n" ..
            defn_table["constant_table"]["spawn_prob"] .. "|\n" ..
            defn_table["constant_table"]["spawn_node"] .. "|\n" ..
            defn_table["constant_table"]["spawn_biome"] .. "|\n" ..
            defn_table["constant_table"]["max_height"] .. "|\n" ..
            defn_table["constant_table"]["min_height"] .. "|\n" ..
            defn_table["constant_table"]["herd_size"] .. "|\n" ..
            defn_table["constant_table"]["predator"] .. "|\n" ..
            defn_table["constant_table"]["prey"] .. "|\n" ..
            defn_table["constant_table"]["repel_item"] .. "|\n" ..
            defn_table["constant_table"]["follow_item"] .. "|\n" ..
            defn_table["constant_table"]["feed_item"] .. "|\n" ..
            defn_table["constant_table"]["tame_count"] .. "|\n" ..
            defn_table["constant_table"]["breed_item"] .. "|\n" ..
            defn_table["constant_table"]["breed_distance"] .. "|\n" ..
            defn_table["constant_table"]["convert_with"] .. "|\n" ..
            defn_table["constant_table"]["convert_to"] .. "|\n" ..
            defn_table["constant_table"]["convert_count"] .. "|\n" ..
            defn_table["constant_table"]["harmful_node"] .. "|\n" ..
            defn_table["constant_table"]["custom_str"] .. "|"
    )

end

local function warning_show_callback(tab_type, fields, pname)

    local formspec =
        "size[7,6;]" ..
        "image[2.75,0;1.5,1.5;unilib_gui_warning.png]" ..
        "textarea[0.5,1.5;7,4;;;" .. FS(
            "Data read from the remix can be used to create biomes, decorations and ores. This" ..
            " data is read automatically by unilib's system code."
        ) .. "\n\n" .. FS(
            "However, if the remix specifies a list of mobs, that data must be read by the" ..
            " \"meta_petz_settings\" package (or a comparable package you've written yourself)."
        ) .. "\n\n" .. FS(
            "You should add the package to the remix now. You should also add the label" ..
            " \"petz\", so the package knows which remix to read."
        ) .. "]" ..
        "button_exit[0.5,5;6,1;auto_add_btn;" ..
            FS("Add the package and label automatically") .. "]"

    core.show_formspec(pname, warning_formname, formspec)

end

local function warning_check_callback(tab_type)

    -- Don't need to show the warning formspec if the "meta_petz_settings" package has already been
    --      added to the Packages tab, and the "petz" label has already been added to the "Labels"
    --      tab

    local package_data_table = unilib.gui.get_tab_data_from_edit_formspec("package")
    local label_data_table = unilib.gui.get_tab_data_from_edit_formspec("label")
    if package_data_table == nil or label_data_table == nil then

        -- Show the warning button which, when clicked, opens the warning formspec
        return true

    end

    local package_content = package_data_table.content
    local label_content = label_data_table.content
    if package_content == nil or
            package_content == "" or
            not check_package_content(package_content) or
            label_content == nil or
            label_content == "" or
            not check_label_content(label_content) then
        return true
    end

    -- Don't show the warning button
    return false

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Register a new tab with the edit remix formspec

core.after(0.1, function()

    unilib.gui.add_tab_to_edit_formspec("mob", {
        category = "mob",
        label = FS("Mobs"),
        file = "mob_settings.csv",

        init_func = init_mob_data,
        formspec_func = get_mob_formspec_section,
        response_func = respond_to_mob_formspec,
        convert_func = convert_mob_text,

        add_constant_label = FS("Add mob constants"),
        add_constant_func = add_mob_constants,

        warning_tooltip = FS("Click me!"),
        warning_call_func = warning_show_callback,
        warning_check_func = warning_check_callback,

        constant_table = {
            spawn_prob = "NO_CUSTOM_SPAWN",
            spawn_node = "NO_NODE",
            spawn_biome = "NO_BIOME",
            max_height = "NO_MAX_HEIGHT",
            min_height = "NO_MIN_HEIGHT",
            herd_size = "NO_HERD",
            predator = "NO_PREDATOR",
            prey = "NO_PREY",
            repel_item = "NO_REPEL",
            follow_item = "NO_FOLLOW",
            feed_item = "NO_FEED",
            tame_count = "NO_CUSTOM_TAME",
            breed_item = "CANNOT_BREED",
            breed_distance = "NO_DISTANCE",
            convert_with = "NO_CONVERT_WITH",
            convert_to = "NO_CONVERT_TO",
            convert_count = "NO_CUSTOM_CONVERT",
            harmful_node = "NO_HARMFUL",
            custom_str = "NO_EXTRA",
        },
        prop_list = {
            "spawn_prob", "spawn_node", "spawn_biome", "max_height", "min_height", "herd_size",
            "predator", "prey", "repel_item", "follow_item", "feed_item", "tame_count",
            "breed_item", "breed_distance", "convert_with", "convert_to", "convert_count",
            "harmful_node", "custom_str",
        },
    })

end)

-- Respond to the player's actions in the warning formspec generated by this file

core.register_on_player_receive_fields(function(player, formname, fields)

    if formname ~= warning_formname then
        return false
    end

    local pname = player:get_player_name()

    if fields.auto_add_btn then

        update_package_and_label_content()
        unilib.gui.save_edit_formspec_content("package")
        unilib.gui.save_edit_formspec_content("label")

    end

    unilib.gui.redisplay_edit_formspec(pname)

end)
