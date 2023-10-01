---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_anastasia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_anastasia.init()

    return {
        description = "Anastasia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_anastasia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:anastasia. Creates unilib:flower_anastasia
        part_name = "anastasia",
        orig_name = "beautiflowers:anastasia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Anastasia Flower"),
        dye = "yellow",
    })

end
