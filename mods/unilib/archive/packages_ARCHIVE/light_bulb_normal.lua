---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    morelights/morelights
-- Code:    LGPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("morelights:bulb", {
    description = S("Light Bulb"),
    inventory_image = "morelights_bulb.png"
})
minetest.register_craft({
    output = "morelights:bulb",
    recipe = {
        {"", a.glass, ""},
        {"", a.copper, ""},
        {"", a.steel, ""}
    }
})
]]--
