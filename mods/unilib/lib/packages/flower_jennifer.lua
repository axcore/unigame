---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_jennifer = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_jennifer.init()

    return {
        description = "Jennifer flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_jennifer.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:jennifer. Creates unilib:flower_jennifer
        part_name = "jennifer",
        orig_name = "beautiflowers:jennifer",
        select_table = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},

        replace_mode = mode,
        description = S("Jennifer Flower"),
        dye = "orange",
    })

end
