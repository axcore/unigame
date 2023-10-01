---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_sandra = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_sandra.init()

    return {
        description = "Sandra flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_sandra.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:sandra. Creates unilib:flower_sandra
        part_name = "sandra",
        orig_name = "beautiflowers:sandra",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Sandra Flower"),
        dye = "pink",
    })

end
