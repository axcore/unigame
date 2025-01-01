---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_tuber_truffle_white = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_tuber_truffle_white.init()

    return {
        description = "White truffle",
        depends = {"dirt_ordinary", "shared_nsspf", "tree_apple"},
    }

end

function unilib.pkg.plant_tuber_truffle_white.exec()

    unilib.pkg.shared_nsspf.register_truffle({
        -- Code original to unilib, replacing an ABM in the original code. From
        --      nsspf:tuber_magnatum_pico, creates unilib:plant_tuber_truffle_white and
        --      unilib:dirt_ordinary_with_mycelium_white
        wall_name = "unilib:tree_apple_trunk",
        part_name = "white",
        orig_name = "nsspf:tuber_magnatum_pico",
        surface_list = {"unilib:dirt_ordinary_with_turf"},

        replace_mode = mode,
        description = S("White Truffle"),
        eat = 20,
        sci_name = "Tuber magnatum pico",
    })
    -- (not compatible with flowerpots)

end
