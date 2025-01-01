---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    offend_flags
-- Code:    LGPL-3.0
-- Media:   CC BY-SA 3.0
--
-- From:    roads/labels
-- Code:    CC-BY-SA-3.0
-- Media:   CC-BY-SA-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.item_cartridge_ink_extra = {}

local S = unilib.intllib
local o_mode = unilib.global.imported_mod_table.offend_flags.add_mode
local l_mode = unilib.global.imported_mod_table.labels.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.item_cartridge_ink_extra.init()

    return {
        description = "Ink cartridges",
        notes = "Basic ink cartridge set (15 colours)",
        depends = "shared_cartridges",
    }

end

function unilib.pkg.item_cartridge_ink_extra.exec()

    -- Reduced cartridge set
    local cartridge_list = {
        {"black",       nil,                                S("Black Ink Cartridge"),       nil},
        {"blue",        "offend_flags:cartridge_blue",      S("Blue Ink Cartridge"),        o_mode},
        {"brown",       nil,                                S("Brown Ink Cartridge"),       nil},
        {"cyan",        nil,                                S("Cyan Ink Cartridge"),        nil},
        {"green",       "offend_flags:cartridge_green",     S("Green Ink Cartridge"),       o_mode},
        {"green_dark",  nil,                                S("Dark Green Ink Cartridge"),  nil},
        {"grey",        nil,                                S("Grey Ink Cartridge"),        nil},
        {"grey_dark",   nil,                                S("Dark Grey Ink Cartridge"),   nil},
        {"magenta",     nil,                                S("Magenta Ink Cartridge"),     nil},
        {"orange",      nil,                                S("Orange Ink Cartridge"),      nil},
        {"pink",        nil,                                S("Pink Ink Cartridge"),        nil},
        {"red",         "offend_flags:cartridge_red",       S("Red Ink Cartridge"),         o_mode},
        {"violet",      nil,                                S("Violet Ink Cartridge"),      nil},
        {"white",       "streets:whitecartridge",           S("White Ink Cartridge"),       l_mode},
        {"yellow",      "streets:yellowcartridge",          S("Yellow Ink Cartridge"),      l_mode},
    }

    for _, row_list in ipairs(cartridge_list) do

        unilib.pkg.shared_cartridges.register_cartridge({
            -- Creates unilib:item_cartridge_ink_black, etc
            part_name = row_list[1],
            orig_name = row_list[2],
            description = row_list[3],

            replace_mode = row_list[4],
        })

    end

end
