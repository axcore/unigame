---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    underch
-- Code:    CC0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- creates hay when digging dirt_with_grass (thanks to the override above);
-- useful for digging hay and straw
-- can be placed as a node
minetest.register_tool("cottages:pitchfork", {
	description = S("pitchfork (dig dirt with grass to get hay, place with right-click)"),
	groups = {},
	inventory_image = "cottages_pitchfork.png",
	wield_image = "cottages_pitchfork.png^[transformFYR180",
	wield_scale = {x=1.5,y=1.5,z=0.5},
	stack_max = 1,
	liquids_pointable = false,
	-- very useful for digging hay, straw and bales of those materials
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[2]=0.80, [3]=0.40}, maxlevel=1, uses=1/0.002 },
			snappy={times={[2]=0.80, [3]=0.40}, maxlevel=1, uses=1/0.002 },
			hay   ={times={[2]=0.10, [3]=0.10}, maxlevel=1, uses=1/0.002 },
		},
                damage_groups = {fleshy=5}, -- slightly stronger than a stone sword
	},
	sound = {breaks = "default_tool_breaks"},
	-- place the pitchfork somewhere
	on_place = function(itemstack, placer, pointed_thing)
		if( placer == nil or pointed_thing == nil or pointed_thing.type ~= "node") then
			return nil
		end
		local pos  = minetest.get_pointed_thing_position( pointed_thing, 1 )
		local node = minetest.get_node_or_nil( pos )
		if( node == nil or not(node.name) or node.name ~= "air") then
			return nil
		end
		if minetest.is_protected(pos, placer:get_player_name()) then
			return nil
		end
		minetest.rotate_and_place(ItemStack("cottages:pitchfork_placed"), placer, pointed_thing)
		-- did the placing succeed?
		local nnode = minetest.get_node(pos)
		if( not(nnode) or not(nnode.name) or nnode.name ~= "cottages:pitchfork_placed") then
			return nil
		end
		local meta = minetest.get_meta(pos)
		meta:set_int( "wear", itemstack:get_wear())
		meta:set_string("infotext", S("pitchfork (for hay and straw)"))
		-- the tool has been placed; consume it
		return ItemStack("")
	end,
})
minetest.register_craft({
        output = 'cottages:pitchfork',
        recipe = {
                { 'default:stick','default:stick','default:stick' },
                { '','default:stick', '' },
                { '','default:stick','' },
        }
})

-- a ptichfork placed somewhere
minetest.register_node("cottages:pitchfork_placed", {
	description = S("pitchfork (for hay and straw)"),
	tiles = {"default_wood.png^[transformR90"}, --default_tree.png"},
	drawtype = "nodebox",
	paramtype  = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy = 2, dig_immediate = 3, falling_node = 1, attached_node = 1, not_in_creative_inventory=1},
	sounds = cottages.sounds.wood,
	node_box = {
		type = "fixed",
		fixed = {
			-- handle (goes a bit into the ground)
			{ -(1/32), -(11/16), -(1/32),  (1/32), 16/16, (1/32)},
			-- middle connection
			{ -(7/32),  -(4/16), -(1/32),  (7/32), -(2/16), (1/32)},
			-- thongs
			{ -(7/32), -(11/16), -(1/32), -(5/32), -(4/16), (1/32)},
			{  (5/32), -(11/16), -(1/32),  (7/32), -(4/16), (1/32)},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.3, -0.5, -0.1, 0.3, 1.0, 0.1 }
	},
	drop = "cottages:pitchfork",
	-- perserve wear
	preserve_metadata = function(pos, oldnode, oldmeta, drops)
		if(oldmeta["wear"]) then
			-- the first drop is the pitchfork
			drops[1]:set_wear(oldmeta["wear"])
		end
	end,
})

-- If default:dirt_with_grass is digged while wielding a pitchfork, it will
-- turn into dirt and get some hay placed above it.
-- The hay will disappear (decay) after a couple of minutes.
if(     minetest.registered_items["default:dirt_with_grass"]
    and minetest.registered_tools["cottages:pitchfork"]) then
  minetest.override_item("default:dirt_with_grass", {
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if( not( pos ) or not( digger )) then
			return
		end
		local wielded = digger:get_wielded_item()
		if(    not( wielded )
		    or not( wielded:get_name() )
		    or (wielded:get_name()~="cottages:pitchfork")) then
			return
		end

		local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
		local node_above = minetest.get_node_or_nil( pos_above)
		if( not(node_above) or not(node_above.name) or node_above.name ~= "air" ) then
			return nil
		end
		minetest.swap_node( pos,       {name="default:dirt"})
		minetest.add_node(  pos_above, {name="cottages:hay_mat", param2=math.random(2,25)}) 
		-- start a node timer so that the hay will decay after some time
		local timer = minetest.get_node_timer(pos_above)
		if not timer:is_started() then
			timer:start(math.random(60, 300))
		end
		-- TODO: prevent dirt from beeing multiplied this way (that is: give no dirt!)
		return
	end,
  })
end
]]--
