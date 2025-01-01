---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_cuisine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_chat_cuisine.cuisine_max_level = 20
unilib.pkg.shared_chat_cuisine.cuisine_cripple_level = 4

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_chat_cuisine.init()

    return {
        description = "Shared functions for chat commands for health, stamina, hydration and"
                .. " advanced cuisine",
    }

end
