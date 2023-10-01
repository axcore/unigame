---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.light_bulb_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.morelights.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_bulb_normal.init()

    return {
        description = "Normal light bulb",
        depends = {"glass_ordinary", "metal_copper", "metal_steel"},
    }

end

function unilib.pkg.light_bulb_normal.exec()

    unilib.register_craftitem("unilib:light_bulb_normal", "morelights:bulb", mode, {
        -- From morelights:bulb
        description = S("Normal Light Bulb"),
        inventory_image = "unilib_light_bulb_normal.png"
    })
    unilib.register_craft({
        -- From morelights:bulb
        output = "unilib:light_bulb_normal",
        recipe = {
            {"", "unilib:glass_ordinary", ""},
            {"", "unilib:metal_copper_ingot", ""},
            {"", "unilib:metal_steel_ingot", ""},
        },
    })

end
