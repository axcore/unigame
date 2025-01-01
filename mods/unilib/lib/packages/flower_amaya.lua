---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_amaya = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_amaya.init()

    return {
        description = "Amaya flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_amaya.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:amaia. Creates unilib:flower_amaya
        part_name = "amaya",
        orig_name = "beautiflowers:amaia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Amaya Flower"),
        dye = "yellow",
    })

end
