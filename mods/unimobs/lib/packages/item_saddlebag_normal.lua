---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_saddlebag_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_saddlebag_normal.init()

    return {
        description = "Normal saddle-bag",
        depends = "organ_leather_normal",
    }

end

function unilib.pkg.item_saddlebag_normal.exec()

    local c_leather = "unilib:organ_leather_normal"

    unilib.register_craftitem("unilib:item_saddlebag_normal", "petz:saddlebag", mode, {
        -- From petz:saddlebag
        description = S("Normal Saddle-bag"),
        inventory_image = "unilib_item_saddlebag_normal.png",
        groups = {flammable = 2},
    })
    unilib.register_craft({
        -- From petz:saddlebag
        type = "shaped",
        output = "unilib:item_saddlebag_normal",
        recipe = {
            {c_leather, c_leather, c_leather},
            {c_leather, "", c_leather},
            {c_leather, c_leather, c_leather},
        },
    })

    -- Register the saddle-bag and its compatible mobs, so that code in the Petz API knows how to
    --      handle it
    unimobs.petz_api.register_saddlebag("unilib:item_saddlebag_normal", {"camel_normal"})

end
