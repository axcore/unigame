---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.sand_ordinary_glow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.sand_ordinary_glow.init()

    return {
        description = "Ordinary sand with luminescent bacteria",
        depends = "sand_ordinary",
    }

end

function unilib.pkg.sand_ordinary_glow.exec()

    unilib.register_node("unilib:sand_ordinary_glow", "valleys_c:glowing_sand", mode, {
        -- From valleys_c:glowing_sand
        description = S("Ordinary Sand with Luminescent Bacteria"),
        tiles = {"unilib_sand_ordinary.png"},
        groups = {crumbly = 3, falling_node = 1, sand = 1},
        sounds = unilib.sound_table.sand,

        drop = "unilib:sand_ordinary",
        light_source = 3,
    })

end
