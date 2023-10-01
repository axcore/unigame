---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
moretrees.treelist = {
	{"palm",         S("Palm Tree"),      "palm_fruit_trunk_gen",  S("Palm Tree"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 1.0 },
}
moretrees.palm_biome = {
	surface = "default:sand",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 5,
	seed_diff = 330,
	min_elevation = -1,
	max_elevation = 1,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 10,
	temp_min = 0.25,
	temp_max = -0.15,
	rarity = 50,
	max_count = 10,
}
]]--

--  -- Coconuts can't be generated as fruit, because there is no support for the
--  -- special fruit trunks that allow coconuts to regrow at the correct position
--  -- in the tree.
--  -- So, a placeholder fruit trunk is spawned. An ABM will convert it to the final
--  -- fruit trunk, and generate the actual coconuts.
--  moretrees.palm_model={
--      axiom="FFcccccc&FFFFFdddRA//A//A//A//A//A",
--      rules_a="[&fb&bbb[++f--&ffff&ff][--f++&ffff&ff]&ffff&bbbb&b]",
--      rules_b="f",
--      rules_c="/",
--      rules_d="F",
--      trunk="moretrees:palm_trunk",
--      leaves="moretrees:palm_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=true,
--      fruit="moretrees:palm_fruit_trunk_gen",
--      fruit_chance=0
--  }

--[[
-- Make the cocos palm fruit trunk a real trunk (it is generated as a fruit)
local trunk = minetest.registered_nodes["moretrees:palm_trunk"]
local ftrunk = {}
local gftrunk = {}
for k,v in pairs(trunk) do
	ftrunk[k] = v
	gftrunk[k] = v
end
ftrunk.tiles = {}
gftrunk.tiles = {}
for k,v in pairs(trunk.tiles) do
	ftrunk.tiles[k] = v
	gftrunk.tiles[k] = v
end
ftrunk.drop = "moretrees:palm_trunk"
gftrunk.drop = "moretrees:palm_trunk"
ftrunk.after_destruct = function(pos, oldnode)
	local coconuts = minetest.find_nodes_in_area(
		{x=pos.x-1, y=pos.y, z=pos.z-1},
		{x=pos.x+1, y=pos.y, z=pos.z+1},
		{"group:moretrees_coconut"}
	)
	for _,coconutpos in pairs(coconuts) do
		-- minetest.dig_node(coconutpos) does not cause nearby coconuts to be dropped :-( ...
		--minetest.dig_node(coconutpos)
		local items = minetest.get_node_drops(minetest.get_node(coconutpos).name)
		minetest.swap_node(coconutpos, biome_lib.air)
		for _, itemname in pairs(items) do
			minetest.add_item(coconutpos, itemname)
		end
	end
end
-- Make the different trunk types distinguishable (but barely)
ftrunk.tiles[1] = "moretrees_palm_trunk_top.png^[transformR90"
gftrunk.tiles[1] = "moretrees_palm_trunk_top.png^[transformR180"
gftrunk.description = gftrunk.description.." (gen)"
minetest.register_node("moretrees:palm_fruit_trunk", ftrunk)
minetest.register_node("moretrees:palm_fruit_trunk_gen", gftrunk)
]]--

--[[
-- Spawn initial coconuts
-- (Instead of coconuts, a generated-palm fruit trunk is generated with the tree. This
--  ABM converts the trunk to a regular fruit trunk, and spawns some coconuts)
minetest.register_abm({
	nodenames = { "moretrees:palm_fruit_trunk_gen" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.swap_node(pos, {name="moretrees:palm_fruit_trunk"})
		local poslist = minetest.find_nodes_in_area(
			{x=pos.x-1, y=pos.y, z=pos.z-1},
			{x=pos.x+1, y=pos.y, z=pos.z+1},
			"air"
		)
		local genlist = {}
		for k,v in pairs(poslist) do
			genlist[k] = {x = math.random(100), pos = v}
		end
		table.sort(genlist, function(a, b) return a.x < b.x; end)
		local count = 0
		for _, gen in pairs(genlist) do
			minetest.swap_node(gen.pos, {name = "moretrees:coconut_3"})
			count = count + 1
			if count == 4 then
				break
			end
		end
	end,
})
]]--
