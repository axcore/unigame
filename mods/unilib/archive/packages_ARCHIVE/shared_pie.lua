---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- eat pie slice function
local function replace_pie(node, puncher, pos)

	-- is this my pie?
	if minetest.is_protected(pos, puncher:get_player_name()) then
		return
	end

	-- which size of pie did we hit?
	local pie = node.name:sub(1,-3)
	local num = tonumber(node.name:sub(-1))

	-- are we using crystal shovel to pick up full pie using soft touch?
	local tool = puncher:get_wielded_item():get_name()
	if num == 0 and tool == "ethereal:shovel_crystal" then

		local inv = puncher:get_inventory()

		minetest.remove_node(pos)

		if inv:room_for_item("main", {name = pie .. "_0"}) then
			inv:add_item("main", pie .. "_0")
		else
			pos.y = pos.y + 0.5
			minetest.add_item(pos, {name = pie .. "_0"})
		end

		return
	end

	-- eat slice or remove whole pie
	if num == 3 then
		node.name = "air"
	elseif num < 3 then
		node.name = pie .. "_" .. (num + 1)
	end

	minetest.swap_node(pos, node)

	if num == 3 then
		minetest.check_for_falling(pos)
	end

	-- default eat sound
	local sound = "default_dig_crumbly"

	-- Blockmen's hud_hunger mod
	if hmod then

		local h = hunger.read(puncher)

		h = math.min(h + 4, 30)

		local ok = hunger.update_hunger(puncher, h)

		sound = "hunger_eat"

	-- Wuzzy's hbhunger mod
	elseif hbmod then

		local h = tonumber(hbhunger.hunger[puncher:get_player_name()])

		h = math.min(h + 4, 30)

		hbhunger.hunger[puncher:get_player_name()] = h

		sound = "hbhunger_eat_generic"

	-- Sofar's stamina mod
	elseif stmod then

		stamina.change(puncher, 4)

		sound = "stamina_eat"

	-- mineclone2 mcl_hunger mod
	elseif mclhunger then

		local h = mcl_hunger.get_hunger(puncher)

		h = math.min(h + 4, 20)

		mcl_hunger.set_hunger(puncher, h)

		sound = "mcl_hunger_bite"

	-- none of the above found? add to health instead
	else

		local h = puncher:get_hp()

		h = math.min(h + 4, 20)

		puncher:set_hp(h)
	end

	minetest.sound_play(sound, {pos = pos, gain = 0.7, max_hear_distance = 5}, true)
end

-- register pie bits
pie.register_pie = function(pie, desc)

	-- full pie
	minetest.register_node(":pie:" .. pie .. "_0", {
		description = desc,
		paramtype = "light",
		paramtype2 = "facedir",
		use_texture_alpha = "clip",
		sunlight_propagates = false,
		tiles = {
			pie .. "_top.png", pie .. "_bottom.png", pie .. "_side.png",
			pie .. "_side.png", pie .. "_side.png", pie .. "_side.png"
		},
		inventory_image = pie .. "_inv.png",
		wield_image = pie .. "_inv.png",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.45, -0.5, -0.45, 0.45, 0, 0.45}
		},
		sounds = cake_sound,

		on_rotate = screwdriver_exists and screwdriver.rotate_simple,

		on_punch = function(pos, node, puncher, pointed_thing)
			replace_pie(node, puncher, pos)
		end
	})

	-- 3/4 pie
	minetest.register_node(":pie:" .. pie .. "_1", {
		description = "3/4 " .. desc,
		paramtype = "light",
		paramtype2 = "facedir",
		use_texture_alpha = "clip",
		sunlight_propagates = true,
		tiles = {
			pie .. "_top.png", pie .. "_bottom.png", pie .. "_side.png",
			pie .. "_side.png", pie .. "_side.png", pie .. "_inside.png"
		},
		groups = {not_in_creative_inventory = 1},
		drop = {},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.45, -0.5, -0.25, 0.45, 0, 0.45}
		},
		sounds = cake_sound,

		on_rotate = screwdriver_exists and screwdriver.rotate_simple,

		on_punch = function(pos, node, puncher, pointed_thing)
			replace_pie(node, puncher, pos)
		end
	})

	-- 1/2 pie
	minetest.register_node(":pie:" .. pie .. "_2", {
		description = "Half " .. desc,
		paramtype = "light",
		paramtype2 = "facedir",
		use_texture_alpha = "clip",
		sunlight_propagates = true,
		tiles = {
			pie .. "_top.png", pie .. "_bottom.png", pie .. "_side.png",
			pie .. "_side.png", pie .. "_side.png", pie .. "_inside.png"
		},
		groups = {not_in_creative_inventory = 1},
		drop = {},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.45, -0.5, 0.0, 0.45, 0, 0.45}
		},
		sounds = cake_sound,

		on_rotate = screwdriver_exists and screwdriver.rotate_simple,

		on_punch = function(pos, node, puncher, pointed_thing)
			replace_pie(node, puncher, pos)
		end
	})

	-- 1/4 pie
	minetest.register_node(":pie:" .. pie .. "_3", {
		description = "Piece of " .. desc,
		paramtype = "light",
		paramtype2 = "facedir",
		use_texture_alpha = "clip",
		sunlight_propagates = true,
		tiles = {
			pie .. "_top.png", pie .. "_bottom.png", pie .. "_side.png",
			pie .. "_side.png", pie .. "_side.png", pie .. "_inside.png"
		},
		groups = {not_in_creative_inventory = 1},
		drop = {},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.45, -0.5, 0.25, 0.45, 0, 0.45}
		},
		sounds = cake_sound,

		on_rotate = screwdriver_exists and screwdriver.rotate_simple,

		on_punch = function(pos, node, puncher, pointed_thing)
			replace_pie(node, puncher, pos)
		end
	})
end
]]--
