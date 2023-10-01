---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
	minetest.register_node("lib_ecology:plant_kelp_01", {
		description = S("Plant - Kelp 01"),
		drawtype = "plantlike_rooted",
		tiles = {"default_sand.png"},
		special_tiles = {{name = "lib_ecology_plant_kelp_01.png", tileable_vertical = true}},
		inventory_image = "lib_ecology_plant_kelp_01.png",
		wield_image = "lib_ecology_plant_kelp_01.png",
		paramtype = "light",
		paramtype2 = "leveled",
		buildable_to = true, 
		is_ground_content = false,
		sunlight_propagates = true,
		walkable = false,
		waving = 1,
		node_dig_prediction = "lib_ecology:plant_kelp_01",
		node_placement_prediction = "lib_ecology:plant_kelp_01",
		groups = {snappy = 3, sea=1, plant = 1, attached_node = 1, growing = 1,},
		sounds = lib_ecology.node_sound_sand_defaults({
			dig = {name = "default_dig_snappy", gain = 0.2},
			dug = {name = "default_grass_footstep", gain = 0.25},
		}),
		selection_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
			},
		},

		on_use = minetest.item_eat(1),

		on_place = function(itemstack, placer, pointed_thing)
			-- Call on_rightclick if the pointed node defines it
			if pointed_thing.type == "node" and placer and
					not placer:get_player_control().sneak then
				local node_ptu = minetest.get_node(pointed_thing.under)
				local def_ptu = minetest.registered_nodes[node_ptu.name]
				if def_ptu and def_ptu.on_rightclick then
					return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
						itemstack, pointed_thing)
				end
			end

			local pos = pointed_thing.under
			if minetest.get_node(pos).name ~= "default:sand" then
				return itemstack
			end

			local height = math.random(4, 6)
			local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
			local node_top = minetest.get_node(pos_top)
			local def_top = minetest.registered_nodes[node_top.name]
			local player_name = placer:get_player_name()

			if def_top and def_top.liquidtype == "source" and
					minetest.get_item_group(node_top.name, "water") > 0 then
				if not minetest.is_protected(pos, player_name) and
						not minetest.is_protected(pos_top, player_name) then
					minetest.set_node(pos, {name = "lib_ecology:plant_kelp_01",
						param2 = height * 16})
					if not (creative and creative.is_enabled_for
							and creative.is_enabled_for(player_name)) then
						itemstack:take_item()
					end
				else
					minetest.chat_send_player(player_name, "Node is protected")
					minetest.record_protection_violation(pos, player_name)
				end
			end

			return itemstack
		end,

		after_destruct  = function(pos, oldnode)
			minetest.set_node(pos, {name = "default:sand"})
		end
	})
]]--
