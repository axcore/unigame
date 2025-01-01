---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    valleys_c
-- Code:    GPL 3.0/BSD/WTFPL
-- Media:   GPL 3.0/BSD/WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.clay_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.valleys_c.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.clay_red.init()

    return {
        description = "Red clay",
    }

end

function unilib.pkg.clay_red.exec()

    unilib.register_node("unilib:clay_red", "valleys_c:red_clay", mode, {
        -- From valleys_c:red_clay
        description = S("Red Clay"),
        tiles = {"unilib_clay_red.png"},
        -- N.B. clay = 1 not in original code
        groups = {clay = 1, crumbly = 3},
        sounds = unilib.global.sound_table.dirt,
    })

end
