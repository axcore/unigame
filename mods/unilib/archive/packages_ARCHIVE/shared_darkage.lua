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
function darkage.register_reinforce(name, craftItem, nodedef)
	assert(type(nodedef.tiles)=="table","ERRROR: nodedef.tiles have to be a table")
	assert(nodedef.tiles[1], "ERROR: "..dump(nodedef.tiles).." requires at least 1 entry")

	if nodedef.groups then
		nodedef.groups["not_cuttable"] = 1;
	else 
		nodedef.groups = {};
		nodedef.groups["not_cuttable"] = 1;
	end

	local modname = minetest.get_current_modname();
	local tname = string.gsub(name:lower()," ", "_"); -- Technical name

-- Reinforced X
	local reinforced = table.copy(nodedef);
	local reinforced_tname = modname..":reinforced_"..tname
	reinforced.description = "Reinforced "..name
	for i,tile in ipairs(reinforced.tiles) do
		reinforced.tiles[i] = tile .."^darkage_reinforce.png"
	end

	minetest.register_node(reinforced_tname, reinforced)

	minetest.register_craft({
		output = reinforced_tname,
		recipe = {
			{"group:stick",	craftItem, 		"group:stick"},
			{craftItem,		"group:stick", 	craftItem},
			{"group:stick",	craftItem, 		"group:stick"},
		}
	})
	-- Recycling
	minetest.register_craft({
		output = craftItem,
		recipe = {
			{ reinforced_tname },
		}
	})

-- Reinforced Slope
	local slope = table.copy(nodedef);
	local slope_tname = modname..":reinforced_"..tname.."_slope"
	slope.description = "Reinforced "..name.." Slope\nHint: use the screwdriver to rotate."
	slope.paramtype2 = "facedir";
	local slope_tile_extend = {"^darkage_reinforce_right.png" , "^darkage_reinforce_right.png" , --top ,down
			"^darkage_reinforce_right.png" , "^darkage_reinforce_right.png" , --right, left
			"^darkage_reinforce_left.png" , "^darkage_reinforce_left.png"} -- front, back
	for i=1,6 do
		local tile = slope.tiles[i] or nodedef.tiles[1]; -- There have to be at least one tile.
		slope.tiles[i] = tile ..slope_tile_extend[i]	
	end

	minetest.register_node(slope_tname, slope)

	minetest.register_craft({
		output = slope_tname,
		recipe = {
			{craftItem,		craftItem,		"group:stick"},
			{craftItem,		"group:stick",	craftItem},
			{"group:stick",	craftItem,		craftItem},
		}
	})
	-- Flipped recipe
	minetest.register_craft({
		output = slope_tname,
		recipe = {
			{"group:stick",	craftItem,		craftItem},
			{craftItem,		"group:stick",	craftItem},
			{craftItem,		craftItem,		"group:stick"},
		}
	})
	-- Recycling
	minetest.register_craft({
		output = craftItem,
		recipe = {
			{ slope_tname }
		}
	})

	-- Alias to convert old nodes
	minetest.register_alias(modname..":reinforced_"..tname.."_right", slope_tname)
	minetest.register_alias(modname..":reinforced_"..tname.."_left", slope_tname)

-- Arrow bar
	local arrow = table.copy(nodedef)
	local arrow_tname = modname..":reinforced_"..tname.."_arrow"
	arrow.paramtype2 = "facedir";
	arrow.description = "Reinforced "..name.." Arrow \nHint: use the screwdriver to rotate."
	local arrow_tile_extend = {"" , "" , --top ,down
			"^(darkage_reinforce_arrow.png^[transformR90)" , "^(darkage_reinforce_arrow.png^[transformR270)" , --right, left
			"^(darkage_reinforce_arrow.png^[transformR180)" , "^darkage_reinforce_arrow.png"} -- front, back
	for i=1,6 do
		local tile = arrow.tiles[i] or arrow.tiles[1]; -- There have to be at least one tile.
		arrow.tiles[i] = tile .. arrow_tile_extend[i]
	end
	minetest.register_node(arrow_tname, arrow)

	minetest.register_craft({
		output = arrow_tname,
		recipe = {
			{craftItem, 	"group:stick",	craftItem},
			{"group:stick",	 craftItem, 	"group:stick"},
			{"group:stick",	 craftItem, 	"group:stick"},
		}
	})
	-- Recycling
	minetest.register_craft({
		output = craftItem,
		recipe = {
			{ arrow_tname }
		}
	})

-- Reinforced Bars
	local bars = table.copy(nodedef)
	local bars_tname = modname..":reinforced_"..tname.."_bars"
	bars.description = name.." Bars"
	for i,tile in ipairs(bars.tiles) do
		bars.tiles[i] = tile .."^darkage_reinforce_bars.png"
	end
	minetest.register_node(bars_tname, bars)

	minetest.register_craft({
		output = bars_tname,
		recipe = {
			{"group:stick", craftItem, "group:stick"},
			{"group:stick", craftItem, "group:stick"},
			{"group:stick", craftItem, "group:stick"},
		}
	})
	minetest.register_craft({
		output = craftItem,
		recipe = {
			{ bars_tname }
		}
	})
end
]]--
