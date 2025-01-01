---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_miriam = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_miriam.init()

    return {
        description = "Miriam flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_miriam.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:miriam. Creates unilib:flower_miriam
        part_name = "miriam",
        orig_name = "beautiflowers:miriam",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Miriam Flower"),
        dye = "violet",
    })

end
