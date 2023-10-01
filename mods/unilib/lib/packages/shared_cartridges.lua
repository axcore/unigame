---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    offend_flags
-- Code:    LGPL-3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_cartridges = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.offend_flags.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cartridges.register_cartridge(data_table)

    -- Adapted from offend_flags:cartridge_red, etc
    -- Creates an ink cartridge, some of which can be used in the flag-printing machine
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "red", one of the colours in the basic 15-dye set
    --      orig_name (str): e.g. "offend_flags:cartridge_red"
    --      description (str): e.g. "Red Ink Cartridge"
    --
    -- data_table optional fields:
    --      replace_mode (str): e.g. "defer"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local description = data_table.description

    local replace_mode = data_table.replace_mode or unilib.default_replace_mode

    local c_cartridge = "unilib:item_cartridge_ink_" .. part_name
    local c_dye = "unilib:dye_" .. part_name
    local c_paper = "unilib:item_paper_ordinary"

    -- Don't create duplicates
    if minetest.registered_tools[c_cartridge] == nil then

        unilib.register_tool(c_cartridge, orig_name, replace_mode, {
            description = description,
            inventory_image = "unilib_item_cartridge_ink_" .. part_name .. ".png",
        })
        unilib.register_craft({
            output = c_cartridge,
            recipe = {
                {c_paper, c_paper, c_paper},
                {c_paper, c_dye, c_paper},
                {c_paper, "", ""},
            },
        })
        -- Craft recipe to refill cartridges
        unilib.register_craft({
            type = "shapeless",
            output = c_cartridge,
            recipe = {c_cartridge, c_dye},
        })
        unilib.register_tool_no_repair(
            c_cartridge, S("This cartridge can't be repaired, but you can refill it with dye")
        )

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_cartridges.init()

    return {
        description = "Shared functions for ink cartridges (from offend_flags)",
        notes = "Intended for the flag printer in the \"machine_printer_flag\" package, but" ..
                " available for any other code that wants it. Empty cartridges can be refilled",
        depends = {"dye_basic", "item_paper_ordinary"},
    }

end
