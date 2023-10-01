---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nbea
-- Code:    WTFPL
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("nbea:nbox_009", {
	description = "Monochrome",
	inventory_image = "nbea_monochrome.png",
	wield_image = "nbea_monochrome.png",
	tiles = {"nbea_monochrome.png"},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_metal_defaults({
		place = {name = "default_metal_footstep", gain = 0.5},
		dig = {name = "default_metal_footstep", gain = 1.0},
		dug = {name = "default_metal_footstep", gain = 1.0},
	}),
	node_box = {
		type = "fixed",
		fixed = {
			-- top (Y+)
			{-0.0625, 0, -0.0625, 0.0625, 0.0625, 0.0625},
			{-0.125, 0.0625, -0.125, 0.125, 0.125, -0.0625},
			{-0.125, 0.0625, 0.0625, 0.125, 0.125, 0.125},
			{0.0625, 0.0625, -0.0625, 0.125, 0.125, 0.0625},
			{-0.125, 0.0625, -0.0625, -0.0625, 0.125, 0.0625},
			{0.125, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
			{-0.1875, 0.125, -0.1875, -0.125, 0.1875, 0.1875},
			{-0.125, 0.125, 0.125, 0.125, 0.1875, 0.1875},
			{-0.125, 0.125, -0.1875, 0.125, 0.1875, -0.125},
			{-0.25, 0.1875, 0.1875, 0.25, 0.25, 0.25},
			{-0.25, 0.1875, -0.25, 0.25, 0.25, -0.1875},
			{0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.1875},
			{-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.1875},
			{-0.3125, 0.25, -0.3125, -0.25, 0.3125, 0.3125},
			{0.25, 0.25, -0.3125, 0.3125, 0.3125, 0.3125},
			{-0.25, 0.25, -0.3125, 0.25, 0.3125, -0.25},
			{-0.25, 0.25, 0.25, 0.25, 0.3125, 0.3125},
			{-0.375, 0.3125, 0.3125, 0.375, 0.375, 0.375},
			{-0.375, 0.3125, -0.375, 0.375, 0.375, -0.3125},
			{0.3125, 0.3125, -0.3125, 0.375, 0.375, 0.3125},
			{-0.375, 0.3125, -0.3125, -0.3125, 0.375, 0.3125},
			{-0.4375, 0.375, -0.4375, -0.375, 0.4375, 0.4375},
			{0.375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.4375, 0.375, 0.375, 0.4375, 0.4375, 0.4375},
			{-0.375, 0.375, -0.4375, 0.375, 0.4375, -0.375},
			-- bottom (Y-)
			{-0.0625, -0.0625, -0.0625, 0.0625, -0, 0.0625},
			{0.0625, -0.125, -0.125, 0.125, -0.0625, 0.125},
			{-0.125, -0.125, -0.125, -0.0625, -0.0625, 0.125},
			{-0.0625, -0.125, -0.125, 0.0625, -0.0625, -0.0625},
			{-0.0625, -0.125, 0.0625, 0.0625, -0.0625, 0.125},
			{-0.1875, -0.1875, -0.1875, 0.1875, -0.125, -0.125},
			{-0.1875, -0.1875, 0.125, 0.1875, -0.125, 0.1875},
			{-0.1875, -0.1875, -0.125, -0.125, -0.125, 0.125},
			{0.125, -0.1875, -0.125, 0.1875, -0.125, 0.125},
			{-0.25, -0.25, -0.25, -0.1875, -0.1875, 0.25},
			{0.1875, -0.25, -0.25, 0.25, -0.1875, 0.25},
			{-0.1875, -0.25, -0.25, 0.1875, -0.1875, -0.1875},
			{-0.1875, -0.25, 0.1875, 0.1875, -0.1875, 0.25},
			{-0.3125, -0.3125, 0.25, 0.3125, -0.25, 0.3125},
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.25},
			{0.25, -0.3125, -0.25, 0.3125, -0.25, 0.25},
			{-0.3125, -0.3125, -0.25, -0.25, -0.25, 0.25},
			{-0.375, -0.375, -0.375, -0.3125, -0.3125, 0.375},
			{0.3125, -0.375, -0.375, 0.375, -0.3125, 0.375},
			{-0.3125, -0.375, -0.375, 0.3125, -0.3125, -0.3125},
			{-0.3125, -0.375, 0.3125, 0.3125, -0.3125, 0.375},
			{-0.4375, -0.4375, 0.375, 0.4375, -0.375, 0.4375},
			{-0.4375, -0.4375, -0.4375, 0.4375, -0.375, -0.375},
			{-0.4375, -0.4375, -0.4375, -0.375, -0.375, 0.4375},
			{0.375, -0.4375, -0.375, 0.4375, -0.375, 0.375},
			-- right (X+)
			{0, -0.0625, -0.0625, 0.0625, 0.0625, 0.0625},
			{0.0625, -0.125, -0.125, 0.125, 0.125, -0.0625},
			{0.0625, -0.125, 0.0625, 0.125, 0.125, 0.125},
			{0.0625, -0.125, -0.0625, 0.125, -0.0625, 0.0625},
			{0.0625, 0.0625, -0.0625, 0.125, 0.125, 0.0625},
			{0.125, -0.1875, -0.1875, 0.1875, -0.125, 0.1875},
			{0.125, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
			{0.125, -0.125, 0.125, 0.1875, 0.125, 0.1875},
			{0.125, -0.125, -0.1875, 0.1875, 0.125, -0.125},
			{0.1875, -0.25, 0.1875, 0.25, 0.25, 0.25},
			{0.1875, -0.25, -0.25, 0.25, 0.25, -0.1875},
			{0.1875, -0.25, -0.1875, 0.25, -0.1875, 0.1875},
			{0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.1875},
			{0.25, 0.25, -0.3125, 0.3125, 0.3125, 0.3125},
			{0.25, -0.3125, -0.3125, 0.3125, -0.25, 0.3125},
			{0.25, -0.25, -0.3125, 0.3125, 0.25, -0.25},
			{0.25, -0.25, 0.25, 0.3125, 0.25, 0.3125},
			{0.3125, -0.375, 0.3125, 0.375, 0.375, 0.375},
			{0.3125, -0.375, -0.375, 0.375, 0.375, -0.3125},
			{0.3125, -0.375, -0.3125, 0.375, -0.3125, 0.3125},
			{0.3125, 0.3125, -0.3125, 0.375, 0.375, 0.3125},
			{0.375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{0.375, -0.4375, -0.4375, 0.4375, -0.375, 0.4375},
			{0.375, -0.4375, 0.375, 0.4375, 0.4375, 0.4375},
			{0.375, -0.375, -0.4375, 0.4375, 0.375, -0.375},
			-- left (X-)
			{-0.0625, -0.0625, -0.0625, -0, 0.0625, 0.0625},
			{-0.125, -0.125, 0.0625, -0.0625, 0.125, 0.125},
			{-0.125, -0.125, -0.125, -0.0625, 0.125, -0.0625},
			{-0.125, -0.125, -0.0625, -0.0625, -0.0625, 0.0625},
			{-0.125, 0.0625, -0.0625, -0.0625, 0.125, 0.0625},
			{-0.1875, -0.1875, -0.1875, -0.125, -0.125, 0.1875},
			{-0.1875, 0.125, -0.1875, -0.125, 0.1875, 0.1875},
			{-0.1875, -0.125, -0.1875, -0.125, 0.125, -0.125},
			{-0.1875, -0.125, 0.125, -0.125, 0.125, 0.1875},
			{-0.25, -0.25, -0.25, -0.1875, 0.25, -0.1875},
			{-0.25, -0.25, 0.1875, -0.1875, 0.25, 0.25},
			{-0.25, -0.25, -0.1875, -0.1875, -0.1875, 0.1875},
			{-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.1875},
			{-0.3125, 0.25, -0.3125, -0.25, 0.3125, 0.3125},
			{-0.3125, -0.3125, -0.3125, -0.25, -0.25, 0.3125},
			{-0.3125, -0.25, 0.25, -0.25, 0.25, 0.3125},
			{-0.3125, -0.25, -0.3125, -0.25, 0.25, -0.25},
			{-0.375, -0.375, -0.375, -0.3125, 0.375, -0.3125},
			{-0.375, -0.375, 0.3125, -0.3125, 0.375, 0.375},
			{-0.375, -0.375, -0.3125, -0.3125, -0.3125, 0.3125},
			{-0.375, 0.3125, -0.3125, -0.3125, 0.375, 0.3125},
			{-0.4375, 0.375, -0.4375, -0.375, 0.4375, 0.4375},
			{-0.4375, -0.4375, -0.4375, -0.375, -0.375, 0.4375},
			{-0.4375, -0.4375, -0.4375, -0.375, 0.4375, -0.375},
			{-0.4375, -0.375, 0.375, -0.375, 0.375, 0.4375},
			-- back (Z+)
			{-0.0625, -0.0625, 0, 0.0625, 0.0625, 0.0625},
			{0.0625, -0.125, 0.0625, 0.125, 0.125, 0.125},
			{-0.125, -0.125, 0.0625, -0.0625, 0.125, 0.125},
			{-0.0625, -0.125, 0.0625, 0.0625, -0.0625, 0.125},
			{-0.0625, 0.0625, 0.0625, 0.0625, 0.125, 0.125},
			{-0.1875, -0.1875, 0.125, 0.1875, -0.125, 0.1875},
			{-0.1875, 0.125, 0.125, 0.1875, 0.1875, 0.1875},
			{-0.1875, -0.125, 0.125, -0.125, 0.125, 0.1875},
			{0.125, -0.125, 0.125, 0.1875, 0.125, 0.1875},
			{-0.25, -0.25, 0.1875, -0.1875, 0.25, 0.25},
			{0.1875, -0.25, 0.1875, 0.25, 0.25, 0.25},
			{-0.1875, -0.25, 0.1875, 0.1875, -0.1875, 0.25},
			{-0.1875, 0.1875, 0.1875, 0.1875, 0.25, 0.25},
			{-0.3125, 0.25, 0.25, 0.3125, 0.3125, 0.3125},
			{-0.3125, -0.3125, 0.25, 0.3125, -0.25, 0.3125},
			{0.25, -0.25, 0.25, 0.3125, 0.25, 0.3125},
			{-0.3125, -0.25, 0.25, -0.25, 0.25, 0.3125},
			{-0.375, -0.375, 0.3125, -0.3125, 0.375, 0.375},
			{0.3125, -0.375, 0.3125, 0.375, 0.375, 0.375},
			{-0.3125, -0.375, 0.3125, 0.3125, -0.3125, 0.375},
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.375, 0.375},
			{-0.4375, 0.375, 0.375, 0.4375, 0.4375, 0.4375},
			{-0.4375, -0.4375, 0.375, 0.4375, -0.375, 0.4375},
			{-0.4375, -0.4375, 0.375, -0.375, 0.4375, 0.4375},
			{0.375, -0.375, 0.375, 0.4375, 0.375, 0.4375},
			-- front (Z-)
			{-0.0625, -0.0625, -0.0625, 0.0625, 0.0625, -0},
			{-0.125, -0.125, -0.125, -0.0625, 0.125, -0.0625},
			{0.0625, -0.125, -0.125, 0.125, 0.125, -0.0625},
			{-0.0625, -0.125, -0.125, 0.0625, -0.0625, -0.0625},
			{-0.0625, 0.0625, -0.125, 0.0625, 0.125, -0.0625},
			{-0.1875, -0.1875, -0.1875, 0.1875, -0.125, -0.125},
			{-0.1875, 0.125, -0.1875, 0.1875, 0.1875, -0.125},
			{0.125, -0.125, -0.1875, 0.1875, 0.125, -0.125},
			{-0.1875, -0.125, -0.1875, -0.125, 0.125, -0.125},
			{0.1875, -0.25, -0.25, 0.25, 0.25, -0.1875},
			{-0.25, -0.25, -0.25, -0.1875, 0.25, -0.1875},
			{-0.1875, -0.25, -0.25, 0.1875, -0.1875, -0.1875},
			{-0.1875, 0.1875, -0.25, 0.1875, 0.25, -0.1875},
			{-0.3125, 0.25, -0.3125, 0.3125, 0.3125, -0.25},
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.25},
			{-0.3125, -0.25, -0.3125, -0.25, 0.25, -0.25},
			{0.25, -0.25, -0.3125, 0.3125, 0.25, -0.25},
			{0.3125, -0.375, -0.375, 0.375, 0.375, -0.3125},
			{-0.375, -0.375, -0.375, -0.3125, 0.375, -0.3125},
			{-0.3125, -0.375, -0.375, 0.3125, -0.3125, -0.3125},
			{-0.3125, 0.3125, -0.375, 0.3125, 0.375, -0.3125},
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, -0.375},
			{-0.4375, -0.4375, -0.4375, 0.4375, -0.375, -0.375},
			{0.375, -0.4375, -0.4375, 0.4375, 0.4375, -0.375},
			{-0.4375, -0.375, -0.4375, -0.375, 0.375, -0.375},
			-- corner frame
			{-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
			{-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
			{-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
			{-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
			{0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
			{0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
			{-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
			{0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
			{-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
})

local nbea, sounds = {}, {}

function nbea.stop_sound(pos)
	local spos = minetest.hash_node_position(pos)
	if sounds[spos] then minetest.sound_stop(sounds[spos]) end
end

minetest.override_item("nbea:nbox_009", {
	groups = {cracky = 3, mesecon_effector_off = 1, mesecon = 1},
	on_construct = function(pos)
            nbea.stop_sound(pos)
	end,
	mesecons = {effector = {
        state = mesecon.state.off,
        action_on = function (pos, node)
            minetest.swap_node(pos, {name = "nbea:nbox_009_on"})
            local spos = minetest.hash_node_position(pos)
            sounds[spos] =minetest.sound_play("nbea_mc",{pos=pos, max_hear_distance=10, gain=1.25, loop=true})
        end,
    }},
})

minetest.register_node("nbea:nbox_009_on", {
	description = "Monochrome",
	tiles = {
		{image = "nbea_monochrome2.png",
		backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0
			},
		}
	},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
    	drop = "nbea:nbox_009",
	groups = {cracky = 3, mesecon = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_metal_defaults({
		place = {name = "default_metal_footstep", gain = 0.5},
		dig = {name = "default_metal_footstep", gain = 1.0},
		dug = {name = "default_metal_footstep", gain = 1.0},
	}),
	on_destruct = function(pos)
            nbea.stop_sound(pos)
	end,
	mesecons = {effector = {
        state = mesecon.state.on,
        action_off = function (pos, node)
            nbea.stop_sound(pos)
            minetest.swap_node(pos, {name = "nbea:nbox_009"})
        end,
    }},
	node_box = {
		type = "fixed",
		fixed = {
			-- top (Y+)
			{-0.0625, 0, -0.0625, 0.0625, 0.0625, 0.0625},
			{-0.125, 0.0625, -0.125, 0.125, 0.125, -0.0625},
			{-0.125, 0.0625, 0.0625, 0.125, 0.125, 0.125},
			{0.0625, 0.0625, -0.0625, 0.125, 0.125, 0.0625},
			{-0.125, 0.0625, -0.0625, -0.0625, 0.125, 0.0625},
			{0.125, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
			{-0.1875, 0.125, -0.1875, -0.125, 0.1875, 0.1875},
			{-0.125, 0.125, 0.125, 0.125, 0.1875, 0.1875},
			{-0.125, 0.125, -0.1875, 0.125, 0.1875, -0.125},
			{-0.25, 0.1875, 0.1875, 0.25, 0.25, 0.25},
			{-0.25, 0.1875, -0.25, 0.25, 0.25, -0.1875},
			{0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.1875},
			{-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.1875},
			{-0.3125, 0.25, -0.3125, -0.25, 0.3125, 0.3125},
			{0.25, 0.25, -0.3125, 0.3125, 0.3125, 0.3125},
			{-0.25, 0.25, -0.3125, 0.25, 0.3125, -0.25},
			{-0.25, 0.25, 0.25, 0.25, 0.3125, 0.3125},
			{-0.375, 0.3125, 0.3125, 0.375, 0.375, 0.375},
			{-0.375, 0.3125, -0.375, 0.375, 0.375, -0.3125},
			{0.3125, 0.3125, -0.3125, 0.375, 0.375, 0.3125},
			{-0.375, 0.3125, -0.3125, -0.3125, 0.375, 0.3125},
			{-0.4375, 0.375, -0.4375, -0.375, 0.4375, 0.4375},
			{0.375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{-0.4375, 0.375, 0.375, 0.4375, 0.4375, 0.4375},
			{-0.375, 0.375, -0.4375, 0.375, 0.4375, -0.375},
			-- bottom (Y-)
			{-0.0625, -0.0625, -0.0625, 0.0625, -0, 0.0625},
			{0.0625, -0.125, -0.125, 0.125, -0.0625, 0.125},
			{-0.125, -0.125, -0.125, -0.0625, -0.0625, 0.125},
			{-0.0625, -0.125, -0.125, 0.0625, -0.0625, -0.0625},
			{-0.0625, -0.125, 0.0625, 0.0625, -0.0625, 0.125},
			{-0.1875, -0.1875, -0.1875, 0.1875, -0.125, -0.125},
			{-0.1875, -0.1875, 0.125, 0.1875, -0.125, 0.1875},
			{-0.1875, -0.1875, -0.125, -0.125, -0.125, 0.125},
			{0.125, -0.1875, -0.125, 0.1875, -0.125, 0.125},
			{-0.25, -0.25, -0.25, -0.1875, -0.1875, 0.25},
			{0.1875, -0.25, -0.25, 0.25, -0.1875, 0.25},
			{-0.1875, -0.25, -0.25, 0.1875, -0.1875, -0.1875},
			{-0.1875, -0.25, 0.1875, 0.1875, -0.1875, 0.25},
			{-0.3125, -0.3125, 0.25, 0.3125, -0.25, 0.3125},
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.25},
			{0.25, -0.3125, -0.25, 0.3125, -0.25, 0.25},
			{-0.3125, -0.3125, -0.25, -0.25, -0.25, 0.25},
			{-0.375, -0.375, -0.375, -0.3125, -0.3125, 0.375},
			{0.3125, -0.375, -0.375, 0.375, -0.3125, 0.375},
			{-0.3125, -0.375, -0.375, 0.3125, -0.3125, -0.3125},
			{-0.3125, -0.375, 0.3125, 0.3125, -0.3125, 0.375},
			{-0.4375, -0.4375, 0.375, 0.4375, -0.375, 0.4375},
			{-0.4375, -0.4375, -0.4375, 0.4375, -0.375, -0.375},
			{-0.4375, -0.4375, -0.4375, -0.375, -0.375, 0.4375},
			{0.375, -0.4375, -0.375, 0.4375, -0.375, 0.375},
			-- right (X+)
			{0, -0.0625, -0.0625, 0.0625, 0.0625, 0.0625},
			{0.0625, -0.125, -0.125, 0.125, 0.125, -0.0625},
			{0.0625, -0.125, 0.0625, 0.125, 0.125, 0.125},
			{0.0625, -0.125, -0.0625, 0.125, -0.0625, 0.0625},
			{0.0625, 0.0625, -0.0625, 0.125, 0.125, 0.0625},
			{0.125, -0.1875, -0.1875, 0.1875, -0.125, 0.1875},
			{0.125, 0.125, -0.1875, 0.1875, 0.1875, 0.1875},
			{0.125, -0.125, 0.125, 0.1875, 0.125, 0.1875},
			{0.125, -0.125, -0.1875, 0.1875, 0.125, -0.125},
			{0.1875, -0.25, 0.1875, 0.25, 0.25, 0.25},
			{0.1875, -0.25, -0.25, 0.25, 0.25, -0.1875},
			{0.1875, -0.25, -0.1875, 0.25, -0.1875, 0.1875},
			{0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.1875},
			{0.25, 0.25, -0.3125, 0.3125, 0.3125, 0.3125},
			{0.25, -0.3125, -0.3125, 0.3125, -0.25, 0.3125},
			{0.25, -0.25, -0.3125, 0.3125, 0.25, -0.25},
			{0.25, -0.25, 0.25, 0.3125, 0.25, 0.3125},
			{0.3125, -0.375, 0.3125, 0.375, 0.375, 0.375},
			{0.3125, -0.375, -0.375, 0.375, 0.375, -0.3125},
			{0.3125, -0.375, -0.3125, 0.375, -0.3125, 0.3125},
			{0.3125, 0.3125, -0.3125, 0.375, 0.375, 0.3125},
			{0.375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375},
			{0.375, -0.4375, -0.4375, 0.4375, -0.375, 0.4375},
			{0.375, -0.4375, 0.375, 0.4375, 0.4375, 0.4375},
			{0.375, -0.375, -0.4375, 0.4375, 0.375, -0.375},
			-- left (X-)
			{-0.0625, -0.0625, -0.0625, -0, 0.0625, 0.0625},
			{-0.125, -0.125, 0.0625, -0.0625, 0.125, 0.125},
			{-0.125, -0.125, -0.125, -0.0625, 0.125, -0.0625},
			{-0.125, -0.125, -0.0625, -0.0625, -0.0625, 0.0625},
			{-0.125, 0.0625, -0.0625, -0.0625, 0.125, 0.0625},
			{-0.1875, -0.1875, -0.1875, -0.125, -0.125, 0.1875},
			{-0.1875, 0.125, -0.1875, -0.125, 0.1875, 0.1875},
			{-0.1875, -0.125, -0.1875, -0.125, 0.125, -0.125},
			{-0.1875, -0.125, 0.125, -0.125, 0.125, 0.1875},
			{-0.25, -0.25, -0.25, -0.1875, 0.25, -0.1875},
			{-0.25, -0.25, 0.1875, -0.1875, 0.25, 0.25},
			{-0.25, -0.25, -0.1875, -0.1875, -0.1875, 0.1875},
			{-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.1875},
			{-0.3125, 0.25, -0.3125, -0.25, 0.3125, 0.3125},
			{-0.3125, -0.3125, -0.3125, -0.25, -0.25, 0.3125},
			{-0.3125, -0.25, 0.25, -0.25, 0.25, 0.3125},
			{-0.3125, -0.25, -0.3125, -0.25, 0.25, -0.25},
			{-0.375, -0.375, -0.375, -0.3125, 0.375, -0.3125},
			{-0.375, -0.375, 0.3125, -0.3125, 0.375, 0.375},
			{-0.375, -0.375, -0.3125, -0.3125, -0.3125, 0.3125},
			{-0.375, 0.3125, -0.3125, -0.3125, 0.375, 0.3125},
			{-0.4375, 0.375, -0.4375, -0.375, 0.4375, 0.4375},
			{-0.4375, -0.4375, -0.4375, -0.375, -0.375, 0.4375},
			{-0.4375, -0.4375, -0.4375, -0.375, 0.4375, -0.375},
			{-0.4375, -0.375, 0.375, -0.375, 0.375, 0.4375},
			-- back (Z+)
			{-0.0625, -0.0625, 0, 0.0625, 0.0625, 0.0625},
			{0.0625, -0.125, 0.0625, 0.125, 0.125, 0.125},
			{-0.125, -0.125, 0.0625, -0.0625, 0.125, 0.125},
			{-0.0625, -0.125, 0.0625, 0.0625, -0.0625, 0.125},
			{-0.0625, 0.0625, 0.0625, 0.0625, 0.125, 0.125},
			{-0.1875, -0.1875, 0.125, 0.1875, -0.125, 0.1875},
			{-0.1875, 0.125, 0.125, 0.1875, 0.1875, 0.1875},
			{-0.1875, -0.125, 0.125, -0.125, 0.125, 0.1875},
			{0.125, -0.125, 0.125, 0.1875, 0.125, 0.1875},
			{-0.25, -0.25, 0.1875, -0.1875, 0.25, 0.25},
			{0.1875, -0.25, 0.1875, 0.25, 0.25, 0.25},
			{-0.1875, -0.25, 0.1875, 0.1875, -0.1875, 0.25},
			{-0.1875, 0.1875, 0.1875, 0.1875, 0.25, 0.25},
			{-0.3125, 0.25, 0.25, 0.3125, 0.3125, 0.3125},
			{-0.3125, -0.3125, 0.25, 0.3125, -0.25, 0.3125},
			{0.25, -0.25, 0.25, 0.3125, 0.25, 0.3125},
			{-0.3125, -0.25, 0.25, -0.25, 0.25, 0.3125},
			{-0.375, -0.375, 0.3125, -0.3125, 0.375, 0.375},
			{0.3125, -0.375, 0.3125, 0.375, 0.375, 0.375},
			{-0.3125, -0.375, 0.3125, 0.3125, -0.3125, 0.375},
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.375, 0.375},
			{-0.4375, 0.375, 0.375, 0.4375, 0.4375, 0.4375},
			{-0.4375, -0.4375, 0.375, 0.4375, -0.375, 0.4375},
			{-0.4375, -0.4375, 0.375, -0.375, 0.4375, 0.4375},
			{0.375, -0.375, 0.375, 0.4375, 0.375, 0.4375},
			-- front (Z-)
			{-0.0625, -0.0625, -0.0625, 0.0625, 0.0625, -0},
			{-0.125, -0.125, -0.125, -0.0625, 0.125, -0.0625},
			{0.0625, -0.125, -0.125, 0.125, 0.125, -0.0625},
			{-0.0625, -0.125, -0.125, 0.0625, -0.0625, -0.0625},
			{-0.0625, 0.0625, -0.125, 0.0625, 0.125, -0.0625},
			{-0.1875, -0.1875, -0.1875, 0.1875, -0.125, -0.125},
			{-0.1875, 0.125, -0.1875, 0.1875, 0.1875, -0.125},
			{0.125, -0.125, -0.1875, 0.1875, 0.125, -0.125},
			{-0.1875, -0.125, -0.1875, -0.125, 0.125, -0.125},
			{0.1875, -0.25, -0.25, 0.25, 0.25, -0.1875},
			{-0.25, -0.25, -0.25, -0.1875, 0.25, -0.1875},
			{-0.1875, -0.25, -0.25, 0.1875, -0.1875, -0.1875},
			{-0.1875, 0.1875, -0.25, 0.1875, 0.25, -0.1875},
			{-0.3125, 0.25, -0.3125, 0.3125, 0.3125, -0.25},
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.25},
			{-0.3125, -0.25, -0.3125, -0.25, 0.25, -0.25},
			{0.25, -0.25, -0.3125, 0.3125, 0.25, -0.25},
			{0.3125, -0.375, -0.375, 0.375, 0.375, -0.3125},
			{-0.375, -0.375, -0.375, -0.3125, 0.375, -0.3125},
			{-0.3125, -0.375, -0.375, 0.3125, -0.3125, -0.3125},
			{-0.3125, 0.3125, -0.375, 0.3125, 0.375, -0.3125},
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, -0.375},
			{-0.4375, -0.4375, -0.4375, 0.4375, -0.375, -0.375},
			{0.375, -0.4375, -0.4375, 0.4375, 0.4375, -0.375},
			{-0.4375, -0.375, -0.4375, -0.375, 0.375, -0.375},
			-- corner frame
			{-0.4375, 0.4375, 0.4375, 0.4375, 0.5, 0.5},
			{-0.4375, -0.5, 0.4375, 0.4375, -0.4375, 0.5},
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
			{-0.5, 0.4375, -0.4375, -0.4375, 0.5, 0.4375},
			{-0.5, -0.5, -0.4375, -0.4375, -0.4375, 0.4375},
			{0.4375, 0.4375, -0.4375, 0.5, 0.5, 0.4375},
			{0.4375, -0.5, -0.4375, 0.5, -0.4375, 0.4375},
			{-0.5, 0.4375, -0.5, 0.5, 0.5, -0.4375},
			{-0.5, -0.5, -0.5, 0.5, -0.4375, -0.4375},
			{0.4375, -0.4375, -0.5, 0.5, 0.4375, -0.4375},
			{-0.5, -0.4375, -0.5, -0.4375, 0.4375, -0.4375},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
})
]]--
