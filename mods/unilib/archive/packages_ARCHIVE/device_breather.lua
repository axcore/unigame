---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    hook
-- Code:    LGPL-2.1
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_tool("hook:mba", {
	description = "Mouth breather assembly",
	range = 1,
	inventory_image = "hook_mba.png",
	on_use=function(itemstack, user, pointed_thing)
		local pos=user:get_pos()
		pos.y=pos.y+1.5
		if hook.slingshot_def(pos,"drowning")==0 then
			itemstack:set_wear(1)
		else
			local use=itemstack:get_wear()+(65536/10)
			if use<65536 then
				itemstack:set_wear(use)
				user:set_breath(11)
			end
		end
		return itemstack
	end
})
minetest.register_craft({
	output = "hook:mba",
	recipe = {
		{"","default:steel_ingot",""},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot","","default:steel_ingot"},
	}
})
]]--
