---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_tuber_truffle_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_tuber_truffle_black.init()

    return {
        description = "Black truffle",
        depends = "shared_nsspf",
    }

end

function unilib.pkg.plant_tuber_truffle_black.exec()

    unilib.pkg.shared_nsspf.register_truffle({
        -- Code original to unilib, replacing an ABM in the original code. From
        --      nsspf:tuber_melanosporum, creates unilib:plant_tuber_truffle_black and
        --      unilib:dirt_ordinary_with_mycelium_black
        part_name = "black",
        orig_name = "nsspf:tuber_melanosporum",

        replace_mode = mode,
        description = S("Black Truffle"),
        eat = 16,
        sci_name = "Tuber melanosporum",
    })
    -- (not compatible with flowerpots)

end
