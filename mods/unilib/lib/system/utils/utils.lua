---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils.lua
--      Set up utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespace
---------------------------------------------------------------------------------------------------

unilib.utils = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- Attribute and metadata utility functions
local uam_file = unilib.core.path_mod .. "/lib/system/utils/utils_attribute_metadata.lua"

function unilib.utils.get_mod_attribute(...)

    if not t[uam_file] then t[uam_file] = true; dofile(uam_file) end
    return unilib.utils._get_mod_attribute(...)

end

function unilib.utils.set_mod_attribute(...)

    if not t[uam_file] then t[uam_file] = true; dofile(uam_file) end
    return unilib.utils._set_mod_attribute(...)

end

function unilib.utils.get_player_attribute(...)

    if not t[uam_file] then t[uam_file] = true; dofile(uam_file) end
    return unilib.utils._get_player_attribute(...)

end

function unilib.utils.set_player_attribute(...)

    if not t[uam_file] then t[uam_file] = true; dofile(uam_file) end
    return unilib.utils._set_player_attribute(...)

end

function unilib.utils.deserialise_player_attribute(...)

    if not t[uam_file] then t[uam_file] = true; dofile(uam_file) end
    return unilib.utils._deserialise_player_attribute(...)

end

function unilib.utils.serialise_player_attribute(...)

    if not t[uam_file] then t[uam_file] = true; dofile(uam_file) end
    return unilib.utils._serialise_player_attribute(...)

end

function unilib.utils.clone_metadata(...)

    if not t[uam_file] then t[uam_file] = true; dofile(uam_file) end
    return unilib.utils._clone_metadata(...)

end

-- Biome/decoration/ore utility functions
local bdo_file = unilib.core.path_mod .. "/lib/system/utils/utils_biome_deco_ore.lua"

function unilib.utils.check_heights(...)

    if not t[bdo_file] then t[bdo_file] = true; dofile(bdo_file) end
    return unilib.utils._check_heights(...)

end

function unilib.utils.get_height_constants(...)

    if not t[bdo_file] then t[bdo_file] = true; dofile(bdo_file) end
    return unilib.utils._get_height_constants(...)

end

function unilib.utils.get_unique_deco_name(...)

    if not t[bdo_file] then t[bdo_file] = true; dofile(bdo_file) end
    return unilib.utils._get_unique_deco_name(...)

end

-- biome_lib conversion utility functions
local bl_file = unilib.core.path_mod .. "/lib/system/utils/utils_biome_lib_conversion.lua"

function unilib.utils.convert_biome_lib(...)

    if not t[bl_file] then t[bl_file] = true; dofile(bl_file) end
    return unilib.utils._convert_biome_lib(...)

end

function unilib.utils.convert_biome_lib_humidity(...)

    if not t[bl_file] then t[bl_file] = true; dofile(bl_file) end
    return unilib.utils._convert_biome_lib_humidity(...)

end

function unilib.utils.convert_biome_lib_temp(...)

    if not t[bl_file] then t[bl_file] = true; dofile(bl_file) end
    return unilib.utils._convert_biome_lib_temp(...)

end

-- CSV input/output utility functions
local csv_file = unilib.core.path_mod .. "/lib/system/utils/utils_csv_input_output.lua"

function unilib.utils.get_remix_dir(...)

    if not t[csv_file] then t[csv_file] = true; dofile(csv_file) end
    return unilib.utils._get_remix_dir(...)

end

function unilib.utils.read_csv(...)

    if not t[csv_file] then t[csv_file] = true; dofile(csv_file) end
    return unilib.utils._read_csv(...)

end

function unilib.utils.write_csv(...)

    if not t[csv_file] then t[csv_file] = true; dofile(csv_file) end
    return unilib.utils._write_csv(...)

end

-- Date/time utility functions
local dt_file = unilib.core.path_mod .. "/lib/system/utils/utils_date_time.lua"

function unilib.utils.format_time(...)

    if not t[dt_file] then t[dt_file] = true; dofile(dt_file) end
    return unilib.utils._format_time(...)

end

function unilib.utils.get_clock_time(...)

    if not t[dt_file] then t[dt_file] = true; dofile(dt_file) end
    return unilib.utils._get_clock_time(...)

end

-- Description/infotext utility functions
local dit_file = unilib.core.path_mod .. "/lib/system/utils/utils_description_infotext.lua"

function unilib.utils.annotate(...)

    if not t[dit_file] then t[dit_file] = true; dofile(dit_file) end
    return unilib.utils._annotate(...)

end

function unilib.utils.brackets(...)

    if not t[dit_file] then t[dit_file] = true; dofile(dit_file) end
    return unilib.utils._brackets(...)

end

function unilib.utils.emphasise(...)

    if not t[dit_file] then t[dit_file] = true; dofile(dit_file) end
    return unilib.utils._emphasise(...)

end

function unilib.utils.hint(...)

    if not t[dit_file] then t[dit_file] = true; dofile(dit_file) end
    return unilib.utils._hint(...)

end

-- Engine utility functions
local eng_file = unilib.core.path_mod .. "/lib/system/utils/utils_engine.lua"

function unilib.utils.get_pointed_node(...)

    if not t[eng_file] then t[eng_file] = true; dofile(eng_file) end
    return unilib.utils._get_pointed_node(...)

end

function unilib.utils.is_creative(...)

    if not t[eng_file] then t[eng_file] = true; dofile(eng_file) end
    return unilib.utils._is_creative(...)

end

function unilib.utils.settings_get_float(...)

    if not t[eng_file] then t[eng_file] = true; dofile(eng_file) end
    return unilib.utils._settings_get_float(...)

end

function unilib.utils.settings_get_int(...)

    if not t[eng_file] then t[eng_file] = true; dofile(eng_file) end
    return unilib.utils._settings_get_int(...)

end

-- File utility functions
local fu_file = unilib.core.path_mod .. "/lib/system/utils/utils_file.lua"

function unilib.utils.is_file(...)

    if not t[fu_file] then t[fu_file] = true; dofile(fu_file) end
    return unilib.utils._is_file(...)

end

function unilib.utils.is_model(...)

    if not t[fu_file] then t[fu_file] = true; dofile(fu_file) end
    return unilib.utils._is_model(...)

end

function unilib.utils.is_mts(...)

    if not t[fu_file] then t[fu_file] = true; dofile(fu_file) end
    return unilib.utils._is_mts(...)

end

function unilib.utils.is_sound(...)

    if not t[fu_file] then t[fu_file] = true; dofile(fu_file) end
    return unilib.utils._is_sound(...)

end

function unilib.utils.is_texture(...)

    if not t[fu_file] then t[fu_file] = true; dofile(fu_file) end
    return unilib.utils._is_texture(...)

end

function unilib.utils.split_path(...)

    if not t[fu_file] then t[fu_file] = true; dofile(fu_file) end
    return unilib.utils._split_path(...)

end

-- Image utility functions
local img_file = unilib.core.path_mod .. "/lib/system/utils/utils_image.lua"

function unilib.utils.concat_img(...)

    if not t[img_file] then t[img_file] = true; dofile(img_file) end
    return unilib.utils._concat_img(...)

end

-- List/table utility functions
local lt_file = unilib.core.path_mod .. "/lib/system/utils/utils_list_table.lua"

function unilib.utils.clone_simple_table(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._clone_simple_table(...)

end

function unilib.utils.convert_to_list(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._convert_to_list(...)

end

function unilib.utils.convert_to_string(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._convert_to_string(...)

end

function unilib.utils.get_table_size(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._get_table_size(...)

end

function unilib.utils.is_table_empty(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._is_table_empty(...)

end

function unilib.utils.is_value_in_list(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._is_value_in_list(...)

end

function unilib.utils.is_value_scalar_or_in_list(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._is_value_scalar_or_in_list(...)

end

function unilib.utils.reverse_list(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._reverse_list(...)

end

function unilib.utils.show_table(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._show_table(...)

end

function unilib.utils.show_table_in_chat(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._show_table_in_chat(...)

end

function unilib.utils.sort_table(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._sort_table(...)

end

function unilib.utils.test_equivalence_of_lists(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._test_equivalence_of_lists(...)

end

function unilib.utils.test_junction_of_lists(...)

    if not t[lt_file] then t[lt_file] = true; dofile(lt_file) end
    return unilib.utils._test_junction_of_lists(...)

end

-- Log utility functions
local log_file = unilib.core.path_mod .. "/lib/system/utils/utils_log.lua"

function unilib.utils.show_msg(...)

    if not t[log_file] then t[log_file] = true; dofile(log_file) end
    return unilib.utils._show_msg(...)

end

function unilib.utils.show_error(...)

    if not t[log_file] then t[log_file] = true; dofile(log_file) end
    return unilib.utils._show_error(...)

end

function unilib.utils.show_warning(...)

    if not t[log_file] then t[log_file] = true; dofile(log_file) end
    return unilib.utils._show_warning(...)

end

function unilib.utils.log(...)

    if not t[log_file] then t[log_file] = true; dofile(log_file) end
    return unilib.utils._log(...)

end

function unilib.utils.chat_send_player(...)

    if not t[log_file] then t[log_file] = true; dofile(log_file) end
    return unilib.utils._chat_send_player(...)

end

function unilib.utils.log_player_action(...)

    if not t[log_file] then t[log_file] = true; dofile(log_file) end
    return unilib.utils._log_player_action(...)

end

function unilib.utils.set_inventory_action_loggers(...)

    if not t[log_file] then t[log_file] = true; dofile(log_file) end
    return unilib.utils._set_inventory_action_loggers(...)

end

-- Miscellaneous utility functions
local misc_file = unilib.core.path_mod .. "/lib/system/utils/utils_misc.lua"

function unilib.utils.get_random_seed(...)

    if not t[misc_file] then t[misc_file] = true; dofile(misc_file) end
    return unilib.utils._get_random_seed(...)

end

function unilib.utils.prune_fishing_list(...)

    if not t[misc_file] then t[misc_file] = true; dofile(misc_file) end
    return unilib.utils._prune_fishing_list(...)

end

function unilib.utils.set_auto_rotate(...)

    if not t[misc_file] then t[misc_file] = true; dofile(misc_file) end
    return unilib.utils._set_auto_rotate(...)

end

-- Node/craftitem/tool utility functions (general)
local nct_file = unilib.core.path_mod .. "/lib/system/utils/utils_node_craftitem_tool.lua"

function unilib.utils.get_craftitem_field(...)

    if not t[nct_file] then t[nct_file] = true; dofile(nct_file) end
    return unilib.utils._get_craftitem_field(...)

end

function unilib.utils.get_definition_and_group(...)

    if not t[nct_file] then t[nct_file] = true; dofile(nct_file) end
    return unilib.utils._get_definition_and_group(...)

end

function unilib.utils.get_group(...)

    if not t[nct_file] then t[nct_file] = true; dofile(nct_file) end
    return unilib.utils._get_group(...)

end

function unilib.utils.get_node_field(...)

    if not t[nct_file] then t[nct_file] = true; dofile(nct_file) end
    return unilib.utils._get_node_field(...)

end

function unilib.utils.get_tool_field(...)

    if not t[nct_file] then t[nct_file] = true; dofile(nct_file) end
    return unilib.utils._get_tool_field(...)

end

function unilib.utils.is_registered_node(...)

    if not t[nct_file] then t[nct_file] = true; dofile(nct_file) end
    return unilib.utils._is_registered_node(...)

end

function unilib.utils.is_registered_node_or_mtgame_alias(...)

    if not t[nct_file] then t[nct_file] = true; dofile(nct_file) end
    return unilib.utils._is_registered_node_or_mtgame_alias(...)

end

-- Node/craftitem/tool utility functions (item names)
local ncti_file = unilib.core.path_mod .. "/lib/system/utils/utils_node_craftitem_tool_item.lua"

function unilib.utils.convert_item(...)

    if not t[ncti_file] then t[ncti_file] = true; dofile(ncti_file) end
    return unilib.utils._convert_item(...)

end

function unilib.utils.split_name(...)

    if not t[ncti_file] then t[ncti_file] = true; dofile(ncti_file) end
    return unilib.utils._split_name(...)

end

function unilib.utils.get_mod_name(...)

    if not t[ncti_file] then t[ncti_file] = true; dofile(ncti_file) end
    return unilib.utils._get_mod_name(...)

end

function unilib.utils.get_item_name(...)

    if not t[ncti_file] then t[ncti_file] = true; dofile(ncti_file) end
    return unilib.utils._get_item_name(...)

end

function unilib.utils.get_first_component(...)

    if not t[ncti_file] then t[ncti_file] = true; dofile(ncti_file) end
    return unilib.utils._get_first_component(...)

end

function unilib.utils.get_last_component(...)

    if not t[ncti_file] then t[ncti_file] = true; dofile(ncti_file) end
    return unilib.utils._get_last_component(...)

end

function unilib.utils.get_item_and_multiple(...)

    if not t[ncti_file] then t[ncti_file] = true; dofile(ncti_file) end
    return unilib.utils._get_item_and_multiple(...)

end

-- Numeric/string utility functions
local ns_file = unilib.core.path_mod .. "/lib/system/utils/utils_numeric_string.lua"

function unilib.utils.contract_long_lines(...)

    if not t[ns_file] then t[ns_file] = true; dofile(ns_file) end
    return unilib.utils._contract_long_lines(...)

end

function unilib.utils.first_to_upper(...)

    if not t[ns_file] then t[ns_file] = true; dofile(ns_file) end
    return unilib.utils._first_to_upper(...)

end

function unilib.utils.get_first_line(...)

    if not t[ns_file] then t[ns_file] = true; dofile(ns_file) end
    return unilib.utils._get_first_line(...)

end

function unilib.utils.reduce_lines(...)

    if not t[ns_file] then t[ns_file] = true; dofile(ns_file) end
    return unilib.utils._reduce_lines(...)

end

function unilib.utils.round_up(...)

    if not t[ns_file] then t[ns_file] = true; dofile(ns_file) end
    return unilib.utils._round_up(...)

end

function unilib.utils.split_string_by_underline(...)

    if not t[ns_file] then t[ns_file] = true; dofile(ns_file) end
    return unilib.utils._split_string_by_underline(...)

end

function unilib.utils.split_string_by_whitespace(...)

    if not t[ns_file] then t[ns_file] = true; dofile(ns_file) end
    return unilib.utils._split_string_by_whitespace(...)

end

function unilib.utils.strip_whitespace(...)

    if not t[ns_file] then t[ns_file] = true; dofile(ns_file) end
    return unilib.utils._strip_whitespace(...)

end

-- Startup utility functions
local stp_file = unilib.core.path_mod .. "/lib/system/utils/utils_startup.lua"

function unilib.utils.get_startup_biome_msg(...)

    if not t[stp_file] then t[stp_file] = true; dofile(stp_file) end
    return unilib.utils._get_startup_biome_msg(...)

end

function unilib.utils.get_startup_deco_msg(...)

    if not t[stp_file] then t[stp_file] = true; dofile(stp_file) end
    return unilib.utils._get_startup_deco_msg(...)

end

function unilib.utils.get_startup_expansion_msg(...)

    if not t[stp_file] then t[stp_file] = true; dofile(stp_file) end
    return unilib.utils._get_startup_expansion_msg(...)

end

function unilib.utils.get_startup_ore_msg(...)

    if not t[stp_file] then t[stp_file] = true; dofile(stp_file) end
    return unilib.utils._get_startup_ore_msg(...)

end

function unilib.utils.get_startup_pkg_msg(...)

    if not t[stp_file] then t[stp_file] = true; dofile(stp_file) end
    return unilib.utils._get_startup_pkg_msg(...)

end
