---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_clean_square = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_clean_square.init()

    return {
        description = "Clean square glass",
        depends = {"glass_ordinary", "metal_steel"},
    }

end

function unilib.pkg.glass_clean_square.exec()

    local c_glass = "unilib:glass_ordinary"
    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:glass_clean_square", "darkage:glass_square", mode, {
        -- From darkage:glass_square
        description = S("Clean Square Glass"),
        tiles = {"unilib_glass_clean_square.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "glasslike",
        -- N.B. is_ground_content = false not in original code; added to match other glass items
        is_ground_content = false,
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From darkage:glass_square
        output = "unilib:glass_clean_square 8",
        recipe = {
            {c_glass, c_ingot, c_glass},
            {c_ingot, c_ingot, c_ingot},
            {c_glass, c_ingot, c_glass},
        },
    })

end
