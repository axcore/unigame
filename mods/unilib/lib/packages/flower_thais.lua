---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_thais = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_thais.init()

    return {
        description = "Thais flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_thais.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:thais. Creates unilib:flower_thais
        part_name = "thais",
        orig_name = "beautiflowers:thais",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 7 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Thais Flower"),
        dye = "cyan",
    })

end
