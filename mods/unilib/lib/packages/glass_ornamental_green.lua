---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_ornamental_green = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_ornamental_green.init()

    return {
        description = "Green ornamental glass",
        depends = "glass_artisanal_basic",
    }

end

function unilib.pkg.glass_ornamental_green.exec()

    local c_clear = "unilib:glass_artisanal_clear"
    local c_glass_green = "unilib:glass_artisanal_dyed_green"
    local c_glass_blue = "unilib:glass_artisanal_dyed_blue"

    unilib.register_node(
        -- From abriglass:stainedglass_pattern05
        "unilib:glass_ornamental_green",
        "abriglass:stainedglass_pattern05",
        mode,
        {
            description = unilib.brackets(S("Ornamental Glass"), S("Green")),
            tiles = {"unilib_glass_ornamental_green.png"},
            groups = {cracky = 3},
            sounds = unilib.sound_table.glass,

            drawtype = "glasslike",
            light_source = 5,
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            use_texture_alpha = "blend",
        }
    )
    unilib.register_craft({
        -- From abriglass:stainedglass_pattern05
        output = "unilib:glass_ornamental_green 9",
        recipe = {
            {c_glass_blue, c_glass_blue, c_glass_blue},
            {c_glass_blue, c_glass_green, c_glass_blue},
            {c_glass_blue, c_glass_blue, c_glass_blue},
        },
    })
    unilib.register_craft({
        -- From abriglass:stainedglass_pattern05
        type = "cooking",
        output = c_clear,
        recipe = "unilib:glass_ornamental_green",
    })

end
