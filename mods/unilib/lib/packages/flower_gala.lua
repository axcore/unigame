---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_gala = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_gala.init()

    return {
        description = "Gala flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_gala.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:gala. Creates unilib:flower_gala
        part_name = "gala",
        orig_name = "beautiflowers:gala",
        select_table = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},

        replace_mode = mode,
        description = S("Gala Flower"),
        dye = "orange",
    })

end
