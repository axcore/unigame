---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    maptools
-- Code:    zlib
-- Media:   zlib
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
for pusher_num=1,10,1 do
	register_node("maptools:pusher_" .. pusher_num, {
		description = S("Pusher (%s)"):format(pusher_num),
				inventory_image = "default_steel_block.png^default_apple.png",
		drawtype = "nodebox",
		tiles = {"invisible.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.4999, 0.5},
		},
		groups = {
			fall_damage_add_percent = -100,
			bouncy = pusher_num * 100,
		},
	})
end
]]--
