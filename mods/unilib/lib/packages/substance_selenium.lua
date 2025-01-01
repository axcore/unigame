---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.substance_selenium = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.substance_selenium.init()

    return {
        description = "Selenium",
    }

end

function unilib.pkg.substance_selenium.exec()

    unilib.register_non_metal({
        -- Original to unilib
        part_name = "selenium",
        description = S("Selenium"),
    })

    unilib.register_craftitem("unilib:substance_selenium_chunk", nil, mode, {
        -- Original to unilib
        description = S("Selenium Chunk"),
        inventory_image = "unilib_substance_selenium_chunk.png",
        groups = {metal_chunk = 1},
    })

end
