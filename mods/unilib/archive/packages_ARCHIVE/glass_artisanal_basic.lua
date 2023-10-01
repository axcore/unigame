---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- undecorated coloured glass, all using plain glass texture
abriglass.glass_list = {
	{"black", "Darkened", "292421",}, {"blue", "Blue", "0000FF",},
	{"cyan", "Cyan", "00FFFF",}, {"green", "Green", "00FF00",},
	{"magenta", "Magenta", "FF00FF",}, {"orange", "Orange", "FF6103",},
	{"purple", "Purple", "800080",}, {"red", "Red", "FF0000",},
	{"yellow", "Yellow", "FFFF00",}, {"frosted", "Frosted", "FFFFFF",}
}

local palette = "[combine:16x16:"
for k, v in ipairs(abriglass.glass_list) do
	palette = palette .. ":" .. (k-1) .. ",0=[combine\\:1x1\\^[noalpha\\^[colorize\\:#" .. v[3] .. "\\:255"
end

minetest.register_node("abriglass:stained_glass_hardware", {
	description = "Hardware Glass",
	tiles = {"abriglass_baseglass.png"},
	groups = {cracky = 3},
	use_texture_alpha = "blend",
	sunlight_propagates = true,
	light_source = 4,
	drawtype = "glasslike",
	paramtype = "light",
	paramtype2 = "color",
	palette = palette,
	sounds = default.node_sound_glass_defaults(),
	preserve_metadata = function(pos, oldnode, oldmeta, drops)
		if abriglass.glass_list[oldnode.param2 + 1] then
			drops[1]:get_meta():set_string("description", abriglass.glass_list[oldnode.param2 + 1][1] .. " glass")
		else
			drops[1]:get_meta():set_string("description", "Hardware Glass")
		end
    end,
})

minetest.register_node("abriglass:glass_light_hardware", {
	description = "Hardware Glass Light",
	tiles = {"abriglass_baseglass.png"},
	overlay_tiles = {
        { name = "abriglass_clearglass.png", color = "white" }
    },
	groups = {cracky = 3},
	use_texture_alpha = "blend",
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "glasslike",
	paramtype2 = "color",
	palette = palette,
	sounds = default.node_sound_glass_defaults(),
	preserve_metadata = function(pos, oldnode, oldmeta, drops)
		if abriglass.glass_list[oldnode.param2 + 1] then
			drops[1]:get_meta():set_string("description", abriglass.glass_list[oldnode.param2 + 1][1] .. " glass light")
		else
			drops[1]:get_meta():set_string("description", "Hardware Glass Light")
		end
    end,
})

-- undecorated coloured glass recipes / light glass
local dye_list = {
	{"black", "black",},
	{"blue", "blue",},
	{"cyan", "cyan",},
	{"green", "green",},
	{"magenta", "magenta",},
	{"orange", "orange",},
	{"purple", "violet",},
	{"red", "red",},
	{"yellow", "yellow",},
	{"frosted", "white",},
}

sg_conversion_table = {}

for k, v in pairs(dye_list) do
    local out_item = ItemStack(minetest.itemstring_with_palette("abriglass:stained_glass_hardware", k - 1))
    out_item:get_meta():set_string("description", v[1] .. " glass")
    minetest.register_craft({
        output = out_item:to_string(),
        recipe = {
			{'abriglass:clear_glass', '', 'abriglass:clear_glass' },
			{'abriglass:clear_glass', 'dye:'..v[2], 'abriglass:clear_glass' },
			{'abriglass:clear_glass', '', 'abriglass:clear_glass' },
		}
    })

	minetest.register_craft({
		type = "cooking",
		recipe = out_item:to_string(),
		output = "abriglass:clear_glass",
	})

	sg_conversion_table[ v[1] ] = out_item:to_string()

	out_item = ItemStack(minetest.itemstring_with_palette("abriglass:glass_light_hardware", k - 1))
    out_item:get_meta():set_string("description", v[1] .. " glass light")
	minetest.register_craft({
		output = out_item:to_string(),
		recipe = {
			{'abriglass:clear_glass', 'default:torch', 'abriglass:clear_glass' },
			{'abriglass:clear_glass', 'dye:'..v[2], 'abriglass:clear_glass' },
		}
	})

	minetest.register_craft({
		type = "cooking",
		recipe = out_item:to_string(),
		output = "abriglass:clear_glass",
	})
end
]]--
