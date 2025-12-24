---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    colored-meselamps
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.light_block_mese_tinted = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["colored-meselamps"].add_mode

-- Flag set to true to register 4 bonus lamps, false to register only lamps crafted from the basic
--      dye set
local craft_all_flag = true

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_bonus_craft(part_name, colour_1, colour_2)

    unilib.register_craft{
        type = "shapeless",
        output = "unilib:light_block_mese_tinted_" .. part_name,
        recipe = {"unilib:dye_" .. colour_1, "unilib:dye_" .. colour_2, "unilib:light_block_mese"},
    }

    unilib.register_craft{
        type = "shapeless",
        output = "unilib:light_block_mese_tinted_" .. part_name,
        recipe = {"unilib:dye_" .. colour_1, "unilib:dye_" .. colour_2, "group:coloured_meselamps"},
    }

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.light_block_mese_tinted.init()

    return {
        description = "Tinted mese lamps",
        depends = {"dye_basic", "light_block_mese"},
    }

end

function unilib.pkg.light_block_mese_tinted.exec()

    -- Basic lamp set (based on the basic 15 dye set)
    local lamp_list = {
        {"black",       "",             S("Black Tinted Mese Lamp"),       true,  "#000", 0.2},
        {"blue",        "",             S("Blue Tinted Mese Lamp"),        true,  "#44f", 1},
        {"brown",       "",             S("Brown Tinted Mese Lamp"),       true,  "#882", 0.5},
        {"cyan",        "",             S("Cyan Tinted Mese Lamp"),        true,  "#4ff", 1},
        {"green",       "",             S("Green Tinted Mese Lamp"),       true,  "#4f4", 1},
        {"green_dark",  "dark_green",   S("Dark Green Tinted Mese Lamp"),  true,  "#1a1", 0.6},
        {"grey",        "",             S("Grey Tinted Mese Lamp"),        true,  "#aaa", 0.7},
        {"grey_dark",   "dark_grey",    S("Dark Grey Tinted Mese Lamp"),   true,  "#444", 0.5},
        {"magenta",     "",             S("Magenta Tinted Mese Lamp"),     true,  "#f4f", 1},
        {"orange",      "",             S("Orange Tinted Mese Lamp"),      true,  "#fa4", 1},
        {"pink",        "",             S("Pink Tinted Mese Lamp"),        true,  "#f48", 1},
        {"red",         "",             S("Red Tinted Mese Lamp"),         true,  "#f44", 1},
        {"violet",      "",             S("Violet Tinted Mese Lamp"),      true,  "#a4f", 1},
        {"white",       "",             S("White Tinted Mese Lamp"),       true,  "#fff", 1},
        {"yellow",      "",             S("Yellow Tinted Mese Lamp"),      true,  "#ff4", 1},
    }

    if craft_all_flag then

        table.insert(
            lamp_list,
            {"blue_dark",   "dark_blue",    S("Dark Blue Tinted Mese Lamp"),   false, "#11a", 0.6}
        )
        table.insert(
            lamp_list,
            {"red_dark",    "dark_red",     S("Dark Red Tinted Mese Lamp"),    false, "#a11", 0.6}
        )
        table.insert(
            lamp_list,
            {"lime",        "lime",         S("Lime Tinted Mese Lamp"),        false, "#8f4", 1}
        )
        table.insert(
            lamp_list,
            {"turquoise",   "turquoise",    S("Turquoise Tinted Mese Lamp"),   false, "#4f8", 1}
        )

    end

    for _, row_list in ipairs(lamp_list) do

        local part_name = row_list[1]

        local orig_name = row_list[2]
        if orig_name == "" then
            orig_name = part_name
        end

        local description = row_list[3]
        local standard_craft_flag = row_list[4]
        local colour = row_list[5]
        local light = row_list[6] * math.ceil(unilib.constant.light_max)

        local full_name = "unilib:light_block_mese_tinted_" .. part_name

        unilib.register_node(full_name, "colored_meselamps:" .. orig_name .. "_meselamp", mode, {
            description = description,
            tiles = {
                "unilib_light_block_mese_tinted_colour.png^[colorize:" .. colour ..
                        "^unilib_light_block_mese_tinted_overlay.png",
            },
            -- N.B. colored_meselamps = 1 original code
            groups = {cracky = 3, oddly_breakable_by_hand = 3, coloured_meselamps = 1},
            sounds = unilib.global.sound_table.glass,

            -- N.B. No .drawtype in original code; added to match the node in the "light_block_mese"
            --      package
            drawtype = "glasslike",
            is_ground_content = false,
            light_source = light,
            paramtype = "light",
            sunlight_propagates = true,
        })
        -- N.B. Omitted stairs from original code, as the "light_block_mese" package doesn't provide
        --      them

        if standard_craft_flag then

            unilib.register_craft{
                type = "shapeless",
                output = full_name,
                recipe = {"unilib:dye_" .. part_name, "unilib:light_block_mese"},
            }

            unilib.register_craft{
                type = "shapeless",
                output = full_name,
                recipe = {"unilib:dye_" .. part_name, "group:coloured_meselamps"},
            }

        end

    end

    if craft_all_flag then

        register_bonus_craft("blue_dark", "black", "blue")
        register_bonus_craft("red_dark", "black", "red")
        register_bonus_craft("lime", "yellow", "green")
        register_bonus_craft("turquoise", "green", "cyan")

    end

end
