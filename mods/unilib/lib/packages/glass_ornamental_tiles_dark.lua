---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_ornamental_tiles_dark = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_ornamental_tiles_dark.init()

    return {
        description = "Ornamental glass with dark tiles",
        depends = {"glass_artisanal_basic", "glass_artisanal_clear"},
    }

end

function unilib.pkg.glass_ornamental_tiles_dark.exec()

    local c_clear = "unilib:glass_artisanal_clear"
    local c_glass_red = "unilib:glass_artisanal_dyed_red"
    local c_glass_green = "unilib:glass_artisanal_dyed_green"
    local c_glass_blue = "unilib:glass_artisanal_dyed_blue"
    local c_glass_yellow = "unilib:glass_artisanal_dyed_yellow"
    local c_glass_magenta = "unilib:glass_artisanal_dyed_magenta"
    local c_glass_cyan = "unilib:glass_artisanal_dyed_cyan"
    local c_glass_black = "unilib:glass_artisanal_dyed_black"

    unilib.register_node(
        -- From abriglass:stainedglass_tiles_dark
        "unilib:glass_ornamental_tiles_dark",
        "abriglass:stainedglass_tiles_dark",
        mode,
        {
            description = unilib.brackets(S("Ornamental Glass"), S("Dark Tiles")),
            tiles = {"unilib_glass_ornamental_tiles_dark.png"},
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
        -- From abriglass:stainedglass_tiles_dark
        output = "unilib:glass_ornamental_tiles_dark 7",
        recipe = {
            {c_glass_red, c_glass_green, c_glass_blue},
            {c_glass_yellow, c_glass_magenta, c_glass_cyan},
            {"", c_glass_black, ""},
        },
    })
    unilib.register_craft({
        -- From abriglass:stainedglass_tiles_dark
        type = "cooking",
        output = c_clear,
        recipe = "unilib:glass_ornamental_tiles_dark",
    })

end
