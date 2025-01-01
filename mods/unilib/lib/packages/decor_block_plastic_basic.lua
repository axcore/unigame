---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plastic_block
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.decor_block_plastic_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plastic_block.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.decor_block_plastic_basic.init()

    return {
        description = "Basic plastic block set (15 colours)",
        notes = "Use this package to recycle unwanted tree leaves, which can be used to craft" ..
                " plastic sheets, which can in turn be used to craft these plastic blocks",
        depends = "material_plastic",
    }

end

function unilib.pkg.decor_block_plastic_basic.exec()

    -- Basic plastic block set (based on the basic 15 dye set)
    local block_list = {
        {"black",       "",             "",         S("Black Plastic Block")},
        {"blue",        "",             "",         S("Blue Plastic Block")},
        {"brown",       "",             "#441c12",  S("Brown Plastic Block")},
        {"cyan",        "",             "",         S("Cyan Plastic Block")},
        {"green",       "",             "#00BB00",  S("Green Plastic Block")},
        {"green_dark",  "dark_green",   "#004400",  S("Dark Green Plastic Block")},
        {"grey",        "",             "",         S("Grey Plastic Block")},
        {"grey_dark",   "dark_grey",    "#222222",  S("Dark Grey Plastic Block")},
        {"magenta",     "",             "",         S("Magenta Plastic Block")},
        {"orange",      "",             "",         S("Orange Plastic Block")},
        {"pink",        "",             "#FF6FFF",  S("Pink Plastic Block")},
        {"red",         "",             "",         S("Red Plastic Block")},
        {"violet",      "",             "#990099",  S("Violet Plastic Block")},
        {"white",       "",             "",         S("White Plastic Block")},
        {"yellow",      "",             "",         S("Yellow Plastic Block")},
    }

    for _, row_list in ipairs(block_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        -- A keyword like "black" or, for some exceptions, an RGB value like "#004400"
        local colour = row_list[3]
        if colour == "" then
            colour = part_name
        end

        local description = row_list[4]

        unilib.register_node(
            -- From plastic_block:black, etc. Creates unilib:decor_block_plastic_black, etc
            "unilib:decor_block_plastic_" .. part_name,
            "plastic_block:" .. orig_name,
            mode,
            {
                description = description,
                tiles = {"unilib_decor_block_plastic.png^[colorize:" .. colour .. ":191"},
                groups = {choppy = 1, oddly_breakable_by_hand = 2, plastic = 1, snappy = 1},
                sounds = {
                    dig = {"unilib_dig_oddly_breakable_by_hand", gain = 0.25},
                    dug = {name = "unilib_dug_node", gain = 0.25},
                    place = {name = "unili_place_node_hard", gain = 1.0},
                    footstep = {name = "unili_hard_footstep", gain = 0.2},
                },

                is_ground_content = false,
            }
        )
        unilib.register_craft({
            -- From plastic_block:black, etc
            type = "shapeless",
            output = "unilib:decor_block_plastic_" .. part_name,
            recipe = {"group:dye,colour_" .. part_name, "group:plastic"},
        })
        unilib.register_stairs("unilib:decor_block_plastic_" .. part_name)

    end

    -- Get a white block from nine sheets
    unilib.register_craft_3x3({
        -- From plastic_block:white
        output = "unilib:decor_block_plastic_white",
        ingredient = "unilib:material_plastic_sheet",
    })

end
