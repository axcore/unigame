---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- metals.lua
--      Set up shared functions for metals
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Shared functions - register
---------------------------------------------------------------------------------------------------

function unilib.register_metal(data_table)

    -- Original to unilib
    -- Registers the metal type in a global variable
    --
    -- data_table compulsory fields:
    --      part_name (str): Metals have a consistent naming system. All nodes/items from the
    --          same metal share a common component, e.g. "tin" from "unilib:metal_tin_lump", etc
    --      description (str): A string used as the basis for the .description field in all
    --          derivative nodes (e.g. "Tin")
    --
    -- data_table optional fields:
    --      alloy_flag (bool): If true, this metal is an alloy. Alloy is used in the losest sense,
    --          so that even wrought iron qualifies as an alloy. Code creating ores from various
    --          metals should not create them using alloys
    --      fictional_flag (bool): If true, this metal does not exist in reality. This
    --          classification applies in the broadest sense; "unilib:metal_tin_real_ingot" is not
    --          regarded as fictional, because tin itself is not fictional
    --      hardness (int): Value of the hardness of the metal ore in the range 1-5, corresponding
    --          to the PFAA classification:
    --              UNILIB  PFAA            CRACKY
    --              1       weak            3
    --              2       medium          2
    --              3       strong          1
    --              4       very strong     1
    --              5       n/a             0
    --          N.B. Currently, no metals have strength 4, and strength 5 is intended for fictional
    --              metals that require special tools (such as those from the xtraores mod)
    --          N.B. Metals that can be produced only artificially, and in small quantities, and
    --              which are extremely unlikely to be used in an ore, have been given a hardness
    --              value of 1
    --          N.B. Alloys such as brass and bronze have been given a hardness value, even though
    --              they are never used in ores
    --      powder_flag (bool): If true, a powder variant exists

    local part_name = data_table.part_name
    local description = data_table.description

    local alloy_flag = data_table.alloy_flag or false
    local fictional_flag = data_table.fictional_flag or false
    local hardness = data_table.hardness or 1
    local powder_flag = data_table.powder_flag or false

    -- Update the global variable
    unilib.metal_table[part_name] = {
        part_name = part_name,
        description = description,

        alloy_flag = alloy_flag,
        fictional_flag = fictional_flag,
        hardness = hardness,
        powder_flag = powder_flag,
    }

end

function unilib.register_metal_powder(data_table)

    -- Adapted from technic/technic/machines/register/grinder_recipes.lua and xtraores/init.lua
    -- Creates a metal powder item (the equivalent to dust in technic's original code)
    -- Note that metal samples can't be ground into powder; neither can metal chunks (the equivalent
    --      of crystals)
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "palatinium"
    --      orig_name (str): e.g. "xtraores:palatinium_dust"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Palatinium Powder"
    --      ingot_time (int): Grinding time for converting ingots into powder, in seconds
    --      lump_time (int): Grinding time for converting lumps into powder, in seconds
    --      no_lump_flag (bool): If true, there is no lump, only an ingot
    --
    -- Return values:
    --      The full_name of the new craftitem, or nil if technic is not available

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Metal Powder")
    local ingot_time = data_table.ingot_time or 3
    local lump_time = data_table.lump_time or 3
    local no_lump_flag = data_table.no_lump_flag or false

    local full_name = "unilib:metal_" .. part_name .. "_powder"

    if unilib.technic_update_flag then

        unilib.register_craftitem(full_name, orig_name, replace_mode, {
            description = description,
            inventory_image = "unilib_metal_" .. part_name .. "_powder.png",
        })
        if not no_lump_flag then

            technic.register_grinder_recipe({
                output = "unilib:metal_" .. part_name .. "_powder " ..
                        tostring(unilib.grind_metal_ratio),
                input = {"unilib:metal_" .. part_name .. "_lump"},
                time = lump_time,
            })

        end
        technic.register_grinder_recipe({
            output = "unilib:metal_" .. part_name .. "_powder",
            input = {"unilib:metal_" .. part_name .. "_ingot"},
            time = ingot_time,
        })
        unilib.register_craft({
            type = "cooking",
            output = "unilib:metal_" .. part_name .. "_ingot",
            recipe = "unilib:metal_" .. part_name .. "_powder",
        })

        return full_name

    else

        return nil

    end

end

function unilib.register_metal_powder_from_mineral(data_table)

    -- Original to unilib
    -- Creates a metal powder item created by grinding a mineral lump (e.g. bauxite >
    --      aluminium powder > aluminium ingot)
    -- See also the unilib.register_mineral_powder() function
    --
    -- data_table compulsory fields:
    --      orig_name (str): e.g. "fakemod:aluminium_dust"
    --      metal_part_name (str): e.g. "aluminium", from unilib:metal_aluminium_ingot
    --      mineral_part_name (str or list): e.g. "bauxite", from unilib:mineral_bauxite_lump. Use
    --          a list when several mineral lumps make the same metal powder (as in the
    --          "metal_copper_real" package)
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"
    --      description (str): e.g. "Aluminium Powder"
    --      ingot_time (int): Grinding time for converting ingots into powder, in seconds
    --      lump_time (int): Grinding time for converting lumps into powder, in seconds
    --
    -- Return values:
    --      The full_name of the new craftitem, or nil if technic is not available

    local orig_name = data_table.orig_name
    local metal_part_name = data_table.metal_part_name
    local mineral_part_name = data_table.mineral_part_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local description = data_table.description or S("Metal Powder")
    local ingot_time = data_table.ingot_time or 3
    local lump_time = data_table.lump_time or 3

    local full_name = "unilib:metal_" .. metal_part_name .. "_powder"

    if unilib.technic_update_flag then

        unilib.register_craftitem(full_name, orig_name, replace_mode, {
            description = description,
            inventory_image = "unilib_metal_" .. metal_part_name .. "_powder.png",
        })

        local mineral_part_name_list = unilib.convert_to_list(mineral_part_name)
        for _, this_mineral_part_name in ipairs(mineral_part_name_list) do

            technic.register_grinder_recipe({
                output = full_name .. " " .. tostring(unilib.grind_mineral_ratio),
                input = {"unilib:mineral_" .. this_mineral_part_name .. "_lump"},
                time = lump_time,
            })

        end
        technic.register_grinder_recipe({
            output = "unilib:metal_" .. metal_part_name .. "_powder",
            input = {"unilib:metal_" .. metal_part_name .. "_ingot"},
            time = ingot_time,
        })
        unilib.register_craft({
            type = "cooking",
            output = "unilib:metal_" .. metal_part_name .. "_ingot",
            recipe = "unilib:metal_" .. metal_part_name .. "_powder",
        })

        return full_name

    else

        return nil

    end

end

function unilib.register_metal_molten(data_table)

    -- Adapted from GLEMr11, lib_materials:liquid_metal_copper_source and
    --      lib_materials:liquid_metal_copper_flowing
    -- Creates a molten metal, with source and flowing nodes, that cools into a metal block
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

    local part_name = data_table.part_name
    local source_orig_name = data_table.source_orig_name
    local flowing_orig_name = data_table.flowing_orig_name

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode
    local cooled_name = data_table.cooled_name or "unilib:metal_" .. part_name .. "_block"
    local source_description = data_table.source_description or S("Molten Metal Source")
    local flowing_description = data_table.flowing_description or S("Flowing Molten Metal")
    local source_length = data_table.source_length or 3
    local flowing_length = data_table.flowing_length or 3.3

    local source_name = "unilib:liquid_molten_" .. part_name .. "_source"
    local flowing_name = "unilib:liquid_molten_" .. part_name .. "_flowing"

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
        groups = {igniter = 1, metal = 1, liquid = 3},
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 6,
        diggable = false,
        drawtype = "liquid",
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
    if minetest.registered_nodes[cooled_name] ~= nil then

        unilib.register_lava({
            cooled_name = cooled_name,
            lava_name = source_name
        })

    end

    unilib.register_node(flowing_name, flowing_orig_name, replace_mode, {
        description = flowing_description,
        tiles = {"unilib_liquid_molten_" .. part_name .. "_source.png"},
        groups = {igniter = 1, liquid = 3, metal = 1, not_in_creative_inventory = 1},
        -- (no sounds)

        buildable_to = true,
        damage_per_second = 6,
        diggable = false,
        drawtype = "flowingliquid",
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

function unilib.register_non_metal(data_table)

    -- Original to unilib
    -- Registers the elemental non-metal type in a global variable
    --
    -- data_table compulsory fields:
    --      part_name (str): Elemental non-metals have a consistent naming system. All nodes/items
    --          from the same substance share a common component, e.g. "nitrogen" from
    --          "unilib:substance_nitrogen_sample, etc
    --      description (str): A string used as the basis for the .description field in all
    --          derivative nodes (e.g. "Nitrogen")

    local part_name = data_table.part_name
    local description = data_table.description

    -- Update the global variable
    unilib.non_metal_table[part_name] = {
        part_name = part_name,
        description = description,
    }

end

---------------------------------------------------------------------------------------------------
-- Shared functions - compressed metal blocks
---------------------------------------------------------------------------------------------------

function unilib.set_compressed_metal_recipes(part_name)

    -- Adapted from xtraores
    -- Sets up craft recipes for a compressed metal block, crafted from a metal block of the same
    --      type
    --
    -- Args:
    --      part_name (str): e.g. "unobtainium", used with "unilib:metal_unobtainium_block" and
    --          "unilib:metal_unobtainium_block_compressed"

    local c_block = "unilib:metal_" .. part_name .. "_block"
    local c_compressed = "unilib:metal_" .. part_name .. "_block_compressed"

    if minetest.get_modpath("technic") == nil then

        unilib.register_craft_3x3({
            output = c_compressed,
            ingredient = c_block,
        })
        unilib.register_craft({
            output = c_block .. " 9",
            recipe = {
                {c_compressed},
            },
        })

    else

        technic.register_compressor_recipe({
            input = {c_block .. " 8"},
            output = c_compressed,
            time = 10,
        })
        unilib.register_craft({
            type = "shapeless",
            output = c_block .. " 8",
            recipe = {c_compressed},
        })

    end

end

---------------------------------------------------------------------------------------------------
-- Shared functions - update
---------------------------------------------------------------------------------------------------

function unilib.update_metal(data_table)

    -- Original to unilib
    -- Updates the global variable set in an earlier call to unilib.register_metal()
    --
    -- data_table compulsory fields:
    --      part_name (str): A key in unilib.metal_table, e.g. "tin"
    --
    -- data_table optional fields:
    --      Any of the fields available in the unilib.register_metal() call, except for .part_name

    if data_table.part_name == nil or unilib.metal_table[data_table.part_name] == nil then

        unilib.show_error("unilib.update_metal(): Unrecognised metal type", data_table.part_name)
        return

    end

    for _, field in ipairs({
        "description", "alloy_flag", "fictional_flag", "hardness", "powder_flag",
    }) do
        if data_table[field] ~= nil then
            unilib.metal_table[data_table.part_name][field] = data_table[field]
        end

    end

end

function unilib.update_non_metal(data_table)

    -- Original to unilib
    -- Updates the global variable set in an earlier call to unilib.register_non_metal()
    --
    -- data_table compulsory fields:
    --      part_name (str): A key in unilib.non_metal_table, e.g. "nitrogen"
    --
    -- data_table optional fields:
    --      Any of the fields available in the unilib.register_non_metal() call, except for
    --          .part_name

    if data_table.part_name == nil or unilib.non_metal_table[data_table.part_name] == nil then

        unilib.show_error(
            "unilib.update_non_metal(): Unrecognised elemental non-metal type", data_table.part_name
        )

        return

    end

    for _, field in ipairs({"description"}) do

        if data_table[field] ~= nil then
            unilib.non_metal_table[data_table.part_name][field] = data_table[field]
        end

    end

end
