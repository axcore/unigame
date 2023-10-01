---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_tinted = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_tinted.init()

    return {
        description = "Tinted glass pane",
        depends = "glass_tinted",
    }

end

function unilib.pkg.pane_glass_tinted.exec()

    -- Basic tinted glass pane set (based on the basic 15 dye set)
    local pane_list = {
        {"black",       "",             S("Black Tinted Glass Pane")},
        {"blue",        "",             S("Blue Tinted Glass Pane")},
        {"brown",       "",             S("Brown Tinted Glass Pane")},
        {"cyan",        "",             S("Cyan Tinted Glass Pane")},
        {"green",       "",             S("Green Tinted Glass Pane")},
        {"green_dark",  "dark_green",   S("Dark Green Tinted Glass Pane")},
        {"grey",        "",             S("Grey Tinted Glass Pane")},
        {"grey_dark",   "dark_grey",    S("Dark Grey Tinted Glass Pane")},
        {"magenta",     "",             S("Magenta Tinted Glass Pane")},
        {"orange",      "",             S("Orange Tinted Glass Pane")},
        {"pink",        "",             S("Pink Tinted Glass Pane")},
        {"red",         "",             S("Red Tinted Glass Pane")},
        {"violet",      "",             S("Violet Tinted Glass Pane")},
        {"white",       "",             S("White Tinted Glass Pane")},
        {"yellow",      "",             S("Yellow Tinted Glass Pane")},
    }

    for _, row_list in ipairs(pane_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local description = row_list[3]

        local img = "unilib_glass_tinted_" .. part_name .. ".png"
        local ingredient = "unilib:glass_tinted_" .. part_name

        unilib.register_pane({
            -- From farlands, xpanes:black_glass_flat. Creates unilib:pane_glass_tinted_black_flat,
            --      unilib:pane_glass_tinted_black_crossed  etc
            part_name = "glass_tinted_" .. part_name,
            orig_name = {
                "xpanes:" .. orig_name .. "_glass",
                "xpanes:" .. orig_name .. "_glass_flat",
            },
            def_table = {
                description = description,
                textures = {img, img, img},
                groups = {cracky = 3, oddly_breakable_by_hand = 3, snappy = 2},
                sounds = unilib.sound_table.glass,

                inventory_image = img,
                recipe = {
                    {ingredient, ingredient, ingredient},
                    {ingredient, ingredient, ingredient},
                },
                use_texture_alpha = "blend",
                wield_image = img,
            },
        })

    end

end
