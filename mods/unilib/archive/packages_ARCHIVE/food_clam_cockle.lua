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
minetest.register_node("aotearoa:cockle", {
	description = "Cockle\n".. minetest.colorize("#adaba0","(Austrovenus stutchburyi)"),
	drawtype = "plantlike",
	paratmtype = "light",
	visual_scale = 0.6,
	tiles = {"aotearoa_cockle.png"},
	inventory_image = "aotearoa_cockle.png",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {6
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.2, 0.1}
	},
	groups = {fleshy = 3, dig_immediate = 3},

	sounds = default.node_sound_gravel_defaults(),
	--rebury shellfish
	on_timer = function(pos)
		local below = {x = pos.x, y = pos.y - 1, z = pos.z}
			if minetest.get_node(below).name == "aotearoa:mud" then
				minetest.set_node(pos, {name = "air"})
				minetest.set_node(below, {name = "aotearoa:mud_with_cockles"})
			end
	end,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(3, 5))
	end,
	--eat and get shells
	--on_use = minetest.item_eat(1,"aotearoa:seashells")
	on_use = minetest.item_eat(1)	
})
]]--
