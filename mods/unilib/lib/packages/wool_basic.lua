---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wool
-- Code:    MIT
-- Media:   CC BY-SA 3.0
--
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.wool_basic = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.wool.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.wool_basic.init()

    return {
        description = "Basic wool set (based on the basic 15 dye set)",
        depends = {"crop_cotton", "dye_basic"},
    }

end

function unilib.pkg.wool_basic.exec()

    -- Basic wool set (based on the basic 15 dye set)
    local wool_list = {
        {"black",       "",             S("Black Wool")},
        {"blue",        "",             S("Blue Wool")},
        {"brown",       "",             S("Brown Wool")},
        {"cyan",        "",             S("Cyan Wool")},
        {"green",       "",             S("Green Wool")},
        {"green_dark",  "dark_green",   S("Dark Green Wool")},
        {"grey",        "",             S("Grey Wool")},
        {"grey_dark",   "dark_grey",    S("Dark Grey Wool")},
        {"magenta",     "",             S("Magenta Wool")},
        {"orange",      "",             S("Orange Wool")},
        {"pink",        "",             S("Pink Wool")},
        {"red",         "",             S("Red Wool")},
        {"violet",      "",             S("Violet Wool")},
        {"white",       "",             S("White Wool")},
        {"yellow",      "",             S("Yellow Wool")},
    }

    for _, row_list in ipairs(wool_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local description = row_list[3]

        unilib.register_wool({
            -- From wool:black, etc. Creates unilib:wool_black, etc
            part_name = part_name,
            orig_name = "wool:" .. orig_name,

            replace_mode = mode,
            description = description,
        })

    end

    -- Craft recipe for white wool (from which all other wools can be crafted)
    unilib.register_craft_2x2({
        -- From wool:white
        output = "unilib:wool_white",
        ingredient = "unilib:crop_cotton_harvest",
    })

end
