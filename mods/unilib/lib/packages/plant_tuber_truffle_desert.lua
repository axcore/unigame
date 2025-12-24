---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    nsspf
-- Code:    LGPL
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_tuber_truffle_desert = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.nsspf.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_tuber_truffle_desert.init()

    return {
        description = "Desert truffle",
        depends = "shared_nsspf",
    }

end

function unilib.pkg.plant_tuber_truffle_desert.exec()

    unilib.pkg.shared_nsspf.register_truffle({
        -- Code original to unilib, replacing an ABM in the original code. From
        --      nsspf:terfezia_arenaria, creates unilib:plant_tuber_truffle_desert and
        --      unilib:dirt_ordinary_with_mycelium_desert
        part_name = "desert",
        orig_name = "nsspf:terfezia_arenaria",

        replace_mode = mode,
        description = S("Desert Truffle"),
        eat = 12,
        sci_name = "Terfezia arenaria",
    })
    -- (not compatible with flowerpots)

end
