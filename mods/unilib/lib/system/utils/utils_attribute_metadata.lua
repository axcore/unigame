---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_attribute_metadata.lua
--      Attribute and metadata utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._get_mod_attribute(key)

    -- Retrieves the value of a key-value pair in mod storage
    --
    -- This function automatically adds "unilib:" to the beginning of the key, so the calling code
    --      shouldn't do that
    -- In order to guarantee their uniqueness, keys created by packages should begin
    --          "pkg_PACKAGENAME_". For keys generated by any other code, the first component should
    --          mirror the code's file name (e.g. "cuisine_" for keys created by
    --          ../lib/effects/cuisine/cuisine_eat_base.lua)
    --
    -- Args:
    --      key (str): A unique string. This function automatically adds "unilib:mattrib_" to the
    --          beginning of the key, so the calling code shouldn't do that
    --
    -- Return values:
    --      The key's corresponding value (always a string), or an empty string on failure

    key = "unilib:mattrib_" .. key
    return unilib.core.mod_storage:get_string(key) or ""

end

function unilib.utils._set_mod_attribute(key, value)

    -- Stores a key-value pair in mod storage
    --
    -- This function automatically adds "unilib:" to the beginning of the key, so the calling code
    --      shouldn't do that
    -- In order to guarantee their uniqueness, keys created by packages should begin
    --          "pkg_PACKAGENAME_". For keys generated by any other code, the first component should
    --          mirror the code's file name (e.g. "cuisine_" for keys created by
    --          ../lib/effects/cuisine/cuisine_eat_base.lua)
    --
    -- Args:
    --      key (str): A unique string. This function automatically adds "unilib:mattrib_" to the
    --          beginning of the key, so the calling code shouldn't do that
    --      value (str): Non-string values are converted to strings; nil is converted to any empty
    --          string

    key = "unilib:mattrib_" .. key

    if value == nil then
        unilib.core.mod_storage:set_string(key, "")
    else
        unilib.core.mod_storage:set_string(key, tostring(value))
    end

end

function unilib.utils._get_player_attribute(player, key)

    -- Retrieves the value of a key-value pair in the player's metadata
    --
    -- This function automatically adds "unilib:" to the beginning of the key, so the calling code
    --      shouldn't do that
    -- In order to guarantee their uniqueness, keys created by packages should begin
    --          "pkg_PACKAGENAME_". For keys generated by any other code, the first component should
    --          mirror the code's file name (e.g. "cuisine_" for keys created by
    --          ../lib/effects/cuisine/cuisine_eat_base.lua)
    --
    -- Args:
    --      player (Player): The player object
    --      key (str): A unique string. This function automatically adds "unilib:pattrib_" to the
    --          beginning of the key, so the calling code shouldn't do that
    --
    -- Return values:
    --      The key's corresponding value (always a string), or an empty string on failure

    key = "unilib:pattrib_" .. key

    local meta = player:get_meta()
    return meta and meta:get_string(key) or ""

end

function unilib.utils._set_player_attribute(player, key, value)

    -- Stores a key-value pair in the player's metadata
    --
    -- This function automatically adds "unilib:" to the beginning of the key, so the calling code
    --      shouldn't do that
    -- In order to guarantee their uniqueness, keys created by packages should begin
    --          "pkg_PACKAGENAME_". For keys generated by any other code, the first component should
    --          mirror the code's file name (e.g. "cuisine_" for keys created by
    --          ../lib/effects/cuisine/cuisine_eat_base.lua)
    --
    -- Args:
    --      player (Player): The player object
    --      key (str): A unique string. This function automatically adds "unilib:pattrib_" to the
    --          beginning of the key, so the calling code shouldn't do that
    --      value (str): Non-string values are converted to strings; nil is converted to any empty
    --          string

    key = "unilib:pattrib_" .. key

    local meta = player:get_meta()
    if meta and value == nil then
        meta:set_string(key, "")
    elseif meta then
        meta:set_string(key, tostring(value))
    end

end

function unilib.utils._deserialise_player_attribute(player, key)

    -- Deserialises the value of a key-value pair, before returning it
    --
    -- This function automatically adds "unilib:" to the beginning of the key, so the calling code
    --      shouldn't do that
    -- In order to guarantee their uniqueness, keys created by packages should begin
    --          "pkg_PACKAGENAME_". For keys generated by any other code, the first component should
    --          mirror the code's file name (e.g. "cuisine_" for keys created by
    --          ../lib/effects/cuisine/cuisine_eat_base.lua)
    --
    -- Args:
    --      player (Player): The player object
    --      key (str): A unique string. This function automatically adds "unilib:pattrib_" to the
    --          beginning of the key, so the calling code shouldn't do that
    --
    -- Return values:
    --      The key's corresponding value (always a table), or an empty table on failure

    key = "unilib:pattrib_" .. key

    local meta = player:get_meta()
    return meta and core.deserialize(meta:get_string(key), true) or {}

end

function unilib.utils._serialise_player_attribute(player, key, data_table)

    -- Serialises the value of a key-value pair, before storing it in the player's metadata
    --
    -- This function automatically adds "unilib:" to the beginning of the key, so the calling code
    --      shouldn't do that
    -- In order to guarantee their uniqueness, keys created by packages should begin
    --          "pkg_PACKAGENAME_". For keys generated by any other code, the first component should
    --          mirror the code's file name (e.g. "cuisine_" for keys created by
    --          ../lib/effects/cuisine/cuisine_eat_base.lua)
    --
    -- Args:
    --      player (Player): The player object
    --      key (str): A unique string. This function automatically adds "unilib:pattrib_" to the
    --          beginning of the key, so the calling code shouldn't do that
    --      data_table (table): A table containing tables, strings, numbers, booleans and nils

    key = "unilib:pattrib_" .. key

    local meta = player:get_meta()
    if meta then
        meta:set_string(key, core.serialize(data_table))
    end

end

function unilib.utils._clone_metadata(old_table, new_obj)

    -- Partially clones metadata from one object to a new one
    -- Specifically, clones key-value pairs from the .fields field (which typically includes
    --      an item's infotext, or toolranks data). Existing key-value pairs are overwritten, but
    --      key-value pairs not found in the old object are not modified
    -- This function is dumb, expecting key-value pairs whose values are simple strings; use with
    --      caution
    --
    -- Args:
    --      orig_table (table): The result of a call to old_obj:get_meta():to_table(), where
    --          "old_obj" is e.g. an ItemStack representing a tool
    --      new_obj (obj): e.g. an ItemStack representing a tool

    local new_meta = new_obj:get_meta()
    if new_meta ~= nil and old_table.fields ~= nil then

        for k, v in pairs(old_table.fields) do
            new_meta:set_string(k, v)
        end

    end

end
