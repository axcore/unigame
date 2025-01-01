---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- metals_molten.lua
--      API functions for molten metals
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- API functions for molten metals
---------------------------------------------------------------------------------------------------

function unilib.metals._register_metal_molten(data_table)

    -- Adapted from GLEMr11, lib_materials:liquid_metal_copper_source and
    --      lib_materials:liquid_metal_copper_flowing
    -- Creates a molten metal, with source and flowing nodes, that cools into a metal block
    --
    -- Can also be called by suitable non-metal materials (e.g. is called by the "mineral_mese"
    --      package)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "copper"
    --      source_orig_name (str): e.g. "lib_materials:liquid_molten_copper_source"
    --      flowing_orig_name (str): e.g. "lib_materials:liquid_molten_copper_flowing"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      cooled_name (str): The full_name of the node produced when the molten source is cooled
    --          (e.g. by contact with water); if not specified, the metal block is used. Use an
    --          empty string to prevent cooling. The code checks that a metal block exists, so it's
    --          not necessary to pass an empty string for that reason
    --      source_description (str): e.g. "Molten Copper Source"
    --      flowing_description (str): e.g. "Flowing Molten Copper"
    --      source_length (float): Use in the animation, e.g. 3
    --      flowing_length (float): Used in the animation, e.g. 3.3
    --      non_metal_flag (bool): true for non-metals like mese

    local part_name = data_table.part_name
    local source_orig_name = data_table.source_orig_name
    local flowing_orig_name = data_table.flowing_orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local cooled_name = data_table.cooled_name or "unilib:metal_" .. part_name .. "_block"
    local source_description = data_table.source_description or S("Molten Metal Source")
    local flowing_description = data_table.flowing_description or S("Flowing Molten Metal")
    local source_length = data_table.source_length or 3
    local flowing_length = data_table.flowing_length or 3.3
    local non_metal_flag = data_table.non_metal_flag or false

    local source_name = "unilib:liquid_molten_" .. part_name .. "_source"
    local flowing_name = "unilib:liquid_molten_" .. part_name .. "_flowing"

    local source_group_table = {igniter = 1, metal = 1, liquid = 3}
    local flowing_group_table = {igniter = 1, liquid = 3, metal = 1, not_in_creative_inventory = 1}
    if non_metal_flag then

        source_group_table.metal = nil
        flowing_group_table.metal = nil

        if source_description == S("Molten Metal Source") then
            source_description = S("Molten Material Source")
        end

        if source_description == S("Flowing Molten Metal") then
            source_description = S("Flowing Molten Material")
        end

    end

    unilib.register_node(source_name, source_orig_name, replace_mode, {
        description = source_description,
        tiles = {
            {
                name = "unilib_liquid_molten_" .. part_name .. "_source_animated.png",
                animation = {
                    type = "vertical_frames",
                    length = source_length,
                    aspect_h = 16,
                    aspect_w = 16,
                },
                backface_culling = false,
            },
            {
                name = "unilib_liquid_molten_" .. part_name .. "_source_animated.png",
                animation = {
                    type = "vertical_frames",
                    length = source_length,
                    aspect_h = 16,
                    aspect_w = 16,
                },
                backface_culling = true,
            },
        },
        groups = source_group_table,
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 6,
        diggable = false,
        drawtype = "liquid",
        -- N.B. is_ground_content = false not in original code; added to match other liquids
        is_ground_content = false,
        light_source = 8,
        liquid_alternative_flowing = flowing_name,
        liquid_alternative_source = source_name,
        -- N.B. liquid_range = 3 not in original code
        liquid_range = 3,
        liquid_renewable = false,
        -- N.B. liquid_viscosity = 1 in original code
        liquid_viscosity = 7,
        liquidtype = "source",
        paramtype = "light",
        pointable = false,
        walkable = false,
    }
    )
    unilib.register_craft({
        -- Original to unilib. Quarter of the burntime of ordinary lava
        type = "fuel",
        recipe = source_name,
        burntime = 15,
    })
    -- (Check that the block exists, before trying to produce it)
    if core.registered_nodes[cooled_name] ~= nil then

        unilib.register_lava({
            cooled_name = cooled_name,
            lava_name = source_name
        })

    end

    unilib.register_node(flowing_name, flowing_orig_name, replace_mode, {
        description = flowing_description,
        tiles = {"unilib_liquid_molten_" .. part_name .. "_source.png"},
        groups = flowing_group_table,
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 6,
        diggable = false,
        drawtype = "flowingliquid",
        -- N.B. is_ground_content = false not in original code; added to match other liquids
        is_ground_content = false,
        light_source = 8,
        liquid_alternative_flowing = flowing_name,
        liquid_alternative_source = source_name,
        -- N.B. liquid_range = 3 not in original code
        liquid_range = 3,
        liquid_renewable = false,
        -- N.B. liquid_viscosity = 1 in original code
        liquid_viscosity = 7,
        liquidtype = "flowing",
        paramtype = "light",
        paramtype2 = "flowingliquid",
        pointable = false,
        special_tiles = {
            {
                name = "unilib_liquid_molten_" .. part_name .. "_flowing_animated.png",
                animation = {
                    type = "vertical_frames",
                    length = flowing_length,
                    aspect_h = 16,
                    aspect_w = 16,
                },
                backface_culling = false,
            },
            {
                name = "unilib_liquid_molten_" .. part_name .. "_flowing_animated.png",
                animation = {
                    type = "vertical_frames",
                    length = flowing_length,
                    aspect_h = 16,
                    aspect_w = 16,
                },
                backface_culling = true,
            },
        },
        walkable = false,
    })

end
