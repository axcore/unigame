---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_nerea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_nerea.init()

    return {
        description = "Nerea flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_nerea.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:nerea. Creates unilib:flower_nerea
        part_name = "nerea",
        orig_name = "beautiflowers:nerea",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Nerea Flower"),
        dye = "red",
    })

end
