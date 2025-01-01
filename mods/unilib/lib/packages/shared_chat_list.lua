---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_list = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chat_list.convert_param(param)

    -- Original to unilib
    -- Called by chat commands /list_nodes, etc
    -- "param" is the argument to the command, which might begin with a ! character (meaning
    --      "everything that does not match this"), or not
    -- If "param" starts with !, removes it and returns the modified "param" and true
    -- Otherwise returns the original "param" and false

    if string.sub(param, 1, 1) == "!" then
        return true, string.sub(param, 2)
    else
        return false, param
    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chat_list.init()

    return {
        description = "Shared functions for chat commands for listing registered things",
    }

end
