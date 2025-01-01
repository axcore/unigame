---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abripanes
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.pane_glass_artisanal_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.abripanes.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.pane_glass_artisanal_basic.init()

    return {
        description = "Basic artisanal glass pane set (15 colours)",
        depends = {"dye_basic", "glass_ordinary"},
        optional = "clay_ordinary",
    }

end

function unilib.pkg.pane_glass_artisanal_basic.exec()

    local pane_list = {
        {
            "blue",
            S("Artisanal Blue Glass Pane"),
            S("Artisanal Blue Cloudy Glass Pane"),
            "#0000FF",
        },
        {
            "cyan",
            S("Artisanal Cyan Glass Pane"),
            S("Artisanal Cyan Cloudy Glass Pane"),
            "#00FFFF",
        },
        {
            "green",
            S("Artisanal Green Glass Pane"),
            S("Artisanal Green Cloudy Glass Pane"),
            "#00FF00",
        },
        {
            "magenta",
            S("Artisanal Magenta Glass Pane"),
            S("Artisanal Magenta Cloudy Glass Pane"),
            "#FF00FF",
        },
        {
            "orange",
            S("Artisanal Orange Glass Pane"),
            S("Artisanal Orange Cloudy Glass Pane"),
            "#FF6103",
        },
        {
            "violet",
            S("Artisanal Purple Glass Pane"),
            S("Artisanal Purple Cloudy Glass Pane"),
            "#800080",
        },
        {
            "red",
            S("Artisanal Red Glass Pane"),
            S("Artisanal Red Cloudy Glass Pane"),
            "#FF0000",
        },
        {
            "white",
            S("Artisanal Frosted Glass Pane"),
            S("Artisanal Frosted Cloudy Glass Pane"),
            "#FFFFFF",
        },
        {
            "yellow",
            S("Artisanal Yellow Glass Pane"),
            S("Artisanal Yellow Cloudy Glass Pane"),
            "#FFFF00",
        },
        -- Extra colours not included in the original code, to complete the standard 15-dye set
        {
            "black",
            S("Artisanal Darkened Glass Pane"),
            S("Artisanal Darkened Cloudy Glass Pane"),
            "#0C0C0C",
        },
        {
            "brown",
            S("Artisanal Brown Glass Pane"),
            S("Artisanal Brown Cloudy Glass Pane"),
            "#A52A2A",
        },
        {
            "green_dark",
            S("Artisanal Dark Green Glass Pane"),
            S("Artisanal Dark Green Cloudy Glass Pane"),
            "#002600",
        },
        {
            "grey",
            S("Artisanal Grey Glass Pane"),
            S("Artisanal Grey Cloudy Glass Pane"),
            "#808080",
        },
        {
            "grey_dark",
            S("Artisanal Dark Grey Glass Pane"),
            S("Artisanal Dark Grey Cloudy Glass Pane"),
            "#3C3C3C",
        },
        {
            "pink",
            S("Artisanal Pink Glass Pane"),
            S("Artisanal Pink Cloudy Glass Pane"),
            "#FFC0CB",
        },
    }

    for _, row_list in ipairs(pane_list) do

        local part_name = row_list[1]
        local normal_description = row_list[2]
        local cloudy_description = row_list[3]
        local rgb = row_list[4]

        local normal_img = "unilib_pane_glass_artisanal_base.png^[colorize:" .. rgb .. ":alpha"
        local cloudy_img = "unilib_pane_glass_artisanal_base.png^[colorize:" .. rgb .. ":96"

        unilib.register_pane({
            -- From abripanes, xpanes:abriglass_pane_blue_flat etc. Creates
            --      unilib:pane_glass_artisanal_blue_flat, etc
            part_name = "glass_artisanal_" .. part_name,
            orig_name = {
                "xpanes:abriglass_pane" .. part_name,
                "xpanes:abriglass_pane" .. part_name .. "_flat",
            },
            def_table = {
                description = normal_description,
                textures = {normal_img, "", normal_img},
                groups = {cracky = 3},
                sounds = unilib.global.sound_table.glass,

                -- N.B. inventory_image emoved for aesthetic reasons
--              inventory_image = normal_img,
                light_source = 4,
                recipe = {
                    {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
                    {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
                    {"", "unilib:dye_" .. part_name, ""},
                },
                use_texture_alpha = "blend",
                wield_image = normal_img,
            },

            replace_mode = mode,
        })

        if unilib.global.pkg_executed_table["clay_ordinary"] ~= nil then

            unilib.register_pane({
                -- Original to unilib. unilib:pane_glass_artisanal_blue_cloudy_flat, etc
                part_name = "glass_artisanal_" .. part_name .. "_cloudy",
                orig_name = {},

                def_table = {
                    description = cloudy_description,
                    textures = {cloudy_img, "", cloudy_img},
                    groups = {cracky = 3},
                    sounds = unilib.global.sound_table.glass,

                    -- N.B. inventory_image emoved for aesthetic reasons
--                  inventory_image = cloudy_img,
                    light_source = 4,
                    recipe = {
                        {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
                        {"unilib:glass_ordinary", "unilib:glass_ordinary", "unilib:glass_ordinary"},
                        {"", "unilib:dye_" .. part_name, "unilib:clay_ordinary_lump"},
                    },
                    use_texture_alpha = "blend",
                    wield_image = cloudy_img,
                },

                replace_mode = mode,
            })

        end
        unilib.override_item("unilib:pane_glass_artisanal_" .. part_name .. "_cloudy_crossed", {
            light_source = 4,
        })
        unilib.override_item("unilib:pane_glass_artisanal_" .. part_name .. "_cloudy_flat", {
            light_source = 4,
        })

    end

end
