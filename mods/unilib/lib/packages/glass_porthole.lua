---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_porthole = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_porthole.init()

    return {
        description = "Porthole set",
        notes = "This package creates portholes from a limited range of super trees",
        depends = {"glass_ordinary", "metal_steel"},
    }

end

function unilib.pkg.glass_porthole.post()

    local c_glass = "unilib:glass_ordinary"
    local porthole_table = {}

    -- Currently, only a small selection of porthole variants are available
    local update_list = {
        {
            part_name = "acacia",
            orig_part_name = nil,
        },
        {
            part_name = "apple",
            orig_part_name = "wood",
        },
        {
            part_name = "aspen",
            orig_part_name = nil
        },
        {
            part_name = "jungle",
            orig_part_name = "junglewood",
        },
        {
            part_name = "pine",
            orig_part_name = nil
        },
    }

    for _, mini_table in pairs(update_list) do

        if unilib.global.super_tree_table[mini_table.part_name] ~= nil then
            porthole_table[mini_table.part_name] = mini_table
        end

    end

    for _, mini_table in pairs(porthole_table) do

        local data_table = unilib.global.tree_table[mini_table.part_name]
        local ingredient = mini_table.ingredient or
                "unilib:tree_" .. mini_table.part_name .. "_wood"

        if unilib.global.pkg_executed_table["tree_" .. mini_table.part_name] ~= nil and
                core.registered_nodes[ingredient] ~= nil then

            local orig_name = nil
            if mini_table.orig_part_name ~= nil then
                orig_name = "abriglass:porthole_" .. mini_table.orig_part_name
            end

            unilib.register_node(
                -- From abriglass:porthole_wood, etc. Creates unilib:glass_porthole_wood_apple, etc
                "unilib:glass_porthole_wood_" .. mini_table.part_name,
                orig_name,
                mode,
                {
                    description = data_table.description,
                    tiles = {
                        "unilib_tree_" .. mini_table.part_name .. "_wood.png",
                        "unilib_tree_" .. mini_table.part_name .. "_wood.png",
                        "unilib_tree_" .. mini_table.part_name .. "_wood.png",
                        "unilib_tree_" .. mini_table.part_name .. "_wood.png",
                        "unilib_glass_porthole_wood_" .. mini_table.part_name .. ".png",
                    },
                    groups = {choppy = 2, flammable = 2, wood = 1},
                    -- N.B. no sounds in original code
                    sounds = unilib.global.sound_table.wood,

                    drawtype = "nodebox",
                    is_ground_content = false,
                    node_box = {
                        type = "fixed",
                        fixed = {
                            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
                        },
                    },
                    paramtype = "light",
                    paramtype2 = "facedir",
                    sunlight_propagates = true,
                    use_texture_alpha = "clip",
                }
            )
            unilib.register_craft({
                -- From abriglass:porthole_wood, etc
                output = "unilib:glass_porthole_wood_" .. mini_table.part_name .. " 4",
                recipe = {
                    {c_glass, "", c_glass},
                    {ingredient, "", "unilib:metal_steel_ingot"},
                    {c_glass, "", c_glass},
                },
            })

        end

    end

end
