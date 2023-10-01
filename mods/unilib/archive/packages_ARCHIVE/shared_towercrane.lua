---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    towercrane
-- Code:    LGPL 2.1
-- Media:   CC0/CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[ from init.lua
local function chat(owner, text)
	if owner ~= nil then
		minetest.chat_send_player(owner, "[Tower Crane] "..text)
	end
end

local function formspec(height, width)
	local text = ""
	if height and width then
		text = height..","..width
	end
	return "size[5,4]"..
		"label[0,0;"..S("Construction area size").."]" ..
		"field[1,1.5;3,1;size;height,width;"..text.."]" ..
		"button_exit[1,2;2,1;exit;"..S("Build").."]"
end

local function get_node_lvm(pos)
	local node = minetest.get_node_or_nil(pos)
	if node then
		return node
	end
	local vm = minetest.get_voxel_manip()
	local MinEdge, MaxEdge = vm:read_from_map(pos, pos)
	local data = vm:get_data()
	local param2_data = vm:get_param2_data()
	local area = VoxelArea:new({MinEdge = MinEdge, MaxEdge = MaxEdge})
	local idx = area:indexp(pos)
	if data[idx] and param2_data[idx] then
		return {
			name = minetest.get_name_from_content_id(data[idx]),
			param2 = param2_data[idx]
		}
	end
	return {name="ignore", param2=0}
end

local function turnright(dir)
	local facedir = minetest.dir_to_facedir(dir)
	return minetest.facedir_to_dir((facedir + 1) % 4)
end

local function turnleft(dir)
	local facedir = minetest.dir_to_facedir(dir)
	return minetest.facedir_to_dir((facedir + 3) % 4)
end

-- pos is the base position
local function is_crane_running(pos)
	local switch_pos = {x=pos.x, y=pos.y+1, z=pos.z}
	return towercrane.is_crane_running(switch_pos)
end

local function get_crane_data(pos)
	local meta = minetest.get_meta(pos)
	local dir = S2P(meta:get_string("dir"))
	local owner = meta:get_string("owner")
	local height = meta:get_int("height")
	local width = meta:get_int("width")
	if dir and height > 0 and width > 0 and owner ~= "" then
		return {dir = dir, height = height, width = width, owner = owner}
	end
end

-- generic function for contruction and removement
local function crane_body_plan(pos, dir, height, width, clbk, tArg)
	pos.y = pos.y + 1
	clbk(pos, "towercrane:mast_ctrl_off", tArg)

	for _ = 1,height+1 do
		pos.y = pos.y + 1
		clbk(pos, "towercrane:mast", tArg)
	end

	pos.y = pos.y - 2
	pos.x = pos.x - dir.x
	pos.z = pos.z - dir.z
	clbk(pos, "towercrane:arm2", tArg)
	pos.x = pos.x - dir.x
	pos.z = pos.z - dir.z
	clbk(pos, "towercrane:arm", tArg)
	pos.x = pos.x - dir.x
	pos.z = pos.z - dir.z
	clbk(pos, "towercrane:balance", tArg)
	pos.x = pos.x + 3 * dir.x
	pos.z = pos.z + 3 * dir.z

	for i = 1,width do
		pos.x = pos.x + dir.x
		pos.z = pos.z + dir.z
		if i % 2 == 0 then
			clbk(pos, "towercrane:arm2", tArg)
		else
			clbk(pos, "towercrane:arm", tArg)
		end
	end
end

-- Check space and protection for the crane
local function check_space(pos, dir, height, width, owner)
	local check = function(pos, node_name, tArg)
		if minetest.get_node(pos).name ~= "air" then
			tArg.res = false
		elseif minetest.is_protected(pos, tArg.owner) then
			tArg.res = false
		end
	end
	local tArg = {res = true, owner = owner}
	crane_body_plan(table.copy(pos), dir, height, width, check, tArg)
	return tArg.res
end

local function construct_crane(pos, dir, height, width)
	local add = function(pos, node_name, tArg)
		minetest.add_node(pos, {
				name = node_name,
				param2 = minetest.dir_to_facedir(tArg.dir)})
	end
	local tArg = {dir = dir}
	crane_body_plan(table.copy(pos), dir, height, width, add, tArg)
end

local function remove_crane(pos, dir, height, width)
	local remove = function(pos, node_name, tArg)
		local node = get_node_lvm(pos)
		if node.name == node_name or node.name == "towercrane:mast_ctrl_on" then
			minetest.remove_node(pos)
		end
	end
	crane_body_plan(table.copy(pos), dir, height, width, remove, {})
end

-- pos is the base position
local function is_my_crane(pos, player)
	if minetest.check_player_privs(player, "server") then
		return true
	end
	-- check protection
	local player_name = player and player:get_player_name() or ""
	if minetest.is_protected(pos, player_name) then
		return false
	end
	-- check owner
    local meta = minetest.get_meta(pos)
	if not meta or player_name ~= meta:get_string("owner") then
		return false
	end
	return true
end

-- Check user input (height, width)
local function check_input(fields)
	local size = string.split(fields.size, ",")
	if #size == 2  then
		local height = tonumber(size[1])
		local width = tonumber(size[2])
		if height ~= nil and width ~= nil then
			height = math.max(height, MIN_SIZE)
			height = math.min(height, towercrane.max_height)
			width = math.max(width, MIN_SIZE)
			width = math.min(width, towercrane.max_width)
			return height, width
		end
	end
	return 0, 0
end

-- pos is the base position
function towercrane.get_crane_down(pos)
	local data = get_crane_data(pos)
	if data then
		remove_crane(pos, data.dir, data.height, data.width)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec(data.height, data.width))
	end
end

local function build_crane_up(pos, owner, height, width)
	if height > 0 and width > 0 then
		local meta = minetest.get_meta(pos)
		local dir = S2P(meta:get_string("dir"))
		if dir then
			if check_space(pos, dir, height, width, owner) then
				construct_crane(pos, dir, height, width)
				meta:set_int("height", height)
				meta:set_int("width", width)
				meta:set_string("infotext", S("Owner")..": "..owner..
					", "..S("Crane size")..": "..height..","..width)
				meta:set_string("formspec", formspec(height, width))
			else
				chat(owner, S("Area is protected or too less space for the crane!"))
			end
		end
	else
		chat(owner, S("Invalid input!"))
	end
end

minetest.register_node("towercrane:base", {
	description = S("Tower Crane Base"),
	inventory_image = "[inventorycube{towercrane_mast.png{towercrane_mast.png{towercrane_mast.png",
	tiles = {
		"towercrane_base.png^towercrane_arrow.png",
		"towercrane_base.png^towercrane_screws.png",
		"towercrane_base.png^towercrane_screws.png",
		"towercrane_base.png^towercrane_screws.png",
		"towercrane_base.png^towercrane_screws.png",
		"towercrane_base.png^towercrane_screws.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	sounds = default.node_sound_metal_defaults(),
	is_ground_content = false,
	groups = {cracky=2},

	-- set meta data (form for crane height and width, dir of the arm)
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("formspec", formspec())

		local fdir = minetest.dir_to_facedir(placer:get_look_dir(), false)
		local dir = minetest.facedir_to_dir(fdir)
		meta:set_string("dir", P2S(dir))
	end,

	on_rotate = function(pos, node, player, mode, new_facedir)
		-- check whether crane is built up
		local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
		local node_above = minetest.get_node(pos_above)

		if node_above.name == "towercrane:mast_ctrl_on"
				or node_above.name == "towercrane:mast_ctrl_off" then
			return false
		end

		-- only allow rotation around y-axis
		new_facedir = new_facedir % 4

		local dir = minetest.facedir_to_dir(new_facedir)
		local meta = minetest.get_meta(pos)
		meta:set_string("dir", P2S(dir))

		node.param2 = new_facedir
		minetest.swap_node(pos, node)
		return true
	end,

	-- evaluate user input (height, width),
	-- destroy old crane and build a new one with
	-- the given size
	on_receive_fields = function(pos, formname, fields, player)
		if fields.size == nil then
			return
		end
		if is_crane_running(pos) then
			return
		end
		if not is_my_crane(pos, player) then
			return
		end
		-- destroy old crane
		towercrane.get_crane_down(pos)
		-- evaluate user input and build new
		local height, width = check_input(fields)
		build_crane_up(pos, player:get_player_name(), height, width)
	end,

	can_dig = function(pos, player)
		if minetest.check_player_privs(player, "server") then
			return true
		end
		if is_crane_running(pos) then
			return false
		end
		if not is_my_crane(pos, player) then
			return false
		end
		return true
	end,

	on_destruct = function(pos)
		towercrane.get_crane_down(pos)
	end,
})

minetest.register_node("towercrane:balance", {
	description = S("Tower Crane Balance"),
	tiles = {
		"towercrane_base.png^towercrane_screws.png^morelights_extras_blocklight.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 12,
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {crumbly=0, not_in_creative_inventory=1},
})

minetest.register_node("towercrane:mast", {
	description = S("Tower Crane Mast"),
	drawtype = "glasslike_framed",
	tiles = {
		"towercrane_mast.png",
		{
			name = "towercrane_mast.png",
			backface_culling = false,
		},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {crumbly=0, not_in_creative_inventory=1},
})

minetest.register_node("towercrane:arm", {
	description = S("Tower Crane Arm"),
	drawtype = "glasslike_framed",
	tiles = {
		"towercrane_arm.png",
		{
			name = "towercrane_arm.png",
			backface_culling = false,
		},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {crumbly=0, not_in_creative_inventory=1},
})

minetest.register_node("towercrane:arm2", {
	description = S("Tower Crane Arm2"),
	drawtype = "glasslike_framed",
	tiles = {
		"towercrane_arm2.png",
		{
			name = "towercrane_arm2.png",
			backface_culling = false,
		},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {crumbly=0, not_in_creative_inventory=1},
})

if towercrane.recipe then
	minetest.register_craft({
		output = "towercrane:base",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "", ""},
			{"default:steel_ingot", "dye:yellow", ""}
		}
	})
end

towercrane.turnright = turnright
towercrane.turnleft = turnleft
towercrane.is_my_crane = is_my_crane
towercrane.get_crane_data = get_crane_data
]]--

--[[ from control.lua

local DAYS_WITHOUT_USE = 72 * 5

-- for lazy programmers
local P2S = function(pos) if pos then return minetest.pos_to_string(pos) end end
local S2P = minetest.string_to_pos

local S = towercrane.S

-- To prevent race condition crashes
local Currently_left_the_game = {}

-- pos is the switch position
local function is_my_crane(pos, clicker)
	local base_pos = {x=pos.x, y=pos.y-1, z=pos.z}
	return towercrane.is_my_crane(base_pos, clicker)
end

-- pos is the switch position
local function get_crane_data(pos)
	local base_pos = {x=pos.x, y=pos.y-1, z=pos.z}
	return towercrane.get_crane_data(base_pos)
end

local function get_my_crane_pos(player)
	-- check operator state
    local pl_meta = player:get_meta()
	if not pl_meta or pl_meta:get_int("towercrane_isoperator") ~= 1 then
		return 
	end
	-- check owner
	local pos = S2P(pl_meta:get_string("towercrane_pos"))
	local player_name = (player and player:get_player_name()) or ""
    local data = get_crane_data(pos)
	if not data or player_name ~= data.owner then
		return 
	end
	-- check protection
	if minetest.is_protected(pos, player_name) then
		return 
	end
	
	return pos  -- switch pos
end

-- pos is the switch position
local function is_crane_running(pos)
	local meta = minetest.get_meta(pos)
	return meta:get_int("running") == 1
end
	
local function is_operator(player)
    local pl_meta = player:get_meta()
	if not pl_meta or pl_meta:get_int("towercrane_isoperator") ~= 1 then
		return false
	end
	return true
end

local function set_operator_privs(player, pos)
	local privs = minetest.get_player_privs(player:get_player_name())
	local physics = player:get_physics_override()
	local meta = player:get_meta()
	-- Check access conflicts with other mods
	if meta:get_int("player_physics_locked") == 0 then 
		if pos and meta and privs and physics then
			meta:set_string("towercrane_pos", P2S(pos))
			-- store the player privs default values
			meta:set_string("towercrane_fast", privs["fast"] and "true" or "false")
			meta:set_string("towercrane_fly", privs["fly"] and "true" or "false")
			meta:set_int("towercrane_speed", physics.speed)
			-- set operator privs
			meta:set_int("towercrane_isoperator", 1)
			meta:set_int("player_physics_locked", 1)
			privs["fly"] = true
			privs["fast"] = nil
			physics.speed = 0.7
			-- write back
			player:set_physics_override(physics)
			minetest.set_player_privs(player:get_player_name(), privs)
			return true
		end
	end
	return false
end

local function reset_operator_privs(player)
	local privs = minetest.get_player_privs(player:get_player_name())
	local physics = player:get_physics_override()
	local meta = player:get_meta()
	if meta and privs and physics then
		meta:set_string("towercrane_pos", "")
		-- restore the player privs default values
		meta:set_int("towercrane_isoperator", 0)
		meta:set_int("player_physics_locked", 0)
		privs["fast"] = meta:get_string("towercrane_fast") == "true" or nil
		privs["fly"] = meta:get_string("towercrane_fly") == "true" or nil
		physics.speed = meta:get_int("towercrane_speed")
		if physics.speed == 0 then physics.speed = 1 end
		-- delete stored default values
		meta:set_string("towercrane_fast", "")
		meta:set_string("towercrane_fly", "")
		meta:set_string("towercrane_speed", "")
		-- write back
		player:set_physics_override(physics)
		minetest.set_player_privs(player:get_player_name(), privs)
	end
end

local function place_player(pos, player)
	if pos and player then
		local data = get_crane_data(pos)
		if data then
			local new_pos = vector.add(pos, data.dir)
			new_pos.y = new_pos.y - 1
			player:set_pos(new_pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("last_known_pos", P2S(new_pos))
		end
	end
end

-- state must be "on" or "off"
local function swap_node(pos, state)
	-- check node
    local node = minetest.get_node(pos)
	if node.name ~= "towercrane:mast_ctrl_"..(state == "on" and "off" or "on") then
		return
	end
	-- switch node
	node.name = "towercrane:mast_ctrl_"..state
	minetest.swap_node(pos, node)
end

-- pos is the switch position
local function store_last_used(pos)
	local meta = minetest.get_meta(pos)
	meta:set_int("last_used", minetest.get_day_count() + DAYS_WITHOUT_USE)
end

local function stop_crane(pos, player)
	swap_node(pos, "off")
	local meta = minetest.get_meta(pos)
	meta:set_int("running", 0)
	store_last_used(pos)
	place_player(pos, player)
end

local function start_crane(pos, player)
	swap_node(pos, "on")
	local meta = minetest.get_meta(pos)
	meta:set_int("running", 1)
	store_last_used(pos)
	place_player(pos, player)
end

local function calc_construction_area(pos)
	local data = get_crane_data(pos)
	if data then
		-- pos1 = close/right/below
		local dir = towercrane.turnright(data.dir)
		local pos1 = vector.add(pos, vector.multiply(dir, data.width/2))
		dir = towercrane.turnleft(dir)
		pos1 = vector.add(pos1, vector.multiply(dir, 1))
		pos1.y = pos.y - 2 + data.height - towercrane.rope_length
		-- pos2 = far/left/above
		local pos2 = vector.add(pos1, vector.multiply(dir, data.width-1))
		dir = towercrane.turnleft(dir)
		pos2 = vector.add(pos2, vector.multiply(dir, data.width))
		pos2.y = pos.y - 3 + data.height

		-- normalize x/z so that pos2 > pos1
		if pos2.x < pos1.x then
			pos2.x, pos1.x = pos1.x, pos2.x
		end
		if pos2.z < pos1.z then
			pos2.z, pos1.z = pos1.z, pos2.z
		end
		return pos1, pos2
	end
end

local function control_player(pos, pos1, pos2, player_name)
	if Currently_left_the_game[player_name] then
		Currently_left_the_game[player_name] = nil
		return
	end
	local player = player_name and minetest.get_player_by_name(player_name)
	if player then
		if is_crane_running(pos) then
			-- check if outside of the construction area
			local correction = false
			local pl_pos = player:get_pos()
			if pl_pos then
				if pl_pos.x < pos1.x then pl_pos.x = pos1.x; correction = true end
				if pl_pos.x > pos2.x then pl_pos.x = pos2.x; correction = true end
				if pl_pos.y < pos1.y then pl_pos.y = pos1.y; correction = true end
				if pl_pos.y > pos2.y then pl_pos.y = pos2.y; correction = true end
				if pl_pos.z < pos1.z then pl_pos.z = pos1.z; correction = true end
				if pl_pos.z > pos2.z then pl_pos.z = pos2.z; correction = true end
				-- check if a protected area is violated
				if correction == false and minetest.is_protected(pl_pos, player_name) then
					minetest.chat_send_player(player_name, "[Tower Crane] "..S("Area is protected."))
					correction = true
				end
				local meta = minetest.get_meta(pos)
				if correction == true then
					local last_pos = S2P(meta:get_string("last_known_pos"))
					if last_pos then
						player:set_pos(last_pos)	
					end
				else  -- store last known correct position
					meta:set_string("last_known_pos", P2S(pl_pos))
				end
				minetest.after(1, control_player, pos, pos1, pos2, player_name)
			end
		else
			store_last_used(pos)
			place_player(pos, player)
			reset_operator_privs(player)
		end
	else
		local meta = minetest.get_meta(pos)
		meta:set_int("running", 0)
	end
end	

minetest.register_node("towercrane:mast_ctrl_on", {
	description = S("Tower Crane Mast Ctrl On"),
	drawtype = "node",
	tiles = {
		"towercrane_base.png",
		"towercrane_base.png",
		"towercrane_base.png",
		"towercrane_base.png",
		"towercrane_base.png^towercrane_button_on.png",
		"towercrane_base.png^towercrane_button_on.png",
	},
	-- switch the crane OFF
	on_rightclick = function (pos, node, clicker)
		local pos2 = get_my_crane_pos(clicker)
		if pos2 and vector.equals(pos, pos2) or minetest.check_player_privs(clicker, "server") then
			stop_crane(pos, clicker)
		end
	end,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Switch crane on/off"))
	end,

	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 3,
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {crumbly=0, not_in_creative_inventory=1},
})

minetest.register_node("towercrane:mast_ctrl_off", {
	description = S("Tower Crane Mast Ctrl Off"),
	drawtype = "node",
	tiles = {
		"towercrane_base.png",
		"towercrane_base.png",
		"towercrane_base.png",
		"towercrane_base.png",
		"towercrane_base.png^towercrane_button_off.png",
		"towercrane_base.png^towercrane_button_off.png",
	},
	-- switch the crane ON
	on_rightclick = function (pos, node, clicker)
		if is_my_crane(pos, clicker) and not is_operator(clicker) then
			if set_operator_privs(clicker, pos) then
				start_crane(pos, clicker)
				local pos1, pos2 = calc_construction_area(pos)
				-- control player every second
				minetest.after(1, control_player, pos, pos1, pos2, clicker:get_player_name())
			end
		end
	end,

	on_construct = function(pos)
		-- add infotext
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Switch crane on/off"))
	end,

	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {crumbly=0, not_in_creative_inventory=1},
})

minetest.register_on_joinplayer(function(player)
	local pos = get_my_crane_pos(player)
	if pos then
		reset_operator_privs(player)
		stop_crane(pos, player)
	end
end)

minetest.register_on_leaveplayer(function(player)
	if is_operator(player) then
		Currently_left_the_game[player:get_player_name()] = true
	end
end)

minetest.register_on_dieplayer(function(player, reason)
	if is_operator(player) then
		local pos = get_my_crane_pos(player)
		if pos then
			reset_operator_privs(player)
			stop_crane(pos, player)
		end
	end
end)

minetest.register_lbm({
	label = "[towercrane] break down",
	name = "towercrane:break_down",
	nodenames = {"towercrane:mast_ctrl_off", "towercrane:mast_ctrl_on"},
	run_at_every_load = true,
	action = function(pos, node)
		local t = minetest.get_day_count()
		local meta = minetest.get_meta(pos)
		local last_used = meta:get_int("last_used") or 0
		if last_used == 0 then
			meta:set_int("last_used", t + DAYS_WITHOUT_USE)
		elseif t > last_used then
			local base_pos = {x=pos.x, y=pos.y-1, z=pos.z}
			towercrane.get_crane_down(base_pos)
		end
	end
})

towercrane.is_crane_running = is_crane_running
]]--

--[[[ from config.lua
-- Maximum crane height in blocks (8..n)
towercrane.max_height = tonumber(minetest.settings:get("towercrane_max_height")) or 32

-- Maximum crane width in blocks (8..n)
towercrane.max_width = tonumber(minetest.settings:get("towercrane_max_width")) or 32

-- Crane rope lenght in block (max_height .. max_height+x)
towercrane.rope_length = tonumber(minetest.settings:get("towercrane_rope_length")) or 40

-- Recipe available (true/false)
towercrane.recipe = tonumber(minetest.settings:get("towercrane_recipe")) or true
]]--
