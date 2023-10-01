---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    fireextinguisher
-- Code:    LGPL 2.1
-- Media:   LGPL 2.1/WTFPL/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
fireextinguisher.replace = function(pos, node, repl)
	--minetest.env:set_node(pos, {name=repl.node, param1=0, param2=repl.param2})
	minetest.set_node(pos, {name=repl.node, param1=0, param2=repl.param2})   --MIO

	if ( node ~= nil and node.name == 'fire:basic_flame' ) then
		--fire.on_flame_remove_at(flames[i])		
		minetest.sound_play("fire_extinguish_flame",{pos = pos, max_hear_distance = 16, gain = 0.15}) --MIO
	end
end

fireextinguisher.propagate = function(pos, node, replacementnodename, life) 
	if ( target.name == 'fire:basic_flame' ) then
		--minetest.env:remove_node(pos)
		minetest.remove_node(pos)   --MIO
		--fire.on_flame_remove_at(pos)
		minetest.sound_play("fire_extinguish_flame",{pos = pos, max_hear_distance = 16, gain = 0.15})  --MIO
	end

	--minetest.env:set_node(pos, {name=replacementnodename, param1=14, param2=life-1})
	minetest.set_node(pos, {name=replacementnodename, param1=14, param2=life-1})   --MIO
end

fireextinguisher.run = function(pos, node, targettypes, replacement, lifespan, poisontypes)
	life = node.param2

	if ( life == 0 ) then
		fireextinguisher.replace(pos, nil, replacement)
		return
	end

	poisoned = false
	if ( poisontypes ~= nil ) then
		--poisoned = minetest.env:find_node_near(pos, 1, poisontypes) ~= nil
		poisoned = minetest.find_node_near(pos, 1, poisontypes) ~= nil   --MIO
	end

	ignoreAdjacentNodeFound = false
	propagated = false

	if ( not poisoned ) then
		--targets = minetest.env:find_nodes_in_area({x=pos.x-1, y=pos.y-1, z=pos.z-1}, {x=pos.x+1, y=pos.y+1, z=pos.z+1}, targettypes)
		targets = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y-1, z=pos.z-1}, {x=pos.x+1, y=pos.y+1, z=pos.z+1}, targettypes)   --MIO
		for i=1,#targets do
			--target = minetest.env:get_node(targets[i])
			target = minetest.get_node(targets[i])   --MIO
			if ( target.name ~= 'ignore' ) then
				fireextinguisher.propagate(targets[i], target, node.name, life)
				propagated = true;
			else
				ignoreAdjacentNodeFound = true
			end
		end
	end
	if ( ignoreAdjacentNodeFound == false or poisoned ) then
		if ( propagated or life ~= lifespan ) then
			fireextinguisher.replace(pos, nil, replacement)
		else
			--minetest.env:set_node(pos, {name='air', param1=0, param2=0})
			minetest.set_node(pos, {name='air', param1=0, param2=0})   --MIO
		end
	end
end

fireextinguisher.fireextinguisher_abm=function(pos, node, active_object_count, active_object_count_wider)
	minetest.sound_play("fireextinguisher_hiss", {pos = pos, gain = 1.3, max_hear_distance = fireextinguisher.retardantcat_lifespan*3})
	node =  {name="fireextinguisher:retardantcat", param1=14, param2=fireextinguisher.retardantcat_lifespan}
	--minetest.env:set_node(pos, node)
	minetest.set_node(pos, node)   --MIO
	fireextinguisher.retardantcat_abm(pos, node, nil, nil)
end

fireextinguisher.retardantcat_abm=function(pos, node, active_object_count, active_object_count_wider)
	fireextinguisher.run(pos, node, fireextinguisher.retardantcat_targets, fireextinguisher.retardant_replacement, fireextinguisher.retardantcat_lifespan, fireextinguisher.retardantcat_poisons)
end

fireextinguisher.retardantcleanercat_abm=function(pos, node, active_object_count, active_object_count_wider)
	fireextinguisher.run(pos, node, fireextinguisher.retardantcleanercat_targets, fireextinguisher.retardantcleanercat_replacement, fireextinguisher.retardantcleanercat_lifespan, fireextinguisher.retardantcleanercat_poisons)
end

fireextinguisher.retardant_abm=function(pos, node, active_object_count, active_object_count_wider)
	--flames = minetest.env:find_nodes_in_area({x=pos.x-1, y=pos.y-1, z=pos.z-1}, {x=pos.x+1, y=pos.y+1, z=pos.z+1}, {'fire:basic_flame'})
	flames = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y-1, z=pos.z-1}, {x=pos.x+1, y=pos.y+1, z=pos.z+1}, {'fire:basic_flame'})   --MIO
	for i=1,#flames do
			if node.param2 > 0 then
				--minetest.env:set_node(flames[i], {name=node.name, param1=14, param2=node.param2-1})
				minetest.set_node(flames[i], {name=node.name, param1=14, param2=node.param2-1})   --MIO
			else
				--minetest.env:remove_node(flames[i])
				minetest.remove_node(flames[i])   --MIO
			end
			
	end
	for i=1,#flames do
			--fire.on_flame_remove_at(flames[i])
            minetest.sound_play("fire_extinguish_flame",{pos = pos, max_hear_distance = 16, gain = 0.15}) --MIO
	end
end

fireextinguisher.retardant_evaporate_abm=function(pos, node, active_object_count, active_object_count_wider)
	--retardant_or_air = minetest.env:find_nodes_in_area(
	retardant_or_air = minetest.find_nodes_in_area(   --MIO
		{x=pos.x-1, y=pos.y-1, z=pos.z-1}, 
		{x=pos.x+1, y=pos.y+1, z=pos.z+1}, 
		{'air', 'fireextinguisher:fireretardant', 'default:lava_source', 'default:lava_flowing'})
	if ( #retardant_or_air == 27 ) then
		below = {x=pos.x, y=pos.y-1, z=pos.z}
		--if ( minetest.env:get_node(below).name == 'air' and node.param2 > 0 ) then
		if ( minetest.get_node(below).name == 'air' and node.param2 > 0 ) then   --MIO
			--minetest.env:set_node(below, {name=node.name, param1=node.param1, param2=node.param2-1})
			minetest.set_node(below, {name=node.name, param1=node.param1, param2=node.param2-1})   --MIO
		end
		--minetest.env:set_node(pos, {name='air', param1=0, param2=0})
		minetest.set_node(pos, {name='air', param1=0, param2=0})   --MIO
	end	
end

minetest.register_node("fireextinguisher:fireextinguisher", {
	description = "Automatic Fire Extinguisher",
	--tile_images ={"fireextinguisher.png"},
	tiles = {"fireextinguisher.png"},  --MIO
	paramtype = "light",
	paramtype2 = "none",
	drawtype = "plantlike",
	groups = {oddly_breakable_by_hand=1},
	pointable = true,
	diggable = true,
	damage_per_second = 0,
})
minetest.register_craft({
	output = 'fireextinguisher:fireextinguisher',
	recipe = {
		{'bucket:bucket_water', 'default:torch', 'default:mese'},
		{'', 'default:steel_ingot', ''},
		{'', '', ''},
	},
	replacements = { {'bucket:bucket_water', 'bucket:bucket_empty'} }
})

minetest.register_node("fireextinguisher:fireretardant", {
	description = "Fire Retardant Foam",
	--tile_images ={"retardant.png"},
	tiles = {"retardant.png"},   --MIO
	paramtype = "light",
	paramtype2 = "none",
	drawtype = "plantlike",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {dig_immediate=3, oddly_breakable_by_hand=3, puts_out_fire=1},
	pointable = true,
	diggable = true,
	damage_per_second = 0,
	after_place_node = function(pos, placer)
		--minetest.env:set_node(pos, {name="fireextinguisher:fireretardant", param1=14, param2=fireextinguisher.retardant_strength})
		minetest.set_node(pos, {name="fireextinguisher:fireretardant", param1=14, param2=fireextinguisher.retardant_strength}) --MIO
	end
})

minetest.register_node("fireextinguisher:retardantcat", {
	description = "Fire Retardant Foam Spray",
	--tile_images ={"retardantc.png"},
	tiles = {"retardantc.png"},   --MIO
	paramtype = "light",
	paramtype2 = "none",
	groups = {immortal=1, puts_out_fire=1},
	walkable = false,
	drawtype = "glasslike",
	sunlight_propagates = true,
	pointable = false,
	diggable = false,
	damage_per_second = 0,
})

minetest.register_node("fireextinguisher:retardantcleanercat", {
	description = "Fire Retardant Foam Cleaner",
	--tile_images ={"retardantcc.png"},
	tiles = {"retardantcc.png"},   --MIO
	paramtype = "light",
	paramtype2 = "none",
	walkable = false,
	groups = {immortal=1},
	drawtype = "glasslike",
	sunlight_propagates = true,
	pointable = false,
	diggable = false,
	damage_per_second = 0,
	after_place_node = function(pos, node, active_object_count, active_object_count_wider) 
		--minetest.env:set_node(pos, {name="fireextinguisher:retardantcleanercat", param1=14, param2=fireextinguisher.retardantcleanercat_lifespan})	
		minetest.set_node(pos, {name="fireextinguisher:retardantcleanercat", param1=14, param2=fireextinguisher.retardantcleanercat_lifespan})	 --MIO
	end
})
minetest.register_craft({
	output = 'fireextinguisher:retardantcleanercat',
	recipe = {
		{'fireextinguisher:fireretardant', 'fireextinguisher:fireretardant', 'fireextinguisher:fireretardant'},
		{'default:torch', 'default:torch', 'default:torch'},
		{'', '', ''},
	}
})

minetest.register_abm({
	nodenames = {"fireextinguisher:fireextinguisher"},
	neighbors = {"default:lava_source", "default:lava_flowing", "fire:basic_flame"},
	interval = 0.05,
	chance = 1,
	action = fireextinguisher.fireextinguisher_abm
})

minetest.register_abm({
	nodenames = {"fireextinguisher:fireretardant"},
	neighbors = {"fire:basic_flame"},
	interval = 0.03,
	chance = 1,
	action = fireextinguisher.retardant_abm
})

minetest.register_abm({
	nodenames = {"fireextinguisher:fireretardant"},
	neighbors = {"air"},
	interval = 1,
	chance = 2,
	action = fireextinguisher.retardant_evaporate_abm
})

minetest.register_abm(
	{nodenames = {"fireextinguisher:retardantcat"},
	interval = 0.01,
	chance = 3,
	action = fireextinguisher.retardantcat_abm
})

minetest.register_abm(
	{nodenames = {"fireextinguisher:retardantcleanercat"},
	interval = 0.3,
	chance = 2,
	action = fireextinguisher.retardantcleanercat_abm
})
]]--
