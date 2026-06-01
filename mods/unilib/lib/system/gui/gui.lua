---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- gui.lua
--      Set up the unilib system GUI
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

-- Table of files loaded
local t = {}

---------------------------------------------------------------------------------------------------
-- Create namespaces
---------------------------------------------------------------------------------------------------

unilib.gui = {}

---------------------------------------------------------------------------------------------------
-- Wrapper functions to load files, as and when required
---------------------------------------------------------------------------------------------------

-- API functions for the system configuration formspec
local config_file = unilib.core.path_mod .. "/lib/system/gui/gui_config.lua"

function unilib.gui.open_config_formspec(...)

    if not t[config_file] then t[config_file] = true; dofile(config_file) end
    return unilib.gui._open_config_formspec(...)

end

-- API functions for the remix creation formspec
local create_file = unilib.core.path_mod .. "/lib/system/gui/gui_create_remix.lua"

function unilib.gui.open_create_formspec(...)

    if not t[create_file] then t[create_file] = true; dofile(create_file) end
    return unilib.gui._open_create_formspec(...)

end

-- API functions for the remix editing formspec
local edit_file = unilib.core.path_mod .. "/lib/system/gui/gui_edit_remix.lua"

function unilib.gui.add_tab_to_edit_formspec(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._add_tab_to_edit_formspec(...)

end

function unilib.gui.get_remix_for_edit_formspec(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._get_remix_for_edit_formspec(...)

end

function unilib.gui.get_tab_data_from_edit_formspec(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._get_tab_data_from_edit_formspec(...)

end

function unilib.gui.get_tab_defn_from_edit_formspec(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._get_tab_defn_from_edit_formspec(...)

end

function unilib.gui.open_edit_formspec(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._open_edit_formspec(...)

end

function unilib.gui.redisplay_edit_formspec(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._redisplay_edit_formspec(...)

end

function unilib.gui.save_edit_formspec_content(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._save_edit_formspec_content(...)

end

function unilib.gui.set_tab_data_for_edit_formspec(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._set_tab_data_for_edit_formspec(...)

end

function unilib.gui.update_notepad_in_edit_formspec(...)

    if not t[edit_file] then t[edit_file] = true; dofile(edit_file) end
    return unilib.gui._update_notepad_in_edit_formspec(...)

end

-- API functions for the introductory system formspec
local intro_file = unilib.core.path_mod .. "/lib/system/gui/gui_intro.lua"

function unilib.gui.open_intro_formspec(...)

    if not t[intro_file] then t[intro_file] = true; dofile(intro_file) end
    return unilib.gui._open_intro_formspec(...)

end
