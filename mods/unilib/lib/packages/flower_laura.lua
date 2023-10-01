---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beautiflowers
-- Code:    GPLv3.0
-- Media:   CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.flower_laura = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.beautiflowers.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.flower_laura.init()

    return {
        description = "Laura flower",
        optional = "dye_basic",
    }

end

function unilib.pkg.flower_laura.exec()

    unilib.register_beautiflower({
        -- From beautiflowers:laura. Creates unilib:flower_laura
        part_name = "laura",
        orig_name = "beautiflowers:laura",
        select_table = {-2 / 16, -0.5, -2 / 16, 2 / 16, -2 / 16, 2 / 16},

        replace_mode = mode,
        description = S("Laura Flower"),
        dye = "red",
    })

end
