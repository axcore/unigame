---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- metals_base.lua
--      Base API functions for metals
---------------------------------------------------------------------------------------------------

local S = unilib.intllib

---------------------------------------------------------------------------------------------------
-- Base API functions for metals
---------------------------------------------------------------------------------------------------

function unilib.metals._register_metal(data_table)

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
    --          classification applies in the broadest sense; "unilib:metal_tin_rare_ingot" is not
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
    unilib.global.metal_table[part_name] = {
        part_name = part_name,
        description = description,

        alloy_flag = alloy_flag,
        fictional_flag = fictional_flag,
        hardness = hardness,
        powder_flag = powder_flag,
    }

end

function unilib.metals._register_non_metal(data_table)

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
    unilib.global.non_metal_table[part_name] = {
        part_name = part_name,
        description = description,
    }

end
