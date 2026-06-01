-- mods/default/craftitems.lua

-- support for MT game translation.
local S = default.get_translator

-- @@@ Temporarily provide craftitems, because technic wants to override them

minetest.register_craftitem("default:steel_ingot", {
	description = S("Steel Ingot"),
	inventory_image = "default_steel_ingot.png"
})

-- @@@ Once the definitions have been overriden, we can hide them

core.register_on_mods_loaded(function()

    for _, full_name in pairs({"default:steel_ingot"}) do
        
        local def_table = core.registered_craftitems[full_name]
        if def_table ~= nil then

            local group_table = table.copy(def_table.groups)
            group_table.not_in_creative_inventory = 1

            core.override_item(full_name, {
                groups = group_table,
            })
            
        end

    end

end)
