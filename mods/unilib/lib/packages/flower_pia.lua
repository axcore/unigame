---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_pia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_pia.init()

    return {
        description = "Pia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_pia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:pia. Creates unilib:flower_pia
        part_name = "pia",
        orig_name = "beautiflowers:pia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 0 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Pia Flower"),
        dye = "pink",
    })

end
