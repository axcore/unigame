---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_nadya = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_nadya.init()

    return {
        description = "Nadya flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_nadya.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:nadia. Creates unilib:flower_nadya
        part_name = "nadya",
        orig_name = "beautiflowers:nadia",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Nadya Flower"),
        dye = "red",
    })

end
