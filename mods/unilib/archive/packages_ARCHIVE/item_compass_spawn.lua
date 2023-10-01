---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nextgen_compass
-- Code:    GPLv3
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local compass_frames = 32

--Not sure spawn point should be dymanic (is it in mc?)
--local default_spawn_settings = minetest.settings:get("static_spawnpoint")

-- Timer for random compass spinning
local random_timer = 0
local random_timer_trigger = 0.5 -- random compass spinning tick in seconds. Increase if there are performance problems

local random_frame = math.random(0, compass_frames-1)

function nextgen_compass.get_compass_image(pos, dir)
		local spawn = {x=0,y=0,z=0}
		local ssp = minetest.setting_get_pos("static_spawnpoint")
		if ssp then
			spawn = ssp
			if type(spawn) ~= "table" or type(spawn.x) ~= "number" or type(spawn.y) ~= "number" or type(spawn.z) ~= "number" then
				spawn = {x=0,y=0,z=0}
			end
		end
		local angle_north = math.deg(math.atan2(spawn.x - pos.x, spawn.z - pos.z))
		if angle_north < 0 then angle_north = angle_north + 360 end
		local angle_dir = -math.deg(dir)
		local angle_relative = (angle_north - angle_dir + 180) % 360
		return math.floor((angle_relative/11.25) + 0.5) % compass_frames
end

minetest.register_globalstep(function(dtime)
	random_timer = random_timer + dtime

	if random_timer >= random_timer_trigger then
		random_frame = (random_frame + math.random(-1, 1)) % compass_frames
		random_timer = 0
	end
	for i,player in pairs(minetest.get_connected_players()) do
		local function has_compass(player)
			for _,stack in pairs(player:get_inventory():get_list("main")) do
				if minetest.get_item_group(stack:get_name(), "compass") ~= 0 then
					return true
				end
			end
			return false
		end
		if has_compass(player) then
			local pos = player:get_pos()
			local compass_image = nextgen_compass.get_compass_image(pos, player:get_look_horizontal())

			for j,stack in pairs(player:get_inventory():get_list("main")) do
				if minetest.get_item_group(stack:get_name(), "compass") ~= 0 and
						minetest.get_item_group(stack:get_name(), "compass")-1 ~= compass_image then
					local itemname = "nextgen_compass:"..compass_image
					stack:set_name(itemname)
					player:get_inventory():set_stack("main", j, stack)
				end
			end
		end
	end
end)

local images = {}
for frame = 0, compass_frames-1 do
	local s = string.format("%02d", frame)
	table.insert(images, "nextgen_compass_compass_"..s..".png")
end

local doc_mod = minetest.get_modpath("doc")

local stereotype_frame = 18
for i,img in ipairs(images) do
	local inv = 1
	if i == stereotype_frame then
		inv = 0
	end
	local itemstring = "nextgen_compass:"..(i-1)
	minetest.register_craftitem(itemstring, {
		description = S("Compass"),
		--_doc_items_usagehelp = usagehelp,
		inventory_image = img,
		wield_image = img,
		stack_max = 64,
		groups = {not_in_creative_inventory=inv, compass=i, tool=1, disable_repair=1 }
	})
end

minetest.register_craft({
	output = "nextgen_compass:"..stereotype_frame,
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:mese_crystal", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_alias("nextgen_compass:compass", "nextgen_compass:"..stereotype_frame)

-- Export stereotype item for other mods to use
nextgen_compass.stereotype = "nextgen_compass:"..tostring(stereotype_frame)
]]--
