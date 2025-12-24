---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_saddle_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_saddle_normal.init()

    return {
        description = "Normal saddle",
        depends = {"metal_steel", "organ_leather_normal"},
    }

end

function unilib.pkg.item_saddle_normal.exec()

    local c_leather = "unilib:organ_leather_normal"

    unilib.register_craftitem("unilib:item_saddle_normal", "petz:saddle", mode, {
        -- From petz:saddle
        description = S("Normal Saddle"),
        inventory_image = "unilib_item_saddle_normal.png",
        groups = {flammable = 2, saddle = 1}
    })
    unilib.register_craft({
        -- From petz:saddle
        type = "shaped",
        output = "unilib:item_saddle_normal",
        recipe = {
            {c_leather, c_leather, c_leather},
            {c_leather, "unilib:metal_steel_ingot", c_leather},
            {c_leather, "unilib:metal_steel_ingot", c_leather},
        },
    })

    -- Register the saddle and its compatible mobs, so that code in the Petz API knows how to
    --      handle it
    unimobs.petz_api.register_saddle("unilib:item_saddle_normal", {"camel_normal", "pony_normal"})

end
