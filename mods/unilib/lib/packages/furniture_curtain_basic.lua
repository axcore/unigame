---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.furniture_curtain_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.xdecor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.furniture_curtain_basic.init()

    return {
        description = "Basic curtain set (based on the basic 15 dye set)",
        notes = "Open or close the curtains by right-clicking them",
        depends = "wool_basic",
    }

end

function unilib.pkg.furniture_curtain_basic.exec()

    -- Basic curtain set (based on the basic 15 dye set)
    -- N.B. The original xdecor code only provided red curtains as standard
    local curtain_list = {
        {"black",       "",             S("Black Curtain")},
        {"blue",        "",             S("Blue Curtain")},
        {"brown",       "",             S("Brown Curtain")},
        {"cyan",        "",             S("Cyan Curtain")},
        {"green",       "",             S("Green Curtain")},
        {"green_dark",  "dark_green",   S("Dark Green Curtain")},
        {"grey",        "",             S("Grey Curtain")},
        {"grey_dark",   "dark_grey",    S("Dark Grey Curtain")},
        {"magenta",     "",             S("Magenta Curtain")},
        {"orange",      "",             S("Orange Curtain")},
        {"pink",        "",             S("Pink Curtain")},
        {"red",         "",             S("Red Curtain")},
        {"violet",      "",             S("Violet Curtain")},
        {"white",       "",             S("White Curtain")},
        {"yellow",      "",             S("Yellow Curtain")},
    }

    for _, row_list in ipairs(curtain_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local description = row_list[3]

        local img = "unilib_wool_" .. part_name .. ".png"
        local ingredient = "unilib:wool_" .. part_name

        unilib.register_node(
            -- From xdecor:curtain_red. Creates unilib:furniture_curtain_red, etc
            "unilib:furniture_curtain_" .. part_name,
            "xdecor:curtain_" .. orig_name,
            mode,
            {
                description = description,
                tiles = {img},
                groups = {dig_immediate = 3, flammable = 3},
                sounds = unilib.global.sound_table.node,

                drawtype = "signlike",
                -- N.B. Replaced the original overlay texture with an all-black one, as the original
                --      didn't work with pink curtains
--              inventory_image = img .. "^unilib_furniture_curtain_overlay.png" ..
--                      "^[makealpha:255,126,126",
                inventory_image = img .. "^unilib_furniture_curtain_overlay.png" ..
                        "^[makealpha:0,0,0",
                -- N.B. is_ground_content = false not in original code; added to match other
                --      furniture
                is_ground_content = false,
                paramtype = "light",
                paramtype2 = "colorwallmounted",
                selection_box = {type = "wallmounted"},
                sunlight_propagates = true,
                walkable = false,
                wield_image = img,

                on_rightclick = function(pos, node, _, itemstack)

                    core.set_node(
                        pos,
                        {
                            name = "unilib:furniture_curtain_" .. part_name .. "_open",
                            param2 = node.param2
                        }
                    )

                    return itemstack

                end,
            }
        )
        unilib.register_craft({
            -- From xdecor:curtain_red
            output = "unilib:furniture_curtain_" .. part_name .. " 4",
            recipe = {
                {"", ingredient, ""},
                {"", ingredient, ""},
            },
        })

        unilib.register_node(
            -- From xdecor:curtain_open_red. Creates unilib:furniture_curtain_red_open, etc
            "unilib:furniture_curtain_" .. part_name .. "_open",
            "xdecor:curtain_open_" .. orig_name,
            mode,
            {
                -- (no description)
                description = description,
--              tiles = {img .. "^unilib_furniture_curtain_overlay.png^[makealpha:255,126,126"},
                tiles = {img .. "^unilib_furniture_curtain_overlay.png^[makealpha:0,0,0"},
                groups = {dig_immediate = 3, flammable = 3, not_in_creative_inventory = 1},
                sounds = unilib.global.sound_table.node,

                drawtype = "signlike",
                drop = "unilib:furniture_curtain_" .. part_name,
                -- N.B. is_ground_content = false not in original code; added to match other
                --      furniture
                is_ground_content = false,
                paramtype = "light",
                paramtype2 = "colorwallmounted",
                selection_box = {type = "wallmounted"},
                sunlight_propagates = true,
                walkable = false,

                on_rightclick = function(pos, node, _, itemstack)

                    core.set_node(
                        pos,
                        {name = "unilib:furniture_curtain_" .. part_name, param2 = node.param2}
                    )

                    return itemstack

                end
            }
        )

    end

end
