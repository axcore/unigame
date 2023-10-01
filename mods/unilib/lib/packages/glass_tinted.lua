---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_tinted = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_tinted.init()

    return {
        description = "Tinted glass set (based on the basic 15 dye set)",
        depends = {"dye_basic", "glass_ordinary"},
    }

end

function unilib.pkg.glass_tinted.exec()

    -- Basic tinted glass set (based on the basic 15 dye set)
    local glass_list = {
        {"black",       "",             S("Black Tinted Glass")},
        {"blue",        "",             S("Blue Tinted Glass")},
        {"brown",       "",             S("Brown Tinted Glass")},
        {"cyan",        "",             S("Cyan Tinted Glass")},
        {"green",       "",             S("Green Tinted Glass")},
        {"green_dark",  "dark_green",   S("Dark Green Tinted Glass")},
        {"grey",        "",             S("Grey Tinted Glass")},
        {"grey_dark",   "dark_grey",    S("Dark Grey Tinted Glass")},
        {"magenta",     "",             S("Magenta Tinted Glass")},
        {"orange",      "",             S("Orange Tinted Glass")},
        {"pink",        "",             S("Pink Tinted Glass")},
        {"red",         "",             S("Red Tinted Glass")},
        {"violet",      "",             S("Violet Tinted Glass")},
        {"white",       "",             S("White Tinted Glass")},
        {"yellow",      "",             S("Yellow Tinted Glass")},
    }

    for _, row_list in ipairs(glass_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local description = row_list[3]

        unilib.register_node(
            -- From farlands, decoblocks:black_glass, etc. Creates unilib:glass_tinted_black, etc
            "unilib:glass_tinted_" .. part_name,
            "decoblocks:" .. orig_name .. "_glass",
            mode,
            {
                description = description,
                tiles = {"unilib_glass_tinted_" .. part_name .. ".png"},
                groups = {cracky = 1, oddly_breakable_by_hand = 3, snappy = 2},
                sounds = unilib.sound_table.glass,

                drawtype = "glasslike",
                use_texture_alpha = "blend",
            }
        )
        unilib.register_craft({
            type = "shapeless",
            output = "unilib:glass_tinted_" .. part_name .. " 8",
            recipe = {
                "unilib:glass_ordinary",
                "unilib:glass_ordinary",
                "unilib:glass_ordinary",
                "unilib:glass_ordinary",
                "unilib:dye_" .. part_name,
                "unilib:glass_ordinary",
                "unilib:glass_ordinary",
                "unilib:glass_ordinary",
                "unilib:glass_ordinary",
            }
        })

    end

end
