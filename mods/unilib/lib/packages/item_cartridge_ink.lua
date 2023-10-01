---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    offend_flags
-- Code:    LGPL-3.0
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_cartridge_ink = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.offend_flags.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_cartridge_ink.init()

    return {
        description = "Ink cartridges",
        notes = "Intended for the flag printer in the \"machine_printer_flag\" package. For a" ..
                " full set of 15 ink cartridges, use the \"item_cartridge_ink_extra\" package",
        depends = "shared_cartridges",
    }

end

function unilib.pkg.item_cartridge_ink.exec()

    -- Reduced cartridge set
    local cartridge_list = {
        {"blue",        "offend_flags:cartridge_blue",      S("Blue Ink Cartridge")},
        {"green",       "offend_flags:cartridge_green",     S("Green Ink Cartridge")},
        {"red",         "offend_flags:cartridge_red",       S("Red Ink Cartridge")},
    }

    for _, row_list in ipairs(cartridge_list) do

        unilib.pkg.shared_cartridges.register_cartridge({
            -- Creates unilib:item_cartridge_ink_blue, etc
            part_name = row_list[1],
            orig_name = row_list[2],
            description = row_list[3],

            replace_mode = mode,
        })

    end

end
