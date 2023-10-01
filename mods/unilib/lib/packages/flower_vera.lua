---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_vera = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_vera.init()

    return {
        description = "Vera flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_vera.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:vera. Creates unilib:flower_vera
        part_name = "vera",
        orig_name = "beautiflowers:vera",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Vera Flower"),
        dye = "cyan",
    })

end
