---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    offend_flags
-- Code:    LGPL-3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("offend_flags:cartridge_red", {
    description = "Red Ink Cartridge",
    inventory_image = "offend_flags_cartridge_red.png",
})
    minetest.register_craft({
        output = "offend_flags:cartridge_red",
        recipe = {
            {paper, paper, paper},
            {paper, "dye:red", paper},
            {paper, "", ""},
        }
    })
    minetest.register_craft({
        type = "shapeless",
        output = "offend_flags:cartridge_red",
        recipe = {"offend_flags:cartridge_red", "dye:red"}
    })

minetest.register_tool("offend_flags:cartridge_green", {
    description = "Green Ink Cartridge",
    inventory_image = "offend_flags_cartridge_green.png",
})
    minetest.register_craft({
        output = "offend_flags:cartridge_green",
        recipe = {
            {paper, paper, paper},
            {paper, "dye:green", paper},
            {paper, "", ""},
        }
    })
    minetest.register_craft({
        type = "shapeless",
        output = "offend_flags:cartridge_green",
        recipe = {"offend_flags:cartridge_green", "dye:green"}
    })

minetest.register_tool("offend_flags:cartridge_blue", {
    description = "Blue Ink Cartridge",
    inventory_image = "offend_flags_cartridge_blue.png"
})
    minetest.register_craft({
        output = "offend_flags:cartridge_blue",
        recipe = {
            {paper, paper, paper},
            {paper, "dye:blue", paper},
            {paper, "", ""},
        }
    })
    minetest.register_craft({
        type = "shapeless",
        output = "offend_flags:cartridge_blue",
        recipe = {"offend_flags:cartridge_blue", "dye:blue"}
    })
]]--
