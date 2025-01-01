-- carts/rails.lua

-- support for MT game translation.
local S = carts.get_translator

-- @@@ Temporarily provide nodes, because techage wants to override them

carts:register_rail("carts:rail", {
	description = S("Rail"),
	tiles = {
		"carts_rail_straight.png", "carts_rail_curved.png",
		"carts_rail_t_junction.png", "carts_rail_crossing.png"
	},
	inventory_image = "carts_rail_straight.png",
	wield_image = "carts_rail_straight.png",
	groups = carts:get_rail_groups(),
}, {})

carts:register_rail("carts:powerrail", {
	description = S("Powered Rail"),
	tiles = {
		"carts_rail_straight_pwr.png", "carts_rail_curved_pwr.png",
		"carts_rail_t_junction_pwr.png", "carts_rail_crossing_pwr.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = 5})

carts:register_rail("carts:brakerail", {
	description = S("Brake Rail"),
	tiles = {
		"carts_rail_straight_brk.png", "carts_rail_curved_brk.png",
		"carts_rail_t_junction_brk.png", "carts_rail_crossing_brk.png"
	},
	groups = carts:get_rail_groups(),
}, {acceleration = -3})

-- @@@ Once the definitions have been overriden, we can hide them

minetest.after(0.1, function()

    for _, full_name in pairs({"carts:rail", "carts:powerrail", "carts:brakerail"}) do
        
        local def_table = minetest.registered_nodes[full_name]
        if def_table ~= nil then

            local group_table = def_table.groups
            group_table.not_in_creative_inventory = 1

            minetest.override_item(full_name, {
                groups = group_table,
            })
            
        end

    end

end)
