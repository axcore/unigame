---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_quicksand = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_quicksand.init()

    return {
        description = "Quicksand",
        depends = "sand_ordinary",
    }

end

function unilib.pkg.sand_quicksand.exec()

    unilib.register_node("unilib:sand_quicksand", "ethereal:quicksand2", mode, {
        -- From ethereal:quicksand2
        description = S("Quicksand"),
        tiles = {"unilib_sand_ordinary.png^[colorize:#00004F10"},
        groups = {crumbly = 3, disable_jump = 1, liquid = 3, sand = 1},
        sounds = unilib.sound_table.sand,

        climbable = false,
        drawtype = "glasslike",
        drop = "unilib:sand_ordinary",
        drowning = 1,
        liquid_alternative_flowing = "unilib:sand_quicksand",
        liquid_alternative_source = "unilib:sand_quicksand",
        liquid_range = 0,
        liquid_renewable = false,
        liquid_viscosity = 15,
        liquidtype = "source",
        paramtype = "light",
        post_effect_color = {r = 230, g = 210, b = 160, a = 245},
        walkable = false,
    })

end

function unilib.pkg.sand_quicksand.post()

    unilib.register_craft({
        -- From ethereal:quicksand2
        output = "unilib:sand_quicksand",
        recipe = {
            {"group:sand", "group:sand", "group:sand"},
            {"group:sand", "group:water_bucket", "group:sand"},
            {"group:sand", "group:sand", "group:sand"}
        },
        replacements = unilib.water_bucket_list,
    })

end
