---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_anni = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_anni.init()

    return {
        description = "Anni flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_anni.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:any. Creates unilib:flower_anni
        part_name = "anni",
        orig_name = "beautiflowers:any",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Anni Flower"),
        dye = "yellow",
    })

end
