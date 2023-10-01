---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local spike_size = { 1.0, 1.2, 1.4, 1.6, 1.7 }

for i in ipairs(spike_size) do
	if i == 1 then
		nodename = "caverealms:spike"
	else
		nodename = "caverealms:spike_"..i
	end

	vs = spike_size[i]

	minetest.register_node(nodename, {
		description = "Stone Spike",
		tiles = {"caverealms_spike.png"},
		inventory_image = "caverealms_spike.png",
		wield_image = "caverealms_spike.png",
		is_ground_content = true,
		groups = {cracky=3, oddly_breakable_by_hand=1},
		sounds = default.node_sound_stone_defaults(),
		light_source = 3,
		paramtype = "light",
		drawtype = "plantlike",
		walkable = false,
		buildable_to = true,
		visual_scale = vs,
		selection_box = {
			type = "fixed",
			fixed = {-0.5*vs, -0.5*vs, -0.5*vs, 0.5*vs, -5/16*vs, 0.5*vs},
		}
	})
end
]]--
