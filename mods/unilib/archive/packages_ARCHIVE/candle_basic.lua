---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function add_candle(col, dcol)

    local rcol = ""

    if col ~= "" then
        rcol = col
        col = "_" .. col
    end

    minetest.register_node("ethereal:candle" .. col, {
        description = S(dcol .. "Candle"),
        drawtype = "plantlike",
        inventory_image = "ethereal_candle" .. col .. "_static.png",
        wield_image = "ethereal_candle" .. col .. "_static.png",
        tiles = {
            {
                name = "ethereal_candle" .. col .. ".png",
                animation = {
                    type="vertical_frames",
                    aspect_w = 32,
                    aspect_h = 32,
                    length = 1.0
                }
            }
        },
        paramtype = "light",
        light_source = 11,
        sunlight_propagates = true,
        walkable = false,
        groups = {candle = 1, dig_immediate = 3, attached_node = 1},
        sounds = default.node_sound_defaults(),
        selection_box = {
            type = "fixed",
            fixed = { -0.15, -0.5, -0.15, 0.15, 0, 0.15 }
        }
    })

	if col ~= "" then
		minetest.register_craft({
			output = "ethereal:candle" .. col,
			recipe = {
				{"group:candle", "dye:" .. rcol},
			}
		})
	end
end

add_candle("", "")
add_candle("black", "Black ") -- candle colour textures by wRothbard
add_candle("blue", "Blue ")
add_candle("brown", "Brown ")
add_candle("cyan", "Cyan ")
add_candle("dark_green", "Dark Green ")
add_candle("dark_grey", "Dark Grey ")
add_candle("green", "Green ")
add_candle("grey", "Grey ")
add_candle("magenta", "Magenta ")
add_candle("orange", "Orange ")
add_candle("pink", "Pink ")
add_candle("red", "Red ")
add_candle("violet", "Violet ")
add_candle("yellow", "Yellow ")

-- white candle recipe
minetest.register_craft({
	output = "ethereal:candle",
	recipe = {
		{"group:candle", "dye:white"}
	}
})

-- candle recipe
minetest.register_craft({
	output = "ethereal:candle 2",
	recipe = {
		{"farming:string"},
		{"ethereal:palm_wax"},
		{"ethereal:palm_wax"}
	}
})
]]--
