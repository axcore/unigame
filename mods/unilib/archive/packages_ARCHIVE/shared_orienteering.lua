---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    orienteering
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local orienteering = {}
orienteering.playerhuds = {}
orienteering.settings = {}
orienteering.settings.speed_unit = S("m/s")
orienteering.settings.length_unit = S("m")
orienteering.settings.hud_pos = { x = 0.5, y = 0 }
orienteering.settings.hud_offset = { x = 0, y = 15 }
orienteering.settings.hud_alignment = { x = 0, y = 0 }

local o_lines = 4 -- Number of lines in HUD

-- Checks whether a certain orienteering tool is “active” and ready for use
function orienteering.tool_active(player, item)
	-- Requirement: player carries the tool in the hotbar
	local inv = player:get_inventory()
	-- Exception: MTG's Mapping Kit can be anywhere
	if item == "map:mapping_kit" then
		return inv:contains_item("main", item)
	end
	local hotbar = player:hud_get_hotbar_itemcount()
	for i=1, hotbar do
		if inv:get_stack("main", i):get_name() == item then
			return true
		end
	end
	return false
end

function orienteering.update_automapper(player)
	if orienteering.tool_active(player, "orienteering:automapper") or orienteering.tool_active(player, "orienteering:quadcorder") or minetest.is_creative_enabled(player:get_player_name()) then
		player:hud_set_flags({minimap = true, minimap_radar = true})
	elseif ((not mod_map) and orienteering.tool_active(player, "orienteering:map")) or ((mod_map) and orienteering.tool_active(player, "map:mapping_kit")) then
		player:hud_set_flags({minimap = true, minimap_radar = false})
	else
		player:hud_set_flags({minimap = false, minimap_radar = false})
	end
end


function orienteering.init_hud(player)
	orienteering.update_automapper(player)
	local name = player:get_player_name()
	orienteering.playerhuds[name] = {}
	for i=1, o_lines do
		orienteering.playerhuds[name]["o_line"..i] = player:hud_add({
			hud_elem_type = "text",
			text = "",
			position = orienteering.settings.hud_pos,
			offset = { x = orienteering.settings.hud_offset.x, y = orienteering.settings.hud_offset.y + 20*(i-1) },
			alignment = orienteering.settings.hud_alignment,
			number = 0xFFFFFF,
			scale= { x = 100, y = 20 },
			z_index = 0,
		})
	end
end

function orienteering.update_hud_displays(player)
	local toDegrees=180/math.pi
	local name = player:get_player_name()
	local gps, altimeter, triangulator, compass, sextant, watch, speedometer, quadcorder

	if orienteering.tool_active(player, "orienteering:gps") then
		gps = true
	end
	if orienteering.tool_active(player, "orienteering:altimeter") then
		altimeter = true
	end
	if orienteering.tool_active(player, "orienteering:triangulator") then
		triangulator = true
	end
	if orienteering.tool_active(player, "orienteering:compass") then
		compass = true
	end
	if orienteering.tool_active(player, "orienteering:sextant") then
		sextant = true
	end
	if orienteering.tool_active(player, "orienteering:watch") then
		watch = true
	end
	if orienteering.tool_active(player, "orienteering:speedometer") then
		speedometer = true
	end
	if orienteering.tool_active(player, "orienteering:quadcorder") then
		quadcorder = true
	end

	local str_pos, str_angles, str_time, str_speed
	local pos = vector.round(player:get_pos())
	if (altimeter and triangulator) or gps or quadcorder then
		str_pos = S("Coordinates: X=@1, Y=@2, Z=@3", pos.x, pos.y, pos.z)
	elseif altimeter then
		str_pos = S("Height: Y=@1", pos.y)
	elseif triangulator then
		str_pos = S("Coordinates: X=@1, Z=@2", pos.x, pos.z)
	else
		str_pos = ""
	end

	-- Yaw in Minetest goes counter-clockwise, which is opposite of how compasses work
	local yaw = 360-player:get_look_horizontal()*toDegrees
	local pitch = player:get_look_vertical()*toDegrees
	if ((compass or gps) and sextant) or quadcorder then
		str_angles = S("Yaw: @1°, pitch: @2°", string.format("%.1f", yaw), string.format("%.1f", pitch))
	elseif compass or gps then
		str_angles = S("Yaw: @1°", string.format("%.1f", yaw))
	elseif sextant then
		str_angles = S("Pitch: @1°", string.format("%.1f", pitch))
	else
		str_angles = ""
	end

	local time = minetest.get_timeofday()
	if watch or gps or quadcorder then
		local totalminutes = time * 1440
		local minutes = totalminutes % 60
		local hours = math.floor((totalminutes - minutes) / 60)
		minutes = math.floor(minutes)
		local twelve = player:get_meta():get_string("orienteering:twelve") == "true"
		if twelve then
			if hours == 12 and minutes == 0 then
				str_time = S("Time: noon")
			elseif hours == 0 and minutes == 0 then
				str_time = S("Time: midnight")
			else
				local hours12 = math.fmod(hours, 12)
				if hours12 == 0 then hours12 = 12 end
				if hours >= 12 then
					str_time = S("Time: @1:@2 p.m.", string.format("%i", hours12), string.format("%02i", minutes))
				else
					str_time = S("Time: @1:@2 a.m.", string.format("%i", hours12), string.format("%02i", minutes))
				end
			end
		else
			str_time = S("Time: @1:@2", string.format("%02i", hours), string.format("%02i", minutes))
		end
	else
		str_time = ""
	end

	if speedometer or quadcorder then
		local speed_hor, speed_ver
		local v
		local attach = player:get_attach()
		if attach == nil then
			v = player:get_player_velocity()
		else
			v = attach:get_velocity()
			if not v then
				v = player:get_player_velocity()
			end
		end
		speed_ver = v.y
		v.y = 0
		speed_hor = vector.length(v)

		local u = orienteering.settings.speed_unit
		str_speed = S("Speed: hor.: @1 @2, vert.: @3 @4", string.format("%.1f", speed_hor), u, string.format("%.1f", speed_ver), u)
	else
		str_speed = ""
	end

	local strs = { str_pos, str_angles, str_time, str_speed }
	local line = 1
	for i=1, o_lines do
		if strs[i] ~= "" then
			player:hud_change(orienteering.playerhuds[name]["o_line"..line], "text", strs[i])
			line = line + 1
		end
	end
	for l=line, o_lines do
		player:hud_change(orienteering.playerhuds[name]["o_line"..l], "text", "")
	end
end

-- Helper function to switch between 12h and 24 mode for the time
function orienteering.toggle_time_mode(itemstack, user, pointed_thing)
	- -[[ Player attribute “orienteering:twelve”:
	* "true": Use 12h mode for time
	* "false" or unset: Use 24h mode for time ] ]
	if user:get_meta():get_string("orienteering:twelve") == "true" then
		user:get_meta():set_string("orienteering:twelve", "false")
	else
		user:get_meta():set_string("orienteering:twelve", "true")
	end
	orienteering.update_hud_displays(user)
end

if mod_map then
	-- Disable all HUD flag handling in map mod because we already handle it
	-- ourselves.
	map.update_hud_flags = function() end
end

minetest.register_on_newplayer(orienteering.init_hud)
minetest.register_on_joinplayer(orienteering.init_hud)

minetest.register_on_leaveplayer(function(player)
	orienteering.playerhuds[player:get_player_name()] = nil
end)

local updatetimer = 0
minetest.register_globalstep(function(dtime)
	updatetimer = updatetimer + dtime
	if updatetimer > 0.1 then
		local players = minetest.get_connected_players()
		for i=1, #players do
			orienteering.update_automapper(players[i])
			orienteering.update_hud_displays(players[i])
		end
		updatetimer = updatetimer - dtime
	end
end)
]]--
