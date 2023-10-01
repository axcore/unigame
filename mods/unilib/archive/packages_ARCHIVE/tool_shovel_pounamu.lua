---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("aotearoa:shovel_green", {
  	description = "Green Shovel",
  	inventory_image = "aotearoa_shovel_green.png",
  	wield_image = "aotearoa_shovel_green.png^[transformR90",
  	tool_capabilities = {
  		full_punch_interval = 1.0,
  		max_drop_level=1,
  		groupcaps={
  			crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
  		},
  		damage_groups = {fleshy=4},
  	},
  	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craft({
	output = "aotearoa:shovel_green",
	recipe = {
		{"aotearoa:kawakawa_leaves", "aotearoa:volcanic_sand", "aotearoa:kawakawa_leaves"},
		{"dye:red", "aotearoa:pounamu", "aotearoa:flax_rope"},
		{"aotearoa:cooked_mamaku_pith", "aotearoa:black_maire_wood", "aotearoa:cooked_nikau_shoots"},
	}
})
]]--
