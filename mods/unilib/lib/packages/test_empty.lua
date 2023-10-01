---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.test_empty = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.test_empty.init()

    return {
        description = "A test package",
        notes = "This package does nothing, and is not used by any remix",
    }

end

function unilib.pkg.test_empty.exec()

    -- (Do nothing)

end

function unilib.pkg.test_empty.post()

    -- (Do nothing)

end
