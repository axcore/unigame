---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_artisanal_basic = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Other packages originating in abriglass use this table in their craft recipes
-- Keys are the ten dye types listed below (e.g. "black"), values are one of the corresponding
--      variants of "unilib:glass_artisanal_dyed"
unilib.pkg.glass_artisanal_basic.craft_table = {}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_artisanal_basic.init()

    return {
        description = "Basic artisanal glass sets (15 colours with variants)",
        notes = "Dyed, cloudy and framed artisanal glass can be crafted from the clear artisanal" ..
                " glass node",
        depends = {"dye_basic", "glass_artisanal_clear"},
        optional = {"clay_ordinary", "torch_ordinary"},
    }

end

function unilib.pkg.glass_artisanal_basic.exec()

    local c_clear = "unilib:glass_artisanal_clear"

    -- N.B. In original code, a single Minetest node represented glass in ten different colours.
    --      Here, for compatibility with other dye sets, we use separate nodes
    local glass_list = {
        {
            "black",
            S("Darkened Dyed Artisanal Glass"),
            S("Black Cloudy Artisanal Glass"),
            S("Darkened Framed Artisanal Glass"),
            "#292421",
        },
        {
            "blue",
            S("Blue Dyed Artisanal Glass"),
            S("Blue Cloudy Artisanal Glass"),
            S("Blue Framed Artisanal Glass"),
            "#0000FF",
        },
        {
            "cyan",
            S("Cyan Dyed Artisanal Glass"),
            S("Cyan Cloudy Artisanal Glass"),
            S("Cyan Framed Artisanal Glass"),
            "#00FFFF",
        },
        {
            "green",
            S("Green Dyed Artisanal Glass"),
            S("Green Cloudy Artisanal Glass"),
            S("Green Framed Artisanal Glass"),
            "#00FF00",
        },
        {
            "magenta",
            S("Magenta Dyed Artisanal Glass"),
            S("Magenta Cloudy Artisanal Glass"),
            S("Magenta Framed Artisanal Glass"),
            "#FF00FF",
        },
        {
            "orange",
            S("Orange Dyed Artisanal Glass"),
            S("Orange Cloudy Artisanal Glass"),
            S("Orange Framed Artisanal Glass"),
            "#FF6103",
        },
        {
            "red",
            S("Red Dyed Artisanal Glass"),
            S("Red Cloudy Artisanal Glass"),
            S("Red Framed Artisanal Glass"),
            "#FF0000",
        },
        {
            "violet",
            S("Violet Dyed Artisanal Glass"),
            S("Violet Cloudy Artisanal Glass"),
            S("Violet Framed Artisanal Glass"),
            "#800080",
        },
        {
            "white",
            S("Frosted Dyed Artisanal Glass"),
            S("White Cloudy Artisanal Glass"),
            S("Frosted Framed Artisanal Glass"),
            "#FFFFFF",
        },
        {
            "yellow",
            S("Yellow Dyed Artisanal Glass"),
            S("Yellow Cloudy Artisanal Glass"),
            S("Yellow Framed Artisanal Glass"),
            "#FFFF00",
        },
        -- Extra colours not included in the original code, to complete the standard 15-dye set
        {
            "brown",
            S("Brown Dyed Artisanal Glass"),
            S("Brown Cloudy Artisanal Glass"),
            S("Brown Framed Artisanal Glass"),
            "#A52A2A",
        },
        {
            "green_dark",
            S("Dark Green Dyed Artisanal Glass"),
            S("Dark Green Cloudy Artisanal Glass"),
            S("Dark Green Framed Artisanal Glass"),
            "#002600",
        },
        {
            "grey",
            S("Grey Dyed Artisanal Glass"),
            S("Grey Cloudy Artisanal Glass"),
            S("Grey Framed Artisanal Glass"),
            "#808080",
        },
        {
            "grey_dark",
            S("Dark Grey Dyed Artisanal Glass"),
            S("Dark Grey Cloudy Artisanal Glass"),
            S("Dark Grey Framed Artisanal Glass"),
            "#3C3C3C",
        },
        {
            "pink",
            S("Pink Dyed Artisanal Glass"),
            S("Pink Cloudy Artisanal Glass"),
            S("Pink Framed Artisanal Glass"),
            "#FFC0CB",
        },
    }

    for _, row_list in ipairs(glass_list) do

        local part_name = row_list[1]
        local dyed_description = row_list[2]
        local cloudy_description = row_list[3]
        local framed_description = row_list[4]
        local rgb = row_list[5]

        local dyed_name = "unilib:glass_artisanal_dyed_" .. part_name
        local cloudy_name = "unilib:glass_artisanal_cloudy_" .. part_name
        local framed_name = "unilib:glass_artisanal_framed_" .. part_name

        local dyed_img = "unilib_glass_artisanal_base.png^[colorize:" .. rgb .. ":alpha"
        local cloudy_img = "unilib_glass_artisanal_base.png^[colorize:" .. rgb .. ":96"

        unilib.register_node(dyed_name, nil, mode, {
            -- From abriglass:stained_glass_hardware
            description = dyed_description,
            tiles = {dyed_img},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.glass,

            drawtype = "glasslike",
            -- N.B. is_ground_content = false not in original code; added to match other glass items
            is_ground_content = false,
            light_source = 4,
            paramtype = "light",
            paramtype2 = "color",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        })
        unilib.register_craft({
            -- From abriglass:stained_glass_hardware
            output = dyed_name,
            recipe = {
                {c_clear, "", c_clear},
                {c_clear, "unilib:dye_" .. part_name, c_clear},
                {c_clear, "", c_clear},
            },
        })
        unilib.register_craft({
            -- From abriglass:stained_glass_hardware
            type = "cooking",
            output = c_clear,
            recipe = dyed_name
        })

        if unilib.global.pkg_executed_table["clay_ordinary"] ~= nil then

            unilib.register_node(cloudy_name, nil, mode, {
                -- Original to unilib
                description = cloudy_description,
                tiles = {cloudy_img},
                groups = {cracky = 3},
                sounds = unilib.global.sound_table.glass,

                drawtype = "glasslike",
                -- N.B. is_ground_content = false not in original code; added to match other glass
                --      items
                is_ground_content = false,
                light_source = 4,
                paramtype = "light",
                paramtype2 = "color",
                sunlight_propagates = true,
                use_texture_alpha = "blend",
            })
            unilib.register_craft({
                -- Original to unilib
                output = cloudy_name,
                recipe = {
                    {c_clear, "unilib:clay_ordinary_lump", c_clear},
                    {c_clear, "unilib:dye_" .. row_list[1], c_clear},
                },
            })
            unilib.register_craft({
                -- Original to unilib
                type = "cooking",
                output = c_clear,
                recipe = cloudy_name,
            })

        end

        if unilib.global.pkg_executed_table["torch_ordinary"] ~= nil then

            unilib.register_node(framed_name, nil, mode, {
                -- From abriglass:glass_light_hardware
                description = framed_description,
                tiles = {dyed_img},
                groups = {cracky = 3},
                sounds = unilib.global.sound_table.glass,

                drawtype = "glasslike",
                -- N.B. is_ground_content = false not in original code; added to match other glass
                --      items
                is_ground_content = false,
                -- N.B. light_source not in original code; added for compatibility with other
                --      abriglass nodes
                light_source = 4,
                overlay_tiles = {
                    {name = "unilib_glass_artisanal_clear.png", color = "white"},
                },
                paramtype = "light",
                paramtype2 = "color",
                sunlight_propagates = true,
                use_texture_alpha = "blend",
            })
            unilib.register_craft({
                -- From abriglass:glass_light_hardware
                output = framed_name,
                recipe = {
                    {c_clear, "unilib:torch_ordinary", c_clear},
                    {c_clear, "unilib:dye_" .. row_list[1], c_clear},
                },
            })
            unilib.register_craft({
                -- From abriglass:glass_light_hardware
                type = "cooking",
                output = c_clear,
                recipe = framed_name,
            })

        end

    end

end
