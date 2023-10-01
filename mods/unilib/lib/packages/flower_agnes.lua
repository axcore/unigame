---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_agnes = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_agnes.init()

    return {
        description = "Agnes flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_agnes.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:agnes. Creates unilib:flower_agnes
        part_name = "agnes",
        orig_name = "beautiflowers:agnes",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Agnes Flower"),
        dye = "yellow",
    })

end
