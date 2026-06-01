---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- gui_create.lua
--      API functions for the remix creation formspec
---------------------------------------------------------------------------------------------------

local S = unilib.intllib
local F = core.formspec_escape
local FS = function(...) return F(S(...)) end

local create_formname = "unilib:form_system_gui_create"

local unilib_url = "https://github.com/axcore/unilib"

local dark_colour = "#000000"
local extra_msg = ""

local btn_table = {
    descrip = false,
    constant = false,
    biome = false,
    deco = false,
    ore = false,
}

local package_str = "# node_name | original_mod"
local constant_str = "# constant | value"
local biome_str = "# Biome name|Description|Original biome name|Dust node|Top node and depth|Fill node and depth|Stone node|Top water node and depth|Water node|River node|Riverbed node and depth|Cave liquid node|Dungeon node|Dungeon alternative node|Dungeon stair node|Max height|Min height|Vertical blend|Heat|Humidity"
local deco_str = "# Deco type|Deco name|Max height|Min height|Biomes|Place on|Spawn by|Num spawn by|Fill ratio|Height max|Flags|Side length"
local ore_blob_str = "# ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes"
local ore_puff_str = "# ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes|nppt_offset|nppt_scale|nppt_spread|nppt_seed|nppt_octaves|nppt_persist|nppb_offset|nppb_scale|nppb_spread|nppb_seed|nppb_octaves|nppb_persist"
local ore_scatter_str = "# ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes"
local ore_sheet_str = "# ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes|column_height_max|column_height_min|column_midpoint_factor"
local ore_stratum_str = "# ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes|npst_offset|npst_scale|npst_spread|npst_seed|npst_octaves|npst_persist|stratum_thickness"
local ore_vein_str = "# ore|ore_param2|wherein|clust_scarcity|clust_num_ores|clust_size|y_max|y_min|flags|noise_threshold|np_offset|np_scale|np_spread|np_seed|np_octaves|np_persist|biomes|random_factor"

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_content_packages(remix_name)

    return "# \"" .. remix_name .. "\" remix" .. "\n\n" .. package_str .. "\n"

end

local function get_content_description()

    return "A remix containing [add your own text here]\n"

end

local function get_content_constants(remix_name)

    return "# General constants table for the \"" .. remix_name .. "\" remix" .. "\n\n" ..
            constant_str .. "\n"

end

local function get_content_biomes(remix_name)

    return "# Biome table for the \"" .. remix_name .. "\" remix" .. "\n\n" .. biome_str .. "\n"

end

local function get_content_decorations(remix_name)

    return "# Decoration table for the \"" .. remix_name .. "\" remix" .. "\n\n" ..
            deco_str .. "\n"

end

local function get_content_ore_blob(remix_name)

    return "# Blob ore table for the \"" .. remix_name .. "\" remix" .. "\n\n" ..
            ore_blob_str .. "\n"

end

local function get_content_ore_puff(remix_name)

    return "# Puff ore table for the \"" .. remix_name .. "\" remix" .. "\n\n" ..
            ore_puff_str .. "\n"

end

local function get_content_ore_scatter(remix_name)

    return "# Scatter ore table for the \"" .. remix_name .. "\" remix" .. "\n\n" ..
            ore_scatter_str .. "\n"

end

local function get_content_ore_sheet(remix_name)

    return "# Sheet ore table for the \"" .. remix_name .. "\" remix" .. "\n\n" ..
            ore_sheet_str .. "\n"

end

local function get_content_ore_stratum(remix_name)

    return "# Stratum ore table for the \"" .. remix_name .. "\" remix" .. "\n\n" ..
            ore_stratum_str .. "\n"

end

local function get_content_ore_vein(remix_name)

    return "# Vein ore table for the \"" .. remix_name .. "\" remix" .. "\n\n" ..
            ore_vein_str .. "\n"

end

local function is_remix_creatable(remix_name, remix_path, packages_path)

    if remix_name == "" then

        extra_msg = FS("Please choose a unique remix name")
        return false

    elseif unilib.utils.is_file(packages_path) then

        extra_msg = FS(
            "The destination folder and its compulsory packages.csv file already" ..
            " exist. Please choose a different remix name"
        )
        return false

    elseif not core.mkdir(remix_path) then

        extra_msg = FS("Could not create a folder for the remix \"@1\"", remix_name)
        return false

    elseif not core.safe_file_write(packages_path, get_content_packages(remix_name)) then

        extra_msg = FS(
            "Folder created for the remix \"@1\", but could not create the compulsory" ..
                " compulsory packages.csv file",
            remix_name
        )
        return false

    else

        extra_msg = FS(
            "Folder created in Minetest mod storage. You can edit it by typing" ..
                " /edit_remix (or just edit the files using a text editor). When you're" ..
                " ready, manually copy the new folder to the correct location inside" ..
                " unilib's folder (or inside one of its expansion packs)"
        )
        return true

    end

end

local function write_file_if_new(path, content)

    -- Don't overwrite an existing .csv or .txt file inside the remix folder
    if not unilib.utils.is_file(path) then
        return core.safe_file_write(path, content)
    else
        return false
    end

end

local function get_create_formspec()

    local formspec =
        "size[8,8;]" ..
        "image[0,0;1,1;unilib_logo_unilib.png]" ..
        "label[1.2,0.2;" .. FS("Create a new remix") .. "]" ..
        "hypertext[0.4,1.25;5,1;;<b>" .. FS("1. Read the advice and warnings") .. "</b>]" ..
        "button_url[5,1;2.75,1;;" .. FS("Open README") .. ";" .. unilib_url .. "]" ..
        "hypertext[0.4,2;8,1;;<b>" .. FS("2. Choose a unique remix name") .. "</b>]" ..
        "field[0.5,2.7;7.6,1;name_field;;]" ..
        "hypertext[0.4,3.5;8,1;;<b>" .. FS("3. Add optional files") .. "</b>]" ..
        "checkbox[0.2,3.8;descrip_btn;" .. F("description.txt") .. ";" ..
            tostring(btn_table.descrip) .. "]" ..
        "checkbox[2.5,3.8;constant_btn;" .. F("constants.csv") .. ";" ..
            tostring(btn_table.constant) .. "]" ..
        "checkbox[0.2,4.3;biome_btn;" .. F("biomes.csv") .. ";" ..
            tostring(btn_table.biome) .. "]" ..
        "checkbox[2.5,4.3;deco_btn;" .. F("decorations.csv") .. ";" ..
            tostring(btn_table.deco) .. "]" ..
        "checkbox[5,4.3;ore_btn;" .. F("All ore CSVs") .. ";" ..
            tostring(btn_table.ore) .. "]" ..
        "button[0.2,5.2;7.6,1;create_btn;" .. FS("Create new remix") .. "]" ..
        "box[0.27,6.3;7.3,1.7;" .. dark_colour .. "]" ..
        "textarea[0.77,6.3;7.3,2.1;;;\n" .. extra_msg .. "]"

    return formspec

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.gui._open_create_formspec(pname, param)

    if param == nil then
        param = ""
    else
        param = unilib.utils.strip_whitespace(param)
    end

    if param ~= "" then

        local remix_path = unilib.core.path_mod_data .. "/remixes/" .. param .. "/"
        local packages_path = remix_path .. "packages.csv"
        if not is_remix_creatable(param, remix_path, packages_path) then

            unilib.utils.chat_send_player(pname, extra_msg)

        else

            unilib.utils.chat_send_player(
                pname,
                S(
                    "Created \"@1\" remix at @2. To edit it, type: @3",
                    param,
                    remix_path,
                    "/edit_remix " .. param
                )
            )

        end

    else

        core.show_formspec(pname, create_formname, get_create_formspec())

    end

end

---------------------------------------------------------------------------------------------------
-- Setup
---------------------------------------------------------------------------------------------------

core.register_on_player_receive_fields(function(player, formname, fields)

    if formname ~= create_formname then
        return false
    end

    local pname = player:get_player_name()

    if formname == create_formname then

        -- Handle buttons
        if fields.create_btn or fields.key_enter_field == "name_field" then

            local remix_name = unilib.utils.strip_whitespace(fields.name_field)
            local remix_path = unilib.core.path_mod_data .."/remixes/" .. remix_name .. "/"
            local packages_path = remix_path .. "packages.csv"

            if not is_remix_creatable(remix_name, remix_path, packages_path) then

                core.show_formspec(pname, create_formname, get_create_formspec())

            else

                -- Use an additional chat window message so that the full file path is clearly
                --      visible
                unilib.utils.chat_send_player(
                    pname,
                    S("Created \"@1\" remix at @2", remix_name, remix_path)
                )

                -- Create optional files, but don't overwrite an existing file
                if btn_table.descrip then
                    write_file_if_new(remix_path .. "/description.txt", get_content_description())
                end

                if btn_table.constant then

                    write_file_if_new(
                        remix_path .. "/constants.csv",
                        get_content_constants(remix_name)
                    )

                end

                if btn_table.biome then
                    write_file_if_new(remix_path .. "/biomes.csv", get_content_biomes(remix_name))
                end

                if btn_table.deco then

                    write_file_if_new(
                        remix_path .. "/decorations.csv",
                        get_content_decorations(remix_name)
                    )

                end

                if btn_table.ore then

                    write_file_if_new(
                        remix_path .. "/ore_blob.csv",
                        get_content_ore_blob(remix_name)
                    )

                    write_file_if_new(
                        remix_path .. "/ore_puff.csv",
                        get_content_ore_puff(remix_name)
                    )

                    write_file_if_new(
                        remix_path .. "/ore_scatter.csv",
                        get_content_ore_scatter(remix_name)
                    )

                    write_file_if_new(
                        remix_path .. "/ore_sheet.csv",
                        get_content_ore_sheet(remix_name)
                    )

                    write_file_if_new(
                        remix_path .. "/ore_stratum.csv",
                        get_content_ore_stratum(remix_name)
                    )

                    write_file_if_new(
                        remix_path .. "/ore_vein.csv",
                        get_content_ore_vein(remix_name)
                    )

                end

                -- File write operations complete
                core.show_formspec(pname, create_formname, get_create_formspec())

            end

        elseif fields.descrip_btn then

            if fields.descrip_btn == "true" then
                btn_table.descrip = true
            else
                btn_table.descrip = false
            end

        elseif fields.constant_btn then

            if fields.constant_btn == "true" then
                btn_table.constant = true
            else
                btn_table.constant = false
            end

        elseif fields.biome_btn then

            if fields.biome_btn == "true" then
                btn_table.biome = true
            else
                btn_table.biome = false
            end

        elseif fields.deco_btn then

            if fields.deco_btn == "true" then
                btn_table.deco = true
            else
                btn_table.deco = false
            end

        elseif fields.ore_btn then

            if fields.ore_btn == "true" then
                btn_table.ore = true
            else
                btn_table.ore = false
            end

        end

    end

end)
