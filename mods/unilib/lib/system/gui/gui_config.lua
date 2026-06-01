---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- gui_config.lua
--      system configuration formspec
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

local config_formname = "unilib:form_system_gui_config"
local confirm_formname = "unilib:form_system_gui_config_confirm"

-- (Lists populated below)
local all_remix_list = nil
local select_remix_list = nil
local all_pkg_list = nil
local select_pkg_list = nil

local current_tab = 1
local current_remix_set = unilib.setting.init_remix_pkg_set
local current_remix_info = ""
local current_remix_path = ""
local current_remix_search = ""
local current_pkg_info = ""
local current_pkg_path = ""
local current_pkg_search = ""

local saved_remix_set = current_remix_set

local dark_colour = "#000000"
local loaded_colour = "#00FFFF"
local extra_msg = ""
local no_description_msg = FS("No description available")

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_pkg_list()

    -- This list only needs to be compiled once
    if all_pkg_list == nil then

        all_pkg_list = {}

        -- Packages with duplicate names are never loaded
        local check_table = {}

        -- The first time the formspec tab is opened, compile a list of all available packages (not
        --      just those that have been loaded)
        for _, folder_path in ipairs(unilib.global.pkg_path_list) do

            for _, file_name in ipairs(core.get_dir_list(folder_path, false)) do

                -- Not really practical to check that this is a genuine unilib package at this
                --      stage, but at least check that it's a .lua file
                if file_name:sub(-4) == ".lua" then
                    table.insert(all_pkg_list, file_name:sub(1, -5))
                end

            end

        end

        table.sort(all_pkg_list)

    end

    local function do_colourise(pkg_list)

        local return_list = {}
        for _, pkg_name in ipairs(pkg_list) do

            if unilib.global.pkg_loaded_table[pkg_name] then
                table.insert(return_list, loaded_colour .. pkg_name)
            else
                table.insert(return_list, pkg_name)
            end

        end

        return return_list

    end

    local return_list
    if select_pkg_list ~= nil then
        return_list = do_colourise(select_pkg_list)
    else
        return_list = do_colourise(all_pkg_list)
    end

    -- Convert the list to a string, ready for display in the formspec
    return table.concat(return_list, ",")

end

local function compile_remix_list()

    -- This list only needs to be compiled once
    if all_remix_list == nil then

        all_remix_list = {}
        select_remix_list = nil

        -- Remixes with duplicate names are never loaded
        local check_table = {}

        -- The first time the formspec tab is opened, compile a list of all available remixes (not
        --      just those that have been loaded)
        for _, folder_path in ipairs(unilib.global.remix_path_list) do

            for _, remix_name in ipairs(core.get_dir_list(folder_path, true)) do

                if check_table[remix_name] == nil then

                    -- A valid remix is a folder containing a packages.csv file
                    local remix_path = folder_path .. remix_name
                    if unilib.utils.is_file(remix_path .. "/packages.csv") then

                        check_table[remix_name] = true
                        table.insert(all_remix_list, remix_name)

                    end

                end

            end

        end

        table.sort(all_remix_list)

    end

    local function do_colourise(remix_list)

        local return_list = {}
        for _, remix_name in ipairs(remix_list) do

            if unilib.global.remix_dir_table[remix_name] then
                table.insert(return_list, loaded_colour .. remix_name)
            else
                table.insert(return_list, remix_name)
            end

        end

        return return_list

    end

    local return_list
    if select_remix_list ~= nil then
        return_list = do_colourise(select_remix_list)
    else
        return_list = do_colourise(all_remix_list)
    end

    -- Convert the list to a string, ready for display in the formspec
    return table.concat(return_list, ",")

end

local function do_pkg_search(search_term)

    if all_pkg_list == nil or search_term == nil or search_term == "" then

        -- Nothing to search
        select_pkg_list = nil
        return

    end

    select_pkg_list = {}
    for _, pkg_name in ipairs(all_pkg_list) do

        if pkg_name:find(search_term) then
            table.insert(select_pkg_list, pkg_name)
        end

    end

end

local function do_remix_search(search_term)

    if all_remix_list == nil or search_term == nil or search_term == "" then

        -- Nothing to search
        select_remix_list = nil
        return

    end

    select_remix_list = {}
    for _, remix_name in ipairs(all_remix_list) do

        if remix_name:find(search_term) then
            table.insert(select_remix_list, remix_name)
        end

    end

end

local function tidy_current_remix_set(remix_set)

    -- Convert to a list, eliminating duplicates...
    local convert_list = unilib.utils.split_string_by_whitespace(remix_set, true)
    -- Convert back to a string of items, separated by a single whitespace character
    return table.concat(convert_list, " ")

end

local function update_browsed_pkg(pkg_name)

    for _, folder_path in ipairs(unilib.global.pkg_path_list) do

        local pkg_path = folder_path .. pkg_name .. ".lua"
        if unilib.utils.is_file(pkg_path) then

            -- We were not able to check that this is a valid unilib package during the call to
            --      compile_pkg_list(), but now we can
            -- If the package has already been loaded, then we already have its details in memory
            -- Otherwise, open the .lua file, and retrieve the table returned by its .init()
            --      function. (Almost) all executable code should be inside functions, and we're not
            --      going to call any of them
            local init_table, source_mod
            if unilib.global.pkg_loaded_table[pkg_name] then

                init_table = unilib.global.pkg_table[pkg_name]
                source_mod = unilib.global.pkg_loaded_table[pkg_name]

            else

                dofile(pkg_path)
                init_table = unilib.pkg[pkg_name].init()

                -- Cancel the package's own namespace; that should take care of any shared functions
                --      and variables
                unilib.pkg[pkg_name] = nil

            end

            if init_table ~= nil then

                if init_table.description then
                    current_pkg_info = init_table.description
                else
                    current_pkg_info = no_description_msg
                end

                if init_table.notes then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Notes") .. ":\n" ..
                            init_table.notes

                end

                if source_mod then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Source mods") .. ":\n" ..
                            source_mod

                end

                if init_table.first then
                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Loads first")
                elseif init_table.last then
                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Loads last")
                end

                if init_table.excludes then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Excludes packages") ..
                            ":\n" .. unilib.utils.convert_to_string(init_table.excludes)

                end

                if init_table.depends then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Depends on packages") ..
                            ":\n" .. unilib.utils.convert_to_string(init_table.depends)

                end

                if init_table.at_least_one then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("At least one package") ..
                            ":\n" .. unilib.utils.convert_to_string(init_table.at_least_one)

                end

                if init_table.optional then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Optional packages") ..
                            ":\n" .. unilib.utils.convert_to_string(init_table.optional)

                end

                if init_table.suggested then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Suggested") .. ":\n" ..
                            unilib.utils.convert_to_string(init_table.suggested)

                end

                if init_table.mod_excludes then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Excludes mods") .. ":\n" ..
                            unilib.utils.convert_to_string(init_table.mod_excludes)

                end

                if init_table.mod_depends then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Depends on mods") ..
                            ":\n" .. unilib.utils.convert_to_string(init_table.mod_depends)

                end

                if init_table.mod_at_least_one then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("At least one mod") ..
                            ":\n" .. unilib.utils.convert_to_string(init_table.mod_at_least_one)

                end

                if init_table.mod_optional then

                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Optional mods") .. ":\n" ..
                            unilib.utils.convert_to_string(init_table.mod_optional)

                end

                if init_table.adult_flag then
                    current_pkg_info = current_pkg_info .. "\n\n" .. FS("Contains adult material")
                end

                current_pkg_info = F(current_pkg_info)
                current_pkg_path = F(pkg_path)

                return

            end

        end

    end

    -- Package has unexpectedly disappeared
    current_pkg_path = ""
    current_pkg_info = FS("Valid package not found")

end

local function update_browsed_remix(remix_name)

    for _, folder_path in ipairs(unilib.global.remix_path_list) do

        local csv_path = folder_path .. remix_name .. "/packages.csv"
        if unilib.utils.is_file(csv_path) then

            current_remix_path = F(folder_path .. remix_name)

            local descrip_path = folder_path .. remix_name .. "/description.txt"
            if not unilib.utils.is_file(csv_path) then

                current_remix_info = no_description_msg
                return

            end

            local file = io.open(descrip_path, "r")
            if not file then

                current_remix_info = no_description_msg
                return

            end

            current_remix_info = file:read("*a")
            file:close()

            if current_remix_info == nil or current_remix_info == "" then
                current_remix_info = no_description_msg
            else
                current_remix_info = F(current_remix_info)
            end

            return

        end

    end

    -- Remix has unexpectedly disappeared
    current_remix_path = ""
    current_remix_info = FS("Remix not found")

end

local function update_current_remix_set(remix_name)

    current_remix_set = tidy_current_remix_set(current_remix_set .. " " .. remix_name)

end

local function get_config_formspec()

    local formspec =
        "size[8,8;]" ..
        "tabheader[0,0;tabs;" .. FS("Configure") .. "," .. FS("Browse remixes") .. "," ..
                FS("Browse packages") .. ";" .. current_tab .. ";false;false]" ..
        "image[0,0;1,1;unilib_logo_unilib.png]"

    if current_tab == 1 then

        formspec = formspec ..
            "label[1.2,0.2;" .. FS("Configure unilib remixes") .. "]" ..
            "field[0.5,1.7;7.6,1;remix_set;" .. FS("List of remixes and packages") .. ";" ..
                current_remix_set .. "]" ..
            "box[0.275,2.45;7.25,3.2;" .. dark_colour .. "]" ..
            "textarea[0.775,2.45;7.25,3.7;;;" ..
                "\n" ..
                FS("Items in this list are in the following format") .. "\n" ..
                F("     REMIX_NAME   @REMIX_NAME   +PACKAGE_NAME") .. "\n\n" ..
                FS("Exclude items by preceding them with !") .. "\n" ..
                FS("     !REMIX_NAME   !@REMIX_NAME   !+PACKAGE_NAME") .. "\n\n" ..
                FS("Add \"everything\" to load all remixes (testing purposes only)") .. "\n" ..
                FS("Add \"nothing\" to load no remixes (overrides \"everything\")") .. "\n" ..
                "]" ..
            "button[0.25,5.8;3.6,1;reset_btn;" .. FS("Reset the list") .. "]" ..
            "tooltip[reset_btn;" .. FS("Show remixes used when this world was started") .. "]" ..
            "button[3.9,5.8;3.85,1;save_btn;" .. FS("Save the list") .. "]" ..
            "tooltip[save_btn;" .. FS("Save these remixes in unilib settings") .. "]" ..
            "box[0.275,6.9;7.25,1;" .. dark_colour .. "]" ..
            "label[0.5,7.15;" .. extra_msg .. "]"

    elseif current_tab == 2 then

        formspec = formspec ..
            "label[1.2,0.2;" .. FS("Browse remixes") .. "]" ..
            "field[3.7,0.3;2.5,1;search_remix_field;;" .. F(current_remix_search) .. "]" ..
            "tooltip[search_remix;" .. FS("Enter regex") .. "]" ..
            "image_button[5.8,0.1;0.8,0.8;unilib_gui_search.png;search_remix_btn;;;]" ..
            "tooltip[search_remix_btn;" .. FS("Search the list of remixes") .. "]" ..
            "image_button[6.5,0.1;0.8,0.8;unilib_gui_unsearch.png;unsearch_remix_btn;;;]" ..
            "tooltip[unsearch_remix_btn;" .. FS("Reset the search") .. "]" ..
            "image_button[7.2,0.1;0.8,0.8;unilib_gui_refresh.png;reload_remix_btn;;;]" ..
            "tooltip[reload_remix_btn;" .. FS("Reload the list of remixes") .. "]" ..
            "textlist[0,1.4;2.5,5.5;browse_remix;" .. compile_remix_list() .. "]" ..
            "textarea[3.1,1.4;5.1,6.6;;;" .. current_remix_info .. "]" ..
            "field[0.3,7.4;7.9,1;remix_path;;" .. current_remix_path .. "]"

    elseif current_tab == 3 then

        formspec = formspec ..
            "label[1.2,0.2;" .. FS("Browse packages") .. "]" ..
            "field[3.7,0.3;2.5,1;search_pkg_field;;" .. F(current_pkg_search) .. "]" ..
            "tooltip[search_pkg;" .. FS("Enter regex") .. "]" ..
            "image_button[5.8,0.1;0.8,0.8;unilib_gui_search.png;search_pkg_btn;;;]" ..
            "tooltip[search_pkg_btn;" .. FS("Search the list of packages") .. "]" ..
            "image_button[6.5,0.1;0.8,0.8;unilib_gui_unsearch.png;unsearch_pkg_btn;;;]" ..
            "tooltip[unsearch_pkg_btn;" .. FS("Reset the search") .. "]" ..
            "image_button[7.2,0.1;0.8,0.8;unilib_gui_refresh.png;reload_pkg_btn;;;]" ..
            "tooltip[reload_pkg_btn;" .. FS("Reload the list of packages") .. "]" ..
            "textlist[0,1.4;2.5,5.5;browse_pkg;" .. compile_pkg_list() .. "]" ..
            "textarea[3.1,1.4;5.1,6.6;;;" .. current_pkg_info .. "]" ..
            "field[0.3,7.4;7.9,1;pkg_path;;" .. current_pkg_path .. "]"

    end

    -- (The message at the bottom, if any, is shown only once)
    extra_msg = ""

    return formspec

end

local function get_confirm_formspec()

    return "size[8,3;]" ..
        "image[0,0;1,1;unilib_logo_unilib.png]" ..
        "label[1.2,0.2;" .. FS("Confirm new remixes") .. "]" ..
        "label[0.35,1.25;" .. FS("Are you sure you want to update unilib settings?") .. "]" ..
        "button[1,2;3,1;yes_btn;" .. FS("Yes") .. "]" ..
        "button[4,2;3,1;no_btn;" .. FS("No") .. "]"

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.gui._open_config_formspec(pname)
    core.show_formspec(pname, config_formname, get_config_formspec())
end

---------------------------------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------------------------------

core.register_on_player_receive_fields(function(player, formname, fields)

    if formname ~= config_formname and formname ~= confirm_formname then
        return false
    end

    local pname = player:get_player_name()

    if formname == config_formname then

        -- Handle tab switching
        if fields.tabs then

            current_tab = tonumber(fields.tabs) or 1
            core.show_formspec(pname, config_formname, get_config_formspec())

        -- Handle browsing tabs
        elseif fields.browse_remix then

            local event = core.explode_textlist_event(fields.browse_remix)
            local index = event.index

            local remix_name
            if select_remix_list ~= nil then
                remix_name = select_remix_list[index]
            else
                remix_name = all_remix_list[index]
            end

            if remix_name == nil then
                return
            end

            if fields.browse_remix:sub(1, 3) == "DCL" then

                -- Double click; add the remix to the set, and switch tabs
                update_current_remix_set(remix_name)

                current_tab = 1
                extra_msg = FS("Added the @1 remix", remix_name)
                core.show_formspec(pname, config_formname, get_config_formspec())

            else

                -- Single-click; show remix information in this tab, if available
                update_browsed_remix(remix_name)
                core.show_formspec(pname, config_formname, get_config_formspec())

            end

        elseif fields.browse_pkg then

            local event = core.explode_textlist_event(fields.browse_pkg)
            local index = event.index

            local pkg_name
            if select_pkg_list ~= nil then
                pkg_name = select_pkg_list[index]
            else
                pkg_name = all_pkg_list[index]
            end

            if pkg_name == nil then
                return
            end

            if fields.browse_pkg:sub(1, 3) == "DCL" then

                -- Double click; add the package to the set, and switch tabs
                update_current_remix_set("+" .. pkg_name)

                current_tab = 1
                extra_msg = FS("Added the @1 package", pkg_name)
                core.show_formspec(pname, config_formname, get_config_formspec())

            else

                -- Single-click; show package information in this tab, if available
                update_browsed_pkg(pkg_name)
                core.show_formspec(pname, config_formname, get_config_formspec())

            end

        elseif fields.key_enter_field == "remix_path" or
                fields.key_enter_field == "pkg_path" then

            -- (Ideally, these fields would be desensitised, but that's not currently possible;
            --      instead, just ignore anything the player does inside them)
            core.show_formspec(pname, config_formname, get_config_formspec())

        -- Handle buttons
        elseif fields.reset_btn then

            current_remix_set = unilib.setting.init_remix_pkg_set
            saved_remix_set = current_remix_set
            core.settings:set("unilib_init_remix_pkg_set", saved_remix_set)
            core.settings:write()

            extra_msg = FS("Restored the list of remixes loaded when this game was started")
            core.show_formspec(pname, config_formname, get_config_formspec())

        elseif fields.save_btn or fields.key_enter_field == "remix_set" then

            local new_remix_set = tidy_current_remix_set(fields.remix_set)
            if saved_remix_set == new_remix_set then

                extra_msg = FS("No changes to make")
                core.show_formspec(pname, config_formname, get_config_formspec())

            else

                current_remix_set = new_remix_set
                core.show_formspec(pname, confirm_formname, get_confirm_formspec())

            end

        elseif fields.reload_remix_btn then

            all_remix_list = nil
            select_pkg_list = nil
            current_remix_info = ""
            current_remix_path = ""
            current_pkg_search = ""
            core.show_formspec(pname, config_formname, get_config_formspec())

        elseif fields.unsearch_remix_btn then

            do_remix_search()
            current_remix_info = ""
            current_remix_path = ""
            current_remix_search = ""
            core.show_formspec(pname, config_formname, get_config_formspec())

        elseif fields.search_remix_field or fields.search_remix_btn then

            current_remix_search = unilib.utils.strip_whitespace(fields.search_remix_field)
            current_remix_search:gsub("%s+", " ")

            if current_remix_search ~= "" then
                do_remix_search(current_remix_search)
            else
                do_remix_search()
            end

            current_remix_info = ""
            current_remix_path = ""
            core.show_formspec(pname, config_formname, get_config_formspec())

        elseif fields.reload_pkg_btn then

            all_pkg_list = nil
            select_pkg_list = nil
            current_pkg_info = ""
            current_pkg_path = ""
            current_pkg_search = ""
            core.show_formspec(pname, config_formname, get_config_formspec())

        elseif fields.unsearch_pkg_btn then

            do_pkg_search()
            current_pkg_info = ""
            current_pkg_path = ""
            current_pkg_search = ""
            core.show_formspec(pname, config_formname, get_config_formspec())

        elseif fields.search_pkg_field or fields.search_pkg_btn then

            current_pkg_search = unilib.utils.strip_whitespace(fields.search_pkg_field)
            current_pkg_search:gsub("%s+", " ")

            if current_pkg_search ~= "" then
                do_pkg_search(current_pkg_search)
            else
                do_pkg_search()
            end

            current_pkg_info = ""
            current_pkg_path = ""
            core.show_formspec(pname, config_formname, get_config_formspec())

        -- Handle exit
        elseif fields.quit then

            current_tab = 1
            current_remix_info = ""
            current_remix_path = ""
            current_remix_search = ""
            current_pkg_info = ""
            current_pkg_path = ""
            current_pkg_search = ""

        end

    else

        -- Handle the confirmation dialogue
        if fields.yes_btn then

            saved_remix_set = current_remix_set
            core.settings:set("unilib_init_remix_pkg_set", saved_remix_set)
            core.settings:write()

            extra_msg = FS("New remix list stored; restart the game when ready")
            core.show_formspec(pname, config_formname, get_config_formspec())

        elseif fields.no_btn then

            extra_msg = FS("Update cancelled")
            core.show_formspec(pname, config_formname, get_config_formspec())

        end

    end

end)
