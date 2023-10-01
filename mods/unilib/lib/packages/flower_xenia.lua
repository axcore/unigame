---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_xenia = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_xenia.init()

    return {
        description = "Xenia flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_xenia.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:xenia. Creates unilib:flower_xenia
        part_name = "xenia",
        orig_name = "beautiflowers:xenia",
        select_table = {-0.375, -0.5, -0.375, 0.375, 0.375, 0.375},

        replace_mode = mode,
        description = S("Xenia Flower"),
        dye = "cyan",
    })

end
