---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_suri = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_suri.init()

    return {
        description = "Suri flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_suri.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:suri. Creates unilib:flower_suri
        part_name = "suri",
        orig_name = "beautiflowers:suri",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Suri Flower"),
        dye = "white",
    })

end
