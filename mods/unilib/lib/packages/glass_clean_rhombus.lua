---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_clean_rhombus = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_clean_rhombus.init()

    return {
        description = "Clean rhombus glass",
        depends = {"glass_ordinary", "metal_steel"},
    }

end

function unilib.pkg.glass_clean_rhombus.exec()

    local c_glass = "unilib:glass_ordinary"
    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:glass_clean_rhombus", "darkage:glass", mode, {
        -- From darkage:glass
        description = S("Clean Rhombus Glass"),
        tiles = {"unilib_glass_clean_rhombus.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From darkage:glass
        output = "unilib:glass_clean_rhombus 8",
        recipe = {
            {c_glass, c_ingot, c_glass},
            {c_ingot, c_glass, c_ingot},
            {c_glass, c_ingot, c_glass},
        }
    })

end
