---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_eva = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_eva.init()

    return {
        description = "Eva flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_eva.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:eva. Creates unilib:flower_eva
        part_name = "eva",
        orig_name = "beautiflowers:eva",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Eva Flower"),
        dye = "orange",
    })

end
