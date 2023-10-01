---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("cacaotree:cacao_beans", {
    description = S("Cacao Beans"),
    inventory_image = "cacaotree_cacao_beans.png"
})

minetest.register_craftitem("cacaotree:cocoa_powder", {
    description = S("Cocoa Powder"),
    inventory_image = "cacaotree_cocoa_powder.png"
})
minetest.register_craft({
	type = "cooking",
	output = "cacaotree:cocoa_powder",
	recipe = "cacaotree:cacao_beans",
	cooktime = 2,
})
]]--
