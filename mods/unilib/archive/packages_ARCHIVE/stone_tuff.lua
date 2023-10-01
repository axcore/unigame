---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("darkage:tuff", {
	description = "Tuff",
	tiles = {"darkage_tuff.png"},
	is_ground_content = true,
	legacy_mineral = true,
	groups = {cracky = 3, stone = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player get tuff node if he is lucky :)
				items = {'darkage:tuff'},
				rarity = 3,
			},
			{
				-- player will get rubble with 2/3 chance
				items = {'darkage:tuff_rubble'},
			}

		}
	},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:tuff",
	recipe = "darkage:tuff_rubble",
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:tuff",
	recipe = "darkage:old_tuff_bricks",
})
minetest.register_craft({
	output = "darkage:tuff 2",
	recipe = {
		{"darkage:gneiss", "default:stone"},
		{"default:stone", "darkage:gneiss"},
	}
})

minetest.register_node("darkage:tuff_bricks", {
	description = "Tuff Bricks",
	tiles = {"darkage_tuff_bricks.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:tuff_bricks 4",
	recipe = {
		{"darkage:tuff", "darkage:tuff"},
		{"darkage:tuff", "darkage:tuff"},
	}
})

minetest.register_node("darkage:old_tuff_bricks", {
	description = "Old Tuff Bricks",
	tiles = {"darkage_old_tuff_bricks.png"},
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:tuff_rubble", {
	description = "Tuff Rubble",
	tiles = {"darkage_tuff_rubble.png"},
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
})

-- abm to turn Tuff bricks to old Tuff bricks if water is nearby
minetest.register_abm({
	nodenames = {"darkage:tuff_bricks"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "darkage:old_tuff_bricks"})
	end
})
]]--
