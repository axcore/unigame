---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    stripped_tree
-- Code:    GPLv3.0
-- Media:   GPLv3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
--Register tree bark
minetest.register_craftitem(":default:tree_bark", {
	description = "Tree bark",
	inventory_image = "tree_bark.png",
	groups = {not_in_creative_inventory = 1}
})
--register bark as fuel
minetest.register_craft({
	type = "fuel",
	recipe = "default:tree_bark",
	burntime = 15,
})

--Register craft for string
if minetest.get_modpath("farming") then

        minetest.register_craft({
	        output = "farming:string 4",
	        recipe = {{"default:tree_bark","default:tree_bark","default:tree_bark"},
			      {"default:tree_bark","default:tree_bark","default:tree_bark"},
			      {"default:tree_bark","default:tree_bark","default:tree_bark"}}
        })
end

--Register craft for paper
minetest.register_craft({
    output = "default:paper 8",
    recipe = {{"default:tree_bark","default:tree_bark","default:tree_bark"},
			  {"default:tree_bark","bucket:bucket_water","default:tree_bark"},
			  {"default:tree_bark","default:tree_bark","default:tree_bark"}}
})

--Register craft for mulch
if minetest.get_modpath("bonemeal") then

        minetest.register_craft({
	    output = "bonemeal:mulch 4",
	    recipe = {{"default:tree_bark","default:tree_bark","default:tree_bark"},
			      {"default:tree_bark","default:tree_bark","default:tree_bark"},
			      {"","",""}}
        })
end
]]--
