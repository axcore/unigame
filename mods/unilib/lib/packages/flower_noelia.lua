---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_noelia = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_noelia.init()

    return {
        description = "Noelia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_noelia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:noelia. Creates unilib:flower_noelia
        part_name = "noelia",
        orig_name = "beautiflowers:noelia",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Noelia Flower"),
        dye = "red",
    })

end
