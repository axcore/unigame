-- dye/init.lua

dye = {}

-- Load support for MT game translation.
local S = minetest.get_translator("dye")

-- Make dye names and descriptions available globally

dye.dyes = {}

-- Define items

for _, row in ipairs(dye.dyes) do
    local name = row[1]
    local description = row[2]
    local groups = {dye = 1}
    groups["color_" .. name] = 1

    minetest.register_craftitem("dye:" .. name, {
        inventory_image = "dye_" .. name .. ".png",
        description = S(description .. " Dye"),
        groups = groups
    })

    minetest.register_craft({
        output = "dye:" .. name .. " 4",
        recipe = {
            {"group:flower,color_" .. name}
        },
    })
end
