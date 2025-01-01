---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_ornamental_cross = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_ornamental_cross.init()

    return {
        description = "Ornamental glass with cross pattern",
        depends = "glass_artisanal_basic",
    }

end

function unilib.pkg.glass_ornamental_cross.exec()

    local c_clear = "unilib:glass_artisanal_clear"
    local c_glass_red = "unilib:glass_artisanal_dyed_red"
    local c_glass_green = "unilib:glass_artisanal_dyed_green"
    local c_glass_blue = "unilib:glass_artisanal_dyed_blue"

    unilib.register_node(
        -- From abriglass:stainedglass_pattern04
        "unilib:glass_ornamental_tiles_cross",
        "abriglass:stainedglass_pattern04",
        mode,
        {
            description = unilib.utils.brackets(S("Ornamental Glass"), S("Cross Pattern")),
            tiles = {"unilib_glass_ornamental_cross.png"},
            groups = {cracky = 3},
            sounds = unilib.global.sound_table.glass,

            drawtype = "glasslike",
            -- N.B. is_ground_content = false not in original code; added to match other glass items
            is_ground_content = false,
            light_source = 5,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        }
    )
    unilib.register_craft({
        -- From abriglass:stainedglass_pattern04
        output = "unilib:glass_ornamental_tiles_cross 9",
        recipe = {
            {c_glass_green, c_glass_red, c_glass_green},
            {c_glass_red, c_glass_blue, c_glass_red},
            {c_glass_green, c_glass_red, c_glass_green},
        },
    })
    unilib.register_craft({
        -- From abriglass:stainedglass_pattern04
        type = "cooking",
        output = c_clear,
        recipe = "unilib:glass_ornamental_tiles_cross",
    })

end
