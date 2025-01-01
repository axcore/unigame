---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.candle_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.candle_basic.init()

    return {
        description = "Basic candle set (15 colours)",
        depends = {
            "dye_basic",
            "item_string_ordinary",
            "material_wax_palm",
            "shared_ethereal_candle",
        },
    }

end

function unilib.pkg.candle_basic.exec()

    -- Basic candle set
    local candle_list = {
        {"black",       "",             S("Black Candle")},
        {"blue",        "",             S("Blue Candle")},
        {"brown",       "",             S("Brown Candle")},
        {"cyan",        "",             S("Cyan Candle")},
        {"green",       "",             S("Green Candle")},
        {"green_dark",  "dark_green",   S("Dark Green Candle")},
        {"grey",        "",             S("Grey Candle")},
        {"grey_dark",   "dark_grey",    S("Dark Grey Candle")},
        {"magenta",     "",             S("Magenta Candle")},
        {"orange",      "",             S("Orange Candle")},
        {"pink",        "",             S("Pink Candle")},
        {"red",         "",             S("Red Candle")},
        {"violet",      "",             S("Violet Candle")},
        {"white",       "",             S("White Candle")},
        {"yellow",      "",             S("Yellow Candle")},
    }

    for _, row_list in ipairs(candle_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if part_name == "white" then
            orig_name = "candle"
        elseif orig_name == "" then
            orig_name = "candle_" .. part_name
        end

        local description = row_list[3]

        unilib.pkg.shared_ethereal_candle.register_candle({
            -- From ethereal:candle_black, etc. Creates unilib:candle_black, etc
            part_name = part_name,
            orig_name = "ethereal:" .. orig_name,

            replace_mode = mode,
            description = description,
        })

    end

    -- Basic candle recipe
    unilib.register_craft({
        -- From ethereal:candle_white
        output = "unilib:candle_white 2",
        recipe = {
            {"unilib:item_string_ordinary"},
            {"unilib:material_wax_palm"},
            {"unilib:material_wax_palm"},
        },
    })

end
