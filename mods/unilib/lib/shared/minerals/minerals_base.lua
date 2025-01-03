---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- mineral_base.lua
--      Base API functions for minerals
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Base API functions for minerals
---------------------------------------------------------------------------------------------------

function unilib.minerals._register_mineral(data_table)

    -- Original to unilib
    -- Registers the mineral type in a global variable
    --
    -- data_table compulsory fields:
    --      part_name (str): Minerals have a consistent naming system. All nodes/items from the
    --          same mineral share a common component, e.g. "cinnabar" from
    --          "unilib:mineral_cinnabar_lump", etc
    --      description (str): A string used as the basis for the .description field in all
    --          derivative nodes (e.g. "Cinnabar")
    --
    -- data_table optional fields:
    --      combustible_flag (bool): If true, can be used as a fuel in a furnace
    --      fictional_flag (bool): If true, this mineral does not exist in reality. This
    --          classification applies in the broadest sense; "unilib:mineral_amethyst_dark_lump" is
    --          not regarded as fictional, because amethyst itself is not fictional
    --      gem_flag (bool): If true, a gem variant exists
    --      hardness (int): Value of the hardness of the mineral ore in the range 1-5, corresponding
    --          to the PFAA classification:
    --              UNILIB  PFAA            CRACKY
    --              1       weak            3
    --              2       medium          2
    --              3       strong          1
    --              4       very strong     1
    --              5       n/a             0
    --          N.B. Currently, no minerals have strength 4 or 5. Strength 5 is intended for
    --              fictional minerals that require special tools
    --      metal_list (list): List of keys in unilib.global.metal_table, specifying the metals that
    --          can be smelted using this mineral (an empty list, if none)
    --      no_lump_flag (bool): If true, no lump variant exists
    --      non_metal_list = List of keys in unilib.global.non_metal_table, specifying elemental
    --          non-metals that can be baked using this mineral (an empty list, if none)
    --      powder_flag (bool): If true, a powder variant exists
    --      rock_flag (bool): If true, a rock-mineral variant exists (a whole node, not a craftitem)

    local part_name = data_table.part_name
    local description = data_table.description

    local combustible_flag = data_table.combustible_flag or false
    local fictional_flag = data_table.fictional_flag or false
    local gem_flag = data_table.gem_flag or false
    local hardness = data_table.hardness or 1
    local metal_list = data_table.metal_list or {}
    local no_lump_flag = data_table.no_lump_flag or false
    local non_metal_list = data_table.non_metal_list or {}
    local powder_flag = data_table.powder_flag or false
    local rock_flag = data_table.rock_flag or false

    -- Update the global variable
    unilib.global.mineral_table[part_name] = {
        part_name = part_name,
        description = description,

        combustible_flag = combustible_flag,
        fictional_flag = fictional_flag,
        gem_flag = gem_flag,
        hardness = hardness,
        metal_list = metal_list,
        no_lump_flag = no_lump_flag,
        non_metal_list = non_metal_list,
        powder_flag = powder_flag,
        rock_flag = rock_flag,
    }

end

function unilib.minerals._register_mineral_rock(part_name)

    -- Original to unilib
    -- Called when two different packages provide the mineral lump and rock variants
    -- This function is called by the package providing the rock variant, and the package providing
    --      the lump variant has called unilib.register_mineral(). (To guarantee this, the rock
    --      package should specify the lump package as a dependency)
    -- Updates the global variable

    if unilib.global.mineral_table[part_name] == nil then

        unilib.utils.show_error(
            "unilib.register_mineral_rock(): Unrecognised mineral. To resolve this error, make" ..
                    " sure that unilib.register_mineral() is called first, for example by " ..
                    " making one package a dependency of another (see the" ..
                    " \"mineral_cinnabar_rock\" package for an example)",
            part_name
        )

    else

        unilib.global.mineral_table[part_name]["rock_flag"] = true

    end

end
