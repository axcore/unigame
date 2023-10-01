---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pedology
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
pedology = {}
pedology.wetnames = {[0] = "dry",  "wet", "watery", "sludgy", "muddy", "slurry" }

function pedology.ooze(pos, node, active_object_count, active_object_wider)
	local wet = minetest.get_item_group(node.name, "wet")
	if wet == 0 then return end
i
	local neighbors = {
		{	-- neighbor directly below
			{x=pos.x, y=pos.y-1, z=pos.z},
			minwet=1
		},
		
		{	-- touching the lower sides
			{x=pos.x, y=pos.y-1, z=pos.z-1},
			{x=pos.x, y=pos.y-1, z=pos.z+1},
			{x=pos.x-1, y=pos.y-1, z=pos.z},
			{x=pos.x+1, y=pos.y-1, z=pos.z},
			minwet=1
		},
		{	-- touching the lower corners
			{x=pos.x-1, y=pos.y-1, z=pos.z-1},
			{x=pos.x-1, y=pos.y-1, z=pos.z+1},
			{x=pos.x-1, y=pos.y-1, z=pos.z-1},
			{x=pos.x+1, y=pos.y-1, z=pos.z+1},
			{x=pos.x+1, y=pos.y-1, z=pos.z+1},
			minwet=1
		},
		{	-- sides on the same level
			{x=pos.x-1, y=pos.y, z=pos.z}, -- left
			{x=pos.x+1, y=pos.y, z=pos.z}, -- right
			{x=pos.x, y=pos.y, z=pos.z-1}, -- before
			{x=pos.x, y=pos.y, z=pos.z+1}, -- behind
			minwet=2
		},
		{	-- touching at the side on the same level
			{x=pos.x-1, y=pos.y, z=pos.z-1},
			{x=pos.x-1, y=pos.y, z=pos.z+1},
			{x=pos.x+1, y=pos.y, z=pos.z-1},
			{x=pos.x+1, y=pos.y, z=pos.z+1},
			minwet=2
		},
	}

	for i=1,#neighbors do
		for j=1,#neighbors[i] do
			local node = minetest.get_node(neighbors[i][j])
			local name = node.name
			local destwet = minetest.get_item_group(name, "wet")
			if(
				(destwet < wet) and 
				(minetest.get_item_group(name, "sucky") >= 1)) and
				(neighbors[i].minwet <= (wet - destwet)) then
					pedology.wetten(neighbors[i][j])
					pedology.dry(pos)
					return
			end
		end
	end
end

function pedology.suck(pos, node, active_object_count, active_object_wider)
	local wet = minetest.get_item_group(node.name, "wet")

	local score = 0

	-- These three tables contain the positions of all nodes around node
	local neighbors= {
		{ -- sides
		{x=pos.x, y=pos.y-1, z=pos.z}, -- below
		{x=pos.x-1, y=pos.y, z=pos.z}, -- left
		{x=pos.x+1, y=pos.y, z=pos.z}, -- right
		{x=pos.x, y=pos.y+1, z=pos.z}, -- above
		{x=pos.x, y=pos.y, z=pos.z-1}, -- before
		{x=pos.x, y=pos.y, z=pos.z+1}, -- behind
		rating = 1
		},
		{ -- edges
		{x=pos.x, y=pos.y-1, z=pos.z-1},
		{x=pos.x, y=pos.y-1, z=pos.z+1},
		{x=pos.x, y=pos.y+1, z=pos.z-1},
		{x=pos.x, y=pos.y+1, z=pos.z+1},
		{x=pos.x-1, y=pos.y, z=pos.z-1},
		{x=pos.x-1, y=pos.y, z=pos.z+1},
		{x=pos.x+1, y=pos.y, z=pos.z-1},
		{x=pos.x+1, y=pos.y, z=pos.z+1},
		{x=pos.x-1, y=pos.y-1, z=pos.z},
		{x=pos.x-1, y=pos.y+1, z=pos.z},
		{x=pos.x+1, y=pos.y-1, z=pos.z},
		{x=pos.x+1, y=pos.y+1, z=pos.z},
		rating=0.5
		},
		{ -- corners	
		{x=pos.x-1, y=pos.y-1, z=pos.z-1},
		{x=pos.x-1, y=pos.y-1, z=pos.z+1},
		{x=pos.x-1, y=pos.y+1, z=pos.z-1},
		{x=pos.x-1, y=pos.y+1, z=pos.z+1},
		{x=pos.x-1, y=pos.y-1, z=pos.z-1},
		{x=pos.x+1, y=pos.y+1, z=pos.z+1},
		{x=pos.x+1, y=pos.y+1, z=pos.z-1},
		{x=pos.x+1, y=pos.y-1, z=pos.z+1},
		{x=pos.x+1, y=pos.y-1, z=pos.z+1},
		rating=0.25
		}
	}

	for i=1,#neighbors do
		for j=1,#neighbors[i] do
			local neighbor = minetest.get_node(neighbors[i][j])
			local name = neighbor.name
			local water = minetest.get_item_group(name, "water")
			if(water >= 1) then
				score = score + neighbors[i].rating
			end
		end
	end

	local wetten = false
	if(wet == 0 and score >= 1) then
		wetten=true
	elseif(wet == 1 and score >= 2) then
		wetten= true
	elseif(wet == 2 and score >= 3) then
		wetten=true
	elseif(wet == 3 and score >= 5) then
		wetten=true
	elseif(wet == 4 and score >= 8) then
		wetten=true
	elseif(wet == 5 and score >= 11) then
		-- erosion: turn node into water
		-- TODO: Also drop the drops
		minetest.set_node(pos, {name="pedology:water_fresh_source"})
		return
	end

	if(wetten==true) then
		pedology.wetten(pos)
	end
end

function pedology.sun_dry(pos, node, active_object_count, active_object_wider)
	if(minetest.get_item_group(node.name, "wet") < 6) then
		-- don’t dry off if there is water nearby
		if(not minetest.find_node_near(pos, 1, {"group:water"})) then
			local light = minetest.get_node_light(pos, minetest.get_timeofday())
			if light >= pedology.DRY_LIGHT then
				pedology.dry(pos)
			end
		end
	end
end

function pedology.drip_particle(pos, wet)
	local below1 = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
	local below2 = minetest.get_node({x=pos.x, y=pos.y-2, z=pos.z})
	if(below1.name == "air" and below2.name == "air") then
		return minetest.add_particlespawner(
			wet,	-- amount
			0,	-- time
			{ x=pos.x -(45/100), y=pos.y - 0.5, z=pos.z -(45/100) },	-- minpos
			{ x=pos.x +(45/100), y=pos.y - 0.5, z=pos.z +(45/100) },	-- maxpos
			{ x=0, y=0, z=0 }, { x=0, y=0, z=0 }, -- minvel, maxvel
			{ x=0, y=-9.82, z=0 }, { x=0, y=-9.80, z=0 }, -- minacc, maxacc
			1, 3, -- minexptime, maxexptime
			1, 1, -- minsize, maxsize
			false, -- collisiondetection
			"pedology_water_fresh.png" -- texture
			-- playername
)
	else
		return nil
	end
end
 
function pedology.create_drip(pos)
	if minetest.env:get_node({x=pos.x, y=pos.y -1, z=pos.z}).name == "air" and 
	minetest.env:get_node({x=pos.x, y=pos.y -2, z=pos.z}).name == "air" then
		local i = math.random(-45,45) / 100
		minetest.env:add_entity({x=pos.x + i, y=pos.y - 0.5, z=pos.z + i}, "pedology:drop_water")
	end
end

function pedology.register_sucky(basename, description, wetness, oozing, sucky, melting_point, drop, sounds, additional_groups)
	local wetname = basename.."_"..tostring(wetness)
	local noncreative
	local groups = { sucky=sucky, oozing=oozing, wet=wetness, melting_point=melting_point, not_in_creative_inventory = noncreative, [basename]=1 }
	if additional_groups ~= nil then
		for k,v in pairs(additional_groups) do
			groups[k] = v
		end
	end

	local name = "pedology:"..wetname
	local itemname

	-- If the node is not dry, do not add it into the creative inventory
	if wetness == 0 then noncreative = 0 else noncreative = 1 end
	local on_construct, on_destruct
	if pedology.USE_DRIPS == 2 then
		on_construct = function(pos)
			local dripper = pedology.drip_particle(pos, wetness)
			if(dripper ~= nil) then
				local meta = minetest.get_meta(pos)
				meta:set_int("dripper", dripper)
			end
		end
		on_destruct = function(pos)
			local meta = minetest.get_meta(pos)
			local dripper = meta:get_int("dripper")
			if(dripper ~= nil) then
				minetest.delete_particlespawner(dripper)
			end
		end
	else
		on_construct, on_destruct = nil
	end
	local nodedef = {
		description = S(description),
		inventory_image = minetest.inventorycube("pedology_"..wetname..".png"),
		tiles = {"pedology_"..wetname..".png"},
		paramtype = "light",
		drop = drop,
		groups = groups,
		sounds = sounds,
		is_ground_content = true,
		on_construct = on_construct,
		on_destruct = on_destruct,
	}
	minetest.register_node(name, nodedef)

end

function pedology.register_sucky_group(basename, basedescription, lumpbasedescription, maxwet, maxlump, oozeinterval, oozechance, melttable, dropcount, sounds, additional_groups)
	local sucky, oozing, dripinterval
	local m -- melting_point
	local lumpdescription 
	local groups
	local nestedgroups = false
	if(type(additional_groups) == "table") then
		if(type(additional_groups[0]) == "table") then
			nestedgroups = true
		end
	end

	for w=0, maxwet do
		if(w==0) then oozing=0 else oozing=1 end
		if (w==maxwet and w ~= 5) then sucky=0 else sucky=1 end
		if melttable == nil then m = 0 else m = melttable[w] end
		if( lumpbasedescription ~= nil) then
			lumpdescription = S((pedology.wetnames[w]).." "..lumpbasedescription)
		else
			lumpdescription = nil
		end

		local itemname, drop, itemdef
		if( maxlump == -1) then
			drop = nil
		elseif( w > maxlump) then
			itemname = "pedology:lump_"..basename.."_"..tostring(maxlump)
			drop = itemname .. " " .. tostring(dropcount)
		else
			itemname = "pedology:lump_"..basename.."_"..tostring(w)
			drop = itemname .. " " .. tostring(dropcount)
			itemdef = {
				description = S(lumpdescription),
				inventory_image = "pedology_lump_inv_"..basename.."_"..tostring(w)..".png",
				wield_image = "pedology_lump_"..basename.."_"..tostring(w)..".png"
			}
			minetest.register_craftitem("pedology:lump_"..basename.."_"..tostring(w), itemdef)
		end
		if(nestedgroups) then
			groups = additional_groups[w]
		else
			groups = additional_groups
		end
		if(w==3) then
			groups["disable_jump"] = 1
		end
		pedology.register_sucky(basename, S((pedology.wetnames[w]).." "..basedescription), w, oozing, sucky, m, drop, sounds, groups)
		-- register dripping
		if(w>0 and pedology.USE_DRIPS == 1) then
			minetest.register_abm({
				nodenames = {"pedology:"..basename.."_"..tostring(w)},
				neighbors = {"air"},
				interval = math.max(oozeinterval/4,2),
				chance = math.max(oozechance,22),
				action = pedology.create_drip,
			})
		end
	end
	if(maxwet > 0) then
		minetest.register_abm({
			nodenames = {"group:"..basename},
			neighbors = {"group:sucky"},
			interval = oozeinterval,
			chance = oozechance,
			action = pedology.ooze,
		})

	end
end

function pedology.register_liquid(basename, description, alpha, viscosity, drowning, damage_per_second, post_effect_color, additional_groups)
	local flowing_groups = {wet=6,liquid=1,not_in_creative_inventory=1}
	local source_groups = {wet=6,liquid=1}
	for k,v in pairs(additional_groups) do
		flowing_groups[k] = v
		source_groups[k] = v
	end

	local tile = "pedology_"..basename..".png"
	local nodedef_source = {
	description = S(description.." source"),
	inventory_image = minetest.inventorycube(tile),
	tiles = {tile},
	special_tiles = {{name=tile, backface_culling=false}},
	alpha = alpha,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	liquid_alternative_flowing = "pedology:"..basename.."_flowing",
	liquid_alternative_source = "pedology:"..basename.."_source",
	liquid_viscosity = viscosity,
	post_effect_color = post_effect_color,
	drowning = drowning,
	damage_per_second = damage_per_second,

	drawtype = "liquid",
	liquidtype = "source",
	groups = source_groups,
	}
	minetest.register_node("pedology:"..basename.."_source", nodedef_source)

	local nodedef_flowing = {
	description = S("flowing "..description),
	inventory_image = minetest.inventorycube(tile),
	tiles = {tile},
	special_tiles = {{name=tile, backface_culling=false}, {name=tile, backface_culling=true}},
	alpha = alpha,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	liquid_alternative_flowing = "pedology:"..basename.."_flowing",
	liquid_alternative_source = "pedology:"..basename.."_source",
	liquid_viscosity = viscosity,
	post_effect_color = post_effect_color,
	drowning = drowning,
	damage_per_second = damage_per_second,

	drawtype = "flowingliquid",
	liquidtype = "flowing",
	groups = flowing_groups,
	paramtype2 = "flowingliquid",
	}

	minetest.register_node("pedology:"..basename.."_flowing", nodedef_flowing)

end

function pedology.dry(pos)
	local node = minetest.get_node(pos)
	local wet = minetest.get_item_group(node.name, "wet")
	local dried = tostring(wet - 1)
	if wet <= 0 then
		return
	end
	local newbasename = string.sub(node.name,1,#node.name-1)
	newbasename = newbasename .. dried
	minetest.set_node(pos, {name=newbasename, param1=0, param2=0})
end

function pedology.wetten(pos)
	local node = minetest.get_node(pos)
	local wet = minetest.get_item_group(node.name, "wet")
	local cutbasename = string.sub(node.name,10,#node.name-2)
	if pedology.maxwet[cutbasename] == nil then
		return
	elseif wet > pedology.maxwet[cutbasename] then
		return
	end
	
	local newbasename = string.sub(node.name,1,#node.name-1) .. tostring(wet+1)
	minetest.set_node(pos, {name=newbasename, param1=0, param2=0})
end

minetest.register_abm({
	nodenames = {"group:sun_dry"},
	neighbors = {"air"},
	interval = 30,
	chance = 10,
	action = pedology.sun_dry,
})

minetest.register_abm({
	nodenames = {"group:sucky"},
	neighbors = {"group:water"},
	interval = 30,
	chance = 1,
	action = pedology.suck,
})

minetest.register_entity("pedology:drop_water", {
	hp_max = 2000,
	physical = true,
	collisionbox = {0,0,0,0,0,0},
	visual = "cube",
	visual_size = {x=0.05, y=0.1},
	textures = {"pedology_water_fresh.png", "pedology_water_fresh.png", "pedology_water_fresh.png", "pedology_water_fresh.png", "pedology_water_fresh.png", "pedology_water_fresh.png"},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},

	on_activate = function(self, staticdata)
		self.object:setsprite({x=0,y=0}, 1, 1, true)
	end,

	on_step = function(self, dtime)
	local k = math.random(1,222)
	local ownpos = self.object:getpos()

	if k==1 then
	self.object:setacceleration({x=0, y=-5, z=0})
	end

	if minetest.env:get_node({x=ownpos.x, y=ownpos.y +0.5, z=ownpos.z}).name == "air" then
	self.object:setacceleration({x=0, y=-5, z=0})
	end
	
		if minetest.env:get_node({x=ownpos.x, y=ownpos.y -0.5, z=ownpos.z}).name ~= "air" then
		self.object:remove()
		minetest.sound_play({name="pedology_drip"}, {pos = ownpos, gain = 0.5, max_hear_distance = 8})
		end
	end,
})
]]--
