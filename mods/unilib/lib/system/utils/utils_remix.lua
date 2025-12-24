---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- utils_remix.lua
--      Remix utility functions
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.utils._get_remix_by_label(label)

    -- Retrieves the first remix in unilib.global.init_remix_list that has the specified label
    --
    -- Args:
    --      label (str): A remix label, e.g. "gaia"
    --
    -- Return values:
    --      The name of the first remix in unilib.global.init_remix_list that has the specified
    --          label, or nil if none of them do

    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        if unilib.global.remix_label_table[remix_name] ~= nil and
                unilib.global.remix_label_table[remix_name][label] ~= nil then
            return remix_name
        end

    end

end

function unilib.utils._list_remixes_by_label(label)

    -- Compiles a list of remixes in unilib.global.init_remix_list that have the specified label
    --
    -- Args:
    --      label (str): A remix label, e.g. "gaia"
    --
    -- Return values:
    --      A list of remix names that have the specified label, in the same order they occur in
    --          unilib.global.init_remix_list (or an empty list, if no remixes have the specified
    --          label)

    local return_list = {}

    for _, remix_name in ipairs(unilib.global.init_remix_list) do

        if unilib.global.remix_label_table[remix_name] ~= nil and
                unilib.global.remix_label_table[remix_name][label] ~= nil then
            table.insert(return_list, remix_name)
        end

    end

    return return_list

end

