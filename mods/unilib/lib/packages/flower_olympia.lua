---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_olympia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_olympia.init()

    return {
        description = "Olympia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_olympia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:olimpia. Creates unilib:flower_olympia
        part_name = "olympia",
        orig_name = "beautiflowers:olimpia",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Olympia Flower"),
        dye = "magenta",
    })

end
