---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_file.lua
--      File utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function compile_media_dir_list(part_name)

    -- "part_name" should be one of unilib's media folders, "models", "mts", "sounds" or "textures"

    -- (Assume it's more likely that the media file is in unilib's media folders, rather than in
    --      the expansion pack folders, so test unilib's folder first)
    local return_list = {
        unilib.core.path_mod .. "/" .. part_name,
        unilib.core.path_mod .. "/custom/" .. part_name,
    }

    for ext_pack_name, _ in pairs(unilib.global.ext_pack_table) do
        table.insert(return_list, unilib.global.ext_pack_table[ext_pack_name] .. "/" .. part_name)
    end

    return return_list

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._is_file(path)

    -- Adapted from https://stackoverflow.com/questions/4990990/check-if-a-file-exists-with-lua
    -- Checks whether the specified file path actually exists, or not
    --
    -- Args:
    --      path (nil or str): The file path to check
    --
    -- Return values:
    --      true if the path exists, false if not

    -- Sanity check
    if path == nil or path == "" then
        return false
    end

    local fh = io.open(path, "r")
    if fh ~= nil then
        io.close(fh)
        return true
    else
        return false
    end

end

function unilib.utils._is_model(filename)

    -- Checks whether the specified unilib model file exists
    -- Will not detect models from other mods, or models installed on the client side; so any call
    --      to this function must take that into account
    -- However, it WILL detect models from unilib expansion packs
    --
    -- Args:
    --      filename (nil or str): The model filename to check, e.g. "unilib_character.b3d"
    --
    -- Return values:
    --      true if the path exists, false if not

    -- Sanity check
    if filename == nil or filename == "" then
        return false
    end

    for _, folder in ipairs(compile_media_dir_list("models")) do

        local f = io.open(folder .. "/" .. filename)
        if f then

            f:close()
            return true

        end

    end

    return false

end

function unilib.utils._is_mts(filename)

    -- Checks whether the specified unilib schematic (.mts) file exists
    -- Will not detect schematics from other mods, or schematics installed on the client side; so
    --      any call to this function must take that into account
    -- However, it WILL detect schematics from unilib expansion packs
    --
    -- Args:
    --      filename (nil or str): The schematic filename to check, e.g. "unilib_tree_apple.mts"
    --
    -- Return values:
    --      true if the path exists, false if not

    -- Sanity check
    if filename == nil or filename == "" then
        return false
    end

    for _, folder in ipairs(compile_media_dir_list("mts")) do

        local f = io.open(folder .. "/" .. filename)
        if f then

            f:close()
            return true

        end

    end

    return false

end

function unilib.utils._is_sound(filename)

    -- Checks whether the specified unilib sound file exists
    -- Will not detect sounds from other mods, or sounds installed on the client side; so any call
    --      to this function must take that into account
    -- However, it WILL detect sounds from unilib expansion packs
    --
    -- Args:
    --      filename (nil or str): The sound filename to check, e.g. "unilib_cool_lava.1.ogg"
    --
    -- Return values:
    --      true if the path exists, false if not

    -- Sanity check
    if filename == nil or filename == "" then
        return false
    end

    for _, folder in ipairs(compile_media_dir_list("sounds")) do

        local f = io.open(folder .. "/" .. filename)
        if f then

            f:close()
            return true

        end

    end

    return false

end

function unilib.utils._is_texture(filename)

    -- Checks whether the specified unilib texture file exists
    -- Will not detect textures from other mods, or textures in texture packs, or textures installed
    --      on the client side; so any call to this function must take that into account
    -- However, it WILL detect textures from unilib expansion packs
    --
    -- Args:
    --      filename (nil or str): The texture filename to check, e.g. "unilib_stone_ordinary.png"
    --
    -- Return values:
    --      true if the path exists, false if not

    -- Sanity check
    if filename == nil or filename == "" then
        return false
    end

    for _, folder in ipairs(compile_media_dir_list("textures")) do

        local f = io.open(folder .. "/" .. filename)
        if f then

            f:close()
            return true

        end

    end

    return false

end

function unilib.utils._split_path(path)

    -- Splits the file path into a list of three items - the folder, filename, and extension
    -- Note that the folder item will include any initial or final slashes, and the extension will
    --      include the initial full stop/period

    return path:match("(.-)([^\\/]-)(%.?[^%.\\/]*)$")

end
