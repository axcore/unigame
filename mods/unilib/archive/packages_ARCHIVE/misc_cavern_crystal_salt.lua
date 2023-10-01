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
local salt_gem_size = { 1.0, 1.2, 1.4, 1.6, 1.7 }

for i in ipairs(salt_gem_size) do
	if i == 1 then
		nodename = "caverealms:salt_gem"
	else
		nodename = "caverealms:salt_gem_"..i
	end

	vs = salt_gem_size[i]

	minetest.register_node(nodename, {
		description = "Salt Gem",
		tiles = {"caverealms_salt_gem.png"},
		inventory_image = "caverealms_salt_gem.png",
		wield_image = "caverealms_salt_gem.png",
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
