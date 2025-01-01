---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- read_detect.lua
--      Detect any expansion packs that Minetest has loaded, and update global variables
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function detect_expansion_packs()

    -- Expansion packs add themselves to a global namespace, "xunilib". This only works if the pack
    --      has already been loaded (so all expansion packs must be in unilib's mod.conf)
    if xunilib == nil or xunilib.ext_pack_list == nil then
        return
    end

    -- Ignore duplicate expansion packs
    local check_table = {}
    for _, ext_pack_name in ipairs(xunilib.ext_pack_list) do

        local ext_pack_path = core.get_modpath(ext_pack_name)
        if ext_pack_path then

            -- Valid expansion pack; update global variables
            unilib.global.ext_pack_table[ext_pack_name] = ext_pack_path
            table.insert(unilib.global.ext_pack_list, ext_pack_name)

        end

    end

end

local function populate_file_locations()

    -- Global variables such as unilib.global.pkg_path_list must be populated with paths to various
    --      folders, some in unilib, some in expansion packs

    for _, ext_pack_name in ipairs(unilib.global.ext_pack_list) do

        local ext_pack_path = unilib.global.ext_pack_table[ext_pack_name]

        for _, item in ipairs(unilib.global.ext_pkg_path_list) do

            local path = ext_pack_path .. item
            -- N.B. unilib.utils.is_file() will work, because "path" ends with a forward slash
            if unilib.utils.is_file(path) then
                table.insert(unilib.global.pkg_path_list, path)
            end

        end

        for _, item in ipairs(unilib.global.ext_remix_path_list) do

            local path = ext_pack_path .. item
            if unilib.utils.is_file(path) then
                table.insert(unilib.global.remix_path_list, path)
            end

        end

        for _, item in ipairs(unilib.global.ext_info_path_list) do

            local path = ext_pack_path .. item
            if unilib.utils.is_file(path) then
                table.insert(unilib.global.info_path_list, path)
            end

        end

    end

    for _, rel_path in ipairs(unilib.global.base_pkg_path_list) do
        table.insert(unilib.global.pkg_path_list, unilib.core.path_mod .. rel_path)
    end

    for _, rel_path in ipairs(unilib.global.base_remix_path_list) do
        table.insert(unilib.global.remix_path_list, unilib.core.path_mod .. rel_path)
    end

    for _, rel_path in ipairs(unilib.global.base_info_path_list) do
        table.insert(unilib.global.info_path_list, unilib.core.path_mod .. rel_path)
    end

end

---------------------------------------------------------------------------------------------------
-- Setup code
---------------------------------------------------------------------------------------------------

-- Detect any expansion packs that Minetest has loaded...
detect_expansion_packs()
-- ...and update global variables
populate_file_locations()
