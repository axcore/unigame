---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- tools_properties.lua
--      Register tool negative properties
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Register tool negative properties
---------------------------------------------------------------------------------------------------

function unilib.tools._register_no_repair(full_name, error_msg)

    -- Original to unilib
    -- Items that should not be repairable (for example, by the anvil provided by the
    --      "machine_anvil_simple" package should call this function
    --
    -- Args:
    --      full_name (str): e.g. "unilib:item_hangglider"
    --      error_msg (msg): e.g. "This hangglider is unsuitable for repair", if not specified, a
    --          generic message is used

    if error_msg == nil then
        unilib.global.tool_no_repair_table[full_name] = S("This item cannot be repaired")
    else
        unilib.global.tool_no_repair_table[full_name] = error_msg
    end

end

function unilib.tools._register_no_scythe(full_name)

    -- Original to unilib
    -- Items that should not be affected by scythes (e.g. beanpoles and trellises) should call this
    --      function

    unilib.global.tool_no_scythe_table[full_name] = true

end
