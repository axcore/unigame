---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_mireia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_mireia.init()

    return {
        description = "Mireia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_mireia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:mireia. Creates unilib:flower_mireia
        part_name = "mireia",
        orig_name = "beautiflowers:mireia",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Mireia Flower"),
        dye = "red",
    })

end
