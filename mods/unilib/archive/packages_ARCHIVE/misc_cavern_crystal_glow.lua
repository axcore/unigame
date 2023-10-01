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
local glow_gem_size = { 1.0, 1.2, 1.4, 1.6, 1.7 }

for i in ipairs(glow_gem_size) do
	if i == 1 then
		nodename = "caverealms:glow_gem"
	else
		nodename = "caverealms:glow_gem_"..i
	end

	vs = glow_gem_size[i]

	minetest.register_node(nodename, {
		description = "Glow Gem",
		tiles = {"caverealms_glow_gem.png"},
		inventory_image = "caverealms_glow_gem.png",
		wield_image = "caverealms_glow_gem.png",
		is_ground_content = true,
		groups = {cracky=3, oddly_breakable_by_hand=1},
		sounds = default.node_sound_glass_defaults(),
		light_source = 11,
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
