---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.glass_clean_round = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.darkage.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.glass_clean_round.init()

    return {
        description = "Clean round glass",
        depends = {"glass_ordinary", "metal_steel"},
    }

end

function unilib.pkg.glass_clean_round.exec()

    local c_glass = "unilib:glass_ordinary"
    local c_ingot = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:glass_clean_round", "darkage:glass_round", mode, {
        -- From darkage:glass_round
        description = S("Clean Round Glass"),
        tiles = {"unilib_glass_clean_round.png"},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "glasslike",
        paramtype = "light",
        sunlight_propagates = true,
        use_texture_alpha = "clip",
    })
    unilib.register_craft({
        -- From darkage:glass_round
        output = "unilib:glass_clean_round 8",
        recipe = {
            {c_ingot, c_glass, c_ingot},
            {c_glass, c_glass, c_glass},
            {c_ingot, c_glass, c_ingot},
        }
    })

end
