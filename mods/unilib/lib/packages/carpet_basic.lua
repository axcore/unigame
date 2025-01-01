---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    carpet
-- Code:    LGPL-2.1+
-- Media:   n/a
---------------------------------------------------------------------------------------------------

unilib.pkg.carpet_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.carpet.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.carpet_basic.init()

    return {
        description = "Basic carpet set (based on the basic 15 dye set)",
        depends = {"shared_carpet", "wool_basic"},
    }

end

function unilib.pkg.carpet_basic.exec()

    -- Basic carpet set (based on the basic 15 dye set)
    local carpet_list = {
        {"black",       "",             S("Black Carpet")},
        {"blue",        "",             S("Blue Carpet")},
        {"brown",       "",             S("Brown Carpet")},
        {"cyan",        "",             S("Cyan Carpet")},
        {"green",       "",             S("Green Carpet")},
        {"green_dark",  "dark_green",   S("Dark Green Carpet")},
        {"grey",        "",             S("Grey Carpet")},
        {"grey_dark",   "dark_grey",    S("Dark Grey Carpet")},
        {"magenta",     "",             S("Magenta Carpet")},
        {"orange",      "",             S("Orange Carpet")},
        {"pink",        "",             S("Pink Carpet")},
        {"red",         "",             S("Red Carpet")},
        {"violet",      "",             S("Violet Carpet")},
        {"white",       "",             S("White Carpet")},
        {"yellow",      "",             S("Yellow Carpet")},
    }

    for _, row_list in ipairs(carpet_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local description = row_list[3]

        unilib.pkg.shared_carpet.register_carpet({
            -- From carpet:wool_black, etc. Creates unilib:carpet_black, etc
            part_name = part_name,
            orig_name = "carpet:wool_" .. orig_name,

            replace_mode = mode,
            description = description,
        })

    end

end
