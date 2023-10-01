---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_rocio = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_rocio.init()

    return {
        description = "Rocio flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_rocio.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:rocio. Creates unilib:flower_rocio
        part_name = "rocio",
        orig_name = "beautiflowers:rocio",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Rocio Flower"),
        dye = "violet",
    })

end
