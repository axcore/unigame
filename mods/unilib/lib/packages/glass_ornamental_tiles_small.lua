---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    abriglass
-- Code:    MIT
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_ornamental_tiles_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.abriglass.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_ornamental_tiles_small.init()

    return {
        description = "Ornamental glass with small tiles",
        depends = "glass_artisanal_clear",
    }

end

function unilib.pkg.glass_ornamental_tiles_small.exec()

    local c_clear = "unilib:glass_artisanal_clear"

    unilib.register_node(
        -- From abriglass:stainedglass_pattern02
        "unilib:glass_ornamental_tiles_small",
        "abriglass:stainedglass_pattern02",
        mode,
        {
            description = unilib.brackets(S("Ornamental Glass"), S("Small Tiles")),
            tiles = {"unilib_glass_ornamental_tiles_small.png"},
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
        -- From abriglass:stainedglass_pattern02
        output = "unilib:glass_ornamental_tiles_small 9",
        recipe = {
            {c_clear, c_clear, c_clear},
            {c_clear, c_clear, c_clear},
            {c_clear, c_clear, c_clear},
        },
    })
    unilib.register_craft({
        -- From abriglass:stainedglass_pattern02
        type = "cooking",
        output = c_clear,
        recipe = "unilib:glass_ornamental_tiles_small",
    })

end
