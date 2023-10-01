---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_ornamental_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_ornamental_yellow.init()

    return {
        description = "Yellow ornamental glass",
        depends = {"glass_artisanal_basic", "glass_artisanal_clear"},
    }

end

function unilib.pkg.glass_ornamental_yellow.exec()

    local c_clear = "unilib:glass_artisanal_clear"
    local c_glass_red = "unilib:glass_artisanal_dyed_red"
    local c_glass_yellow = "unilib:glass_artisanal_dyed_yellow"

    unilib.register_node(
        -- From abriglass:stainedglass_pattern03
        "unilib:glass_ornamental_tiles_yellow",
        "abriglass:stainedglass_pattern03",
        mode,
        {
            description = unilib.brackets(S("Ornamental Glass"), S("Yellow")),
            tiles = {"unilib_glass_ornamental_yellow.png"},
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
    -- N.B. Changed the original craft recipe so it makes a little more sense
    unilib.register_craft({
        -- From abriglass:stainedglass_pattern01
        output = "unilib:glass_ornamental_yellow 9",
        recipe = {
            {c_glass_red, c_glass_yellow, c_glass_red},
            {c_glass_yellow, c_clear, c_glass_yellow},
            {c_glass_red, c_glass_yellow, c_glass_red},
        },
    })
    unilib.register_craft({
        -- From abriglass:stainedglass_pattern03
        type = "cooking",
        output = c_clear,
        recipe = "unilib:glass_ornamental_tiles_yellow",
    })

end
